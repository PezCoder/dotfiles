## TODO

### Fixes
- sometimes going to a tag using c-] stucks indefinetely - Happening a lot for kotlin & JS project
  - I am using universal tags i think for this? Is there a better alternative?
- To have a convenient vertical small split for running terminal commands or a way to resize
-- TODO: fix leap config in vimrc
- CtrlSF has some issue when searching fix it!
- Fix when selecting visually & pressing <leader>y yanks the whole line
- Change alacrity font based on monitor connected
- Move yabairc & skhdrc within dot files

### Trying currently
- zsh c-x c-e -- seems slow!
- to format json do :%!jq -- can't possibly remember it!

### Features
- Add breakpoints & debugging through vim in JS project
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
