# dotfiles
My Vim &amp; Zsh Configurations

## Install
1. Clone this repository
2. Follow these:

    ```shell
    cd dotfiles
    vi install.sh # Keep only what you need to symlink in DOTS variable
    ./install.sh
    ```
3. My zsh theme is `clean-minimal` which is a mod. of [clean.zsh-theme](https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/clean.zsh-theme) acc to my needs i.e to keep it simple & minimal.

    ```shell
    mkdir $ZSH_CUSTOM/themes # if folder not already there
    cp clean-minimal.zsh-theme $ZSH_CUSTOM/themes
    ZSH_THEME="robbyrussell" # in .zshrc
    ```

## Screenshots
### ZSH + Tmux with custom themes
![Zsh final look](/screenshots/zsh-tmux.png?raw=true "Zsh look with clean-minimal theme")

### VIM with Gruvebox theme
![Vim final look](/screenshots/vim-look.png?raw=true "React code in VIM")

## Checkout wiki for more
[Ctags](https://github.com/PezCoder/dotfiles/wiki/Ctags)

## Docs
[Docs link](./docs)
[Upcoming stuff](./docs/todo.md)
