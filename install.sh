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

is_osx () {
    if [ "$(uname)" == "Darwin" ]; then
        true
    else
        false
    fi
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
    install_ack
    # setup_ctags
    install_plug
    install_tpm
    setup_tmux_clipboard
    confirm_no_clobber
    confirm_have_goodies
    install_scm_breeze
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

# Used by vim.ack plugin to do searching in a project
install_ack () {
  if !(command_exists ack); then
    doo brew install ack
  else
    installed 'ack'
  fi
}

# Install plug for first time if .vim directory doesn't exist
install_plug() {
  FILE=".vim/autoload/plug.vim"
  if [ ! -f "$FILE" ]; then
    doo curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  else
    installed 'Plug'
  fi
}

install_tpm() {
  DIR=".tmux/plugins/tpm"
  if [ ! -d "$DIR" ]; then
    doo git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins
  else
    installed 'TPM'
  fi
}

setup_tmux_clipboard() {
  if is_osx && !(command_exists reattach-to-user-namespace); then
    doo brew install reattach-to-user-namespace
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

install_scm_breeze() {
  DIR='scm_breeze'
  if [ ! -d ".$DIR" ]; then
    doo git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
    doo ~/.scm_breeze/install.sh
  else
    installed 'scm_breeze'
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
    # vim
    vimrc
    # zshrc
    # config
    # tmux.conf
    # tmux-osx.conf
    # tern-config
    # ackrc
)

# Fire missiles
main
