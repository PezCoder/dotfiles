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
    install_zsh
    install_rg
    install_universal_ctags
    setup_ctags
    install_plug
    install_tmux
    install_tpm
    install_tmuxinator
    confirm_no_clobber
    confirm_have_goodies
    install_scm_breeze
    install_diff-so-fancy
    install_alacritty
    install_fzf
    for i in ${DOTS[@]}; do
        link_dot $i
    done
    install_neovim
    setup_git_global_ignore
    setup_window_tiling
}

install_zsh() {
    if !(command_exists zsh); then
        doo apt-get install zsh --assume-yes
        doo chsh -s /bin/zsh
    else
        installed 'zsh'
    fi

    # Install oh-my-zsh
    DIR="/Users/$USER/.oh-my-zsh"
    if [ ! -d "$DIR" ]; then
        # https://github.com/ohmyzsh/ohmyzsh#unattended-install
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        # Remove zshrc created by oh-my-zsh by default because we have our own
        doo rm -rf ~/.zshrc
        # Setup theme in oh-my-zsh
        doo cp "$EXPORT_DIR/themes/clean-minimal.zsh-theme" ~/.oh-my-zsh/themes/clean-minimal.zsh-theme

        # Install zsh-autosuggestions plugin
        doo git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    else
        installed 'oh-my-zsh'
    fi
}

install_universal_ctags () {
  if !(command_exists uctags); then
      # requirements
      if !(command_exists automake); then
          doo brew install automake
      fi
      if !(command_exists pkg-config); then
          doo brew install pkg-config
      fi
      if !(command_exists libxml2); then
          doo brew install libxml2
      fi
      # Troubleshooting tips: If "error undefined macro AC_MSG_ERRO" error
      # https://github.com/pooler/cpuminer/issues/74
      # doo sudo apt-get install libcurl4-openssl-dev --assume-yes

      doo git clone https://github.com/universal-ctags/ctags.git
      doo cd ctags
      doo ./autogen.sh
      doo ./configure --program-prefix=u
      doo make
      # If fails for ex: in docker, try removing sudo
      doo sudo make install
      doo cd ..
      doo rm -rf ctags
  else
    installed 'Universal-ctags'
  fi
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

# ripgrep search, faster than ack, ag, silver surfer etc.
# Used by ctrlsf.vim plugin to do searching words in a project
install_rg () {
  if !(command_exists rg); then
    doo brew install ripgrep
  else
    installed 'rg'
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

install_tmux () {
  if !(command_exists tmux); then
    doo brew install tmux
  else
    installed 'tmux'
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

install_tmuxinator () {
  # Tmuxinator requires a higher ruby version
  # Using rbenv to manage ruby version for the root directory
  if !(command_exists rbenv); then
      doo brew install rbenv
      doo rbenv install 2.6.10
      doo rbenv local 2.6.10
  else
      installed 'rbenv'
  fi

  if !(command_exists tmuxinator); then
    doo sudo gem install tmuxinator
  else
    installed 'tmuxinator'
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
    doo git clone https://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
    doo ~/.scm_breeze/install.sh
  else
    installed 'scm_breeze'
  fi
}

install_diff-so-fancy() {
  if !(command_exists diff-so-fancy); then
    doo brew install diff-so-fancy
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
    git config --bool --global diff-so-fancy.markEmptyLines false
  else
    installed 'diff-so-fancy'
  fi
}

install_neovim() {
  if !(command_exists nvim); then
    # TODO: Update this, Currently I just download the binary from neovim,
    # put that in ~/Downloads/<here> & source it via ~/.zshrc
    doo brew install neovim/neovim/neovim
    doo ln -s ~/.vim ~/.config/nvim
    doo ln -s ~/.vimrc ~/.config/nvim/init.lua
    doo ln -s "$EXPORT_DIR/config/coc-settings.json" ~/.vim/coc-settings.json
    doo pip3 install --user pynvim

    doo ln -s "$EXPORT_DIR/lua" ~/.vim/lua
  else
    installed 'neovim'
  fi
}

setup_window_tiling() {
  # Setup borders for our windows - helps with identifying window focus
  # Configured by yabairc
  if !(command_exists border); then
    doo brew tap FelixKratz/formulae
    doo brew install borders
    doo brew services start borders
  fi

  # Setup tiling manager with yabai
  if !(command_exists yabai); then
    doo brew install koekeishiya/formulae/yabai
    doo mkdir -p .config/yabai
    doo ln -s "$EXPORT_DIR/config/yabairc" ~/.config/yabai/yabairc
    doo yabai --start-service
  else
    installed 'yabai'
  fi

  # Setup shortcuts using skhd
  if !(command_exists skhd); then
    doo brew install skhd
    doo mkdir -p .config/skhd
    doo ln -s "$EXPORT_DIR/config/skhdrc" ~/.config/skhd/skhdrc
    doo skhd --start-service
  else
    installed 'skhd'
  fi
}

# https://github.com/alacritty/alacritty#macos
# Alacritty helpful links:
# Setup italics: https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/
# Ligature for operator mono: https://github.com/kiliman/operator-mono-lig
install_alacritty() {
  if !(command_exists alacritty); then
    doo brew install alacritty --cask

    # clone
    doo git clone https://github.com/alacritty/alacritty.git
    doo cd alacritty

    # Not needed to be set anymore, seem to be working by default since 0.12 version
    # https://github.com/alacritty/alacritty/blob/master/INSTALL.md#terminfo
    # Install terminfo globally, I'm thinking this is to make the awesome
    # true colors & italic fonts work
    # We also change default terminal to alacritty in ~/.tmux.conf to use this
    # doo sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

    # clean
    doo cd ..
    doo rm -rf alacritty

    # Symlink config file
    doo mkdir -p .config/alacritty
    doo ln -s "$EXPORT_DIR/config/alacritty.yml" ~/.config/alacritty/alacritty.yml

    # Enable smoothing on mac
    doo defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
    doo defaults -currentHost write -globalDomain AppleFontSmoothing -int 2
  else
    installed 'alacritty'
  fi
}

install_fzf() {
  if !(command_exists fzf); then
    doo brew install fzf
  else
    installed 'fzf'
  fi
}

link_dot() {
    src=$1
    dst=.$1
    doo rm -f $dst
    doo ln -s $EXPORT_DIR/$src $dst
}

setup_git_global_ignore() {
    doo git config --global core.excludesfile ~/.gitignore_global
}

# Initialize globals
EXPORT_DIR=$(dirname "${PWD}/$0")
DOTS=(
    vimrc
    zshrc
    tmux.conf
    tmux-theme.conf
    tern-config
    ackrc
    gitignore_global
)

# Fire missiles
main
