#!/bin/bash

set -e

# Utility functions

## For ease of iterative experimentation
doo () {
    $@
    # echo $@
}

command_exists () {
  type "$1" &> /dev/null ;
}

installed () {
  echo -e " ✓ $1 already installed."
}

# This function was originally named errm to be short for "error message", but
# then I realized that it sounds like a person saying, "Errm, excuse me, I don't
# think that's what you meant to do."
errm () {
    2>&1 echo -e "$@"
}

# START HERE.
main () {
    cd $HOME
    install_ag
    setup_ctags
    install_vundle
    confirm_no_clobber
    confirm_have_goodies
    for i in ${DOTS[@]}; do
        link_dot $i
    done
    # TODO: Make sure permissions are legit. .ssh and .ghci, I'm lookin at you.
}

setup_ctags () {
  SRC="git_template"
  DEST=.$SRC
  if [ ! -d ".$SRC" ]; then
    git config --global init.templatedir '~/.git_template'
    git config --global alias.ctags '!.git/hooks/ctags'
    doo cp -R $EXPORT_DIR/$SRC $DEST
  else
    installed 'ctags git hooks'
  fi
}

install_ag () {
  if !(command_exists ag); then
    doo brew install the_silver_searcher
  else
    installed 'ag'
  fi
}

# Install vundle for first time if .vim directory doesn't exist
install_vundle() {
  DIRECTORY=".vim"
  if [ ! -d "$DIRECTORY" ]; then
    doo git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  else
    installed 'vundle'
  fi
}

# Subroutines
confirm_no_clobber() {
    NOTADOT=''

    for i in ${DOTS[@]}; do
        dst=.$i
        if [ ! -L $dst -a -e $dst ]; then
            NOTADOT="${NOTADOT}$dst "
        fi
    done

    if [ -n "$NOTADOT" ]; then
        errm "\n  ABORT"
        errm "\n  These exist but are not symlinks:"
        errm "    $NOTADOT"
        exit 2
    fi
}

confirm_have_goodies() {
    NOFINDINGS=''

    if [ ! -e "$EXPORT_DIR" ]; then
        errm "\n  ABORT\n\n  Where ya gonna copy them files from again?"
        errm "    Couldn't find export dir: '$EXPORT_DIR'"
        exit 2
    fi

    for i in ${DOTS[@]}; do
        goody="$EXPORT_DIR/$i"
        # Exists, is readable?
        if [ ! -r "$goody" ]; then
            NOFINDINGS="${NOFINDINGS}$i"
        # Searchable if directory?
        elif [ -d "$goody" -a ! -x "$goody" ]; then
            NOFINDINGS="${NOFINDINGS}$i"
        fi
    done

    if [ -n "$NOFINDINGS" ]; then
        errm "\n  ABORT\n\n  These goodies don't exist in a state we can use!"
        errm "    $NOFINDINGS"
        exit 2
    fi
}

link_dot() {
    src=$1
    dst=.$1
    doo rm -f $dst
    doo ln -s $EXPORT_DIR/$src $dst
}

# Initialize globals
EXPORT_DIR=$(dirname "${PWD}/$0")
DOTS=(
    vim
    vimrc
    zshrc
    config
)

# Fire missiles
main
