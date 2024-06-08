## TODO

### Fixes
- Fix gbrowse for stash repos - configure
  - mobiushorizons/fugitive-stash.vim
- Setup copilot key bindings
- 'dynamic-import-chunkname' is not found within marketplace-frontend using ctrlsf, find out why?
- Change alacrity font based on monitor connected

### Trying currently
- zsh c-x c-e -- this sucks
  - zsh-vi-mode is slow in big repos, debug why.

### Features
- LUA Migrate: https://atlassian.slack.com/archives/CFJ97E79C/p1675032963401039
- EMACS - ORG Mode
  - https://orgmode.org/ - About EMACS org mode
  - https://github.com/nvim-orgmode/orgmode
  - https://github.com/nvim-neorg/neorg
- Explore for git - https://magit.vc/
- Project wide commands ex: <leader>pb -> to build a project

### Improvements
- Accept incoming change in merge conflicts ex: backmerge, accept master change for a particular file
- Find and replace in the repository
  - Internally wants to use 'rg' like I'm using currently - TODO
  - Finding within a pattern of if possible -- DONE
  Explore: https://github.com/dyng/ctrlsf.vim
  - Be able to search within node_modules when needed ex': @see SentryClient' - DONE
  - To be able to replace
  - Quickfix list ]q is not in sync with the ctrlf window that opens

- Paste enhancement: https://github.com/hrsh7th/nvim-pasta

- Explore toolings from:
https://hello.atlassian.net/wiki/spaces/~tmarra/blog/2022/06/17/1758609212/Setting+up+some+tools+to+make+development+a+bit+easier

- Explore elihunter173/dirbuf.nvim

### Themes to explore
https://vimcolorschemes.com/ - Some interesting schemes

https://rosepinetheme.com/
- Very high contrast (main & moon both)
- Lightline isn't very pretty, the buffer & light line
- ZSH doesn't have the theme, only tmux wasn't great also

https://draculatheme.com/
- Too much green, VIM version itself doesn't look great

https://vimcolorschemes.com/alexvzyl/nordic.nvim - Trying currently
- Support for alacritty: https://github.com/AlexvZyl/nordic.nvim/issues/78
- TODO: Fix tmux bar background to be one of nordic colors
- TODO: gs has all files as green, fix it!

Zenburn - to explore - firoz suggested
Tokyonight.nvim - seemed minimal in a youtube video, can be explored in future if I'm bored with current one
