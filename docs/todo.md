## TODO
- 20% of improvements to do - file:///Users/rahul.gupta/Downloads/neovim-optimization-report.html

READ THIS:
- I've spent 2-3 hours on making ctrl-space work & also padding stuff on c-i - Please DO NOT spend more time on this
Know when to give up

- Modern way to improve speed of huge UCTags (this is useful till the LSP is loading to make c-] jump faster)

LSP setup leftover things (https://github.com/PezCoder/dotfiles/pull/3/changes)
- Quitting vim takes forever now, have to force kill (Difficult to debug)
- TSGO readiness live notifiication (does not exist yet in their LSP don't fire $/progress)
- Minor - References don't show the live preview when going up & down in the location list
- Minor UI: Leader improvements
  - The width & height can be huge, make it limited
  - Make it scrollable when it's large

TMUX improvements
- shows volta-shim for when i run claude, figure out why
  - make the tmux window title automatic & accurate

### Fixes

### Trying currently
- Practice jump feature more
- LSP Setup

### Features

### Improvements
- Find and replace in the repository
  - Internally wants to use 'rg' like I'm using currently - TODO
  - Finding within a pattern of if possible -- DONE
  Explore: https://github.com/dyng/ctrlsf.vim
  - Be able to search within node_modules when needed ex': @see SentryClient' - DONE
  - To be able to replace
  - Quickfix list ]q is not in sync with the ctrlf window that opens

### Themes history
https://rosepinetheme.com/
- Very high contrast (main & moon both)
- Lightline isn't very pretty, the buffer & light line
- ZSH doesn't have the theme, only tmux wasn't great also

https://draculatheme.com/
- Too much green, VIM version itself doesn't look great

Tokyonight.nvim - seemed minimal in a youtube video, can be explored in future if I'm bored with current one
