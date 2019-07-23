# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="clean-minimal"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting z docker docker-compose)

# User configuration
export PATH="$PATH:/usr/local/mysql/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

source $ZSH/oh-my-zsh.sh

source ~/.fzf.zsh


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

# Use Neovim instead of Vim or Vi
# alias vim=nvim
alias vi='exec_scmb_expand_args nvim'
alias rc='vi ~/.vimrc'

# Use Neovim as "preferred editor"
export VISUAL=nvim
export EDITOR="$VISUAL"

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


# Not sourcing nvm but loading on demand when it's used for the first time
# as it adds up 40ms to shell load time
# http://broken-by.me/lazy-load-nvm/
# Old code:
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
nvm() {
    unset -f nvm
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
    nvm "$@"
}
node() {
    unset -f node
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
    node "$@"
}
npm() {
    unset -f npm
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
    npm "$@"
}


# to use brew command [linuxbrew]
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

# Export colors for tmux
export TERM=xterm-256color
export PATH="/usr/local/sbin:$PATH"

# For udemy clas on data structures
export CLASSPATH=$CLASSPATH:~/Downloads/algs4.jar

# Fixes https://discourse.brew.sh/t/failed-to-set-locale-category-lc-numeric-to-en-ru/5092/6
# which occurs when launching VIM. Root cause - unknown
export LC_ALL=en_US.UTF-8

# Needed for scm breeze
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
# for scm breeze (git shortcuts plugin)
[ -s "/Users/pezcoder/.scm_breeze/scm_breeze.sh" ] && source "/Users/pezcoder/.scm_breeze/scm_breeze.sh"
