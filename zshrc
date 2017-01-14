# Path to your oh-my-zsh installation.
export ZSH=/Users/PezCoder/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man colorize github jira vagrant virtualenv pip python brew osx zsh-syntax-highlighting)

# User configuration
export PATH="/usr/local/mysql/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

source $ZSH/oh-my-zsh.sh


######### ALIAS

# Use sublimetext for editing config files
alias zshconfig="vi ~/.zshrc"
# to use mysql command from terminal
export PATH="/usr/local/mysql/bin:$PATH"
# launch chrome without web security
alias chromews='open -a Google\ Chrome --args --disable-web-security'
alias v='nvim'
alias vus='cd ~/1conf;vagrant up;vagrant ssh'
alias vs='cd ~/1conf;vagrant ssh'

# Symfony aliases
alias cc="app/console cache:clear"
alias adump="app/console assetic:dump"
alias cinstall="composer install"

# Base16 Shell (Needed for correct colors in base16 material theme)
# BASE16_SHELL="$HOME/.config/base16-shell/base16-material.dark.sh"
BASE16_SHELL="$HOME/.config/oceanic-next-shell/oceanic-next.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

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
