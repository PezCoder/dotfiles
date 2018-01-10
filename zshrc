# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="clean-minimal"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man colorize github jira vagrant virtualenv pip python brew osx zsh-syntax-highlighting z)

# User configuration
export PATH="$PATH:/usr/local/mysql/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

source $ZSH/oh-my-zsh.sh


######### ALIAS

# to use mysql command from terminal
export PATH="/usr/local/mysql/bin:$PATH"
# launch chrome without web security
alias chromews='open -a Google\ Chrome --args --disable-web-security'
alias vus='cd ~/1conf;vagrant up;vagrant ssh'
alias vs='cd ~/1conf;vagrant ssh'

# Symfony aliases
alias cc="app/console cache:clear"
alias adump="app/console assetic:dump"
alias cinstall="composer install"
alias vi='vim' # Launch brew's vim with vi command
alias rc='vi ~/.vimrc'

# vim command will now launch vim in different type of modes
function vim() {
    if test $# -gt 0; then
        # with options provided
        env vim "$@"
    elif test -f ~/.vim/Session.vim; then
        # to restore previous session if exist
        env vim -S ~/.vim/Session.vim
    else
        # with start recording the session
        env vim -c 'Obsession ~/.vim/Session.vim'
    fi
}

# Base16 Shell (Needed for correct colors in base16 material theme)
# BASE16_SHELL="$HOME/.config/base16-shell/base16-material.dark.sh"
# BASE16_SHELL="$HOME/.config/oceanic-next-shell/oceanic-next.dark.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Bind ctrl-z to switch between vim & terminal
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# fix terminals to send ctrl-h to neovim correctly
[[ -f "~/.$TERM.ti" ]] && tic ~/.$TERM.ti

# to run cpp program
makeAndRunCpp() {
    make $1 > /dev/null
    ./$1
}
alias run=makeAndRunCpp
alias composer="php /usr/local/bin/composer.phar"

# Git grep alias
runGitGrep() {
  git grep -i "$1"
}
alias gg=runGitGrep

export NVM_DIR="/home/vagrant/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# to use brew command [linuxbrew]
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

# Export colors for tmux
export TERM=xterm-256color
export PATH="/usr/local/sbin:$PATH"
export EDITOR=vim

# Needed for scm breeze
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
# for scm breeze (git shortcuts plugin)
[ -s "/Users/pezcoder/.scm_breeze/scm_breeze.sh" ] && source "/Users/pezcoder/.scm_breeze/scm_breeze.sh"
