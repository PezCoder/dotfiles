# Dotfiles Repository - Context & Documentation

## Purpose

This repository contains personal laptop setup configurations designed to provide a consistent development environment across different machines and companies. The setup is optimized for a Neovim + Zsh + Tmux workflow with macOS window management via Yabai.

**Primary use case**: Weekend improvements and troubleshooting of workflow bottlenecks that arise during daily development work.

---

## Core Tool Versions

### Primary Tools
- **Neovim**: v0.12.0-dev-893+g6190b6bc1d
  - Custom binary installed from `~/Downloads/nvim-macos/bin`
  - Configured via Lua (vimrc is actually init.lua)
- **Zsh**: 5.9 (arm64-apple-darwin24.0)
  - Oh-My-Zsh framework
  - Custom theme: `clean-minimal`
- **Tmux**: 3.5a
  - Custom prefix: `\` (backslash)
  - TPM (Tmux Plugin Manager)
- **Alacritty**: GPU-accelerated terminal emulator
  - Operator Mono with ligatures
  - Nordic color scheme support

### Window Management
- **Yabai**: BSP tiling window manager
- **skhd**: Simple Hotkey Daemon for keyboard shortcuts
- **borders**: FelixKratz/JankyBorders for visual window focus

### Search & Navigation
- **ripgrep** (rg): Fast text search
- **fzf**: Fuzzy file finder
- **universal-ctags** (uctags): Code navigation tags
- **scm_breeze**: Git shortcuts and workflow enhancements

---

## Repository Structure

```
dotfiles/
├── .claude/                    # Claude Code project configuration
├── config/                     # Application-specific configurations
│   ├── alacritty.yml          # Terminal emulator config
│   ├── base16-shell/          # Git submodule: base16 themes
│   ├── oceanic-next-shell/    # Git submodule: oceanic-next theme
│   ├── coc-settings.json      # CoC LSP settings (symlinked to ~/.vim/)
│   ├── com.googlecode.iterm2.plist  # iTerm2 config (legacy)
│   ├── skhdrc                 # Keyboard shortcut definitions
│   └── yabairc                # Window manager configuration
├── docs/                       # Documentation
│   ├── other-tools.md         # Additional tools reference
│   └── todo.md                # Weekend improvement backlog
├── fonts/                      # Font files (gitignored)
│   ├── OpenType/              # Operator Mono with ligatures
│   └── inconsolata-font/      # Inconsolata Powerline
├── git_template/               # Git hooks for automatic ctags
│   └── hooks/                 # post-commit, post-checkout, etc.
├── lua/                        # Lua modules for Neovim
│   ├── find_replace.lua       # Find & replace utilities
│   ├── lsp.lua                # LSP config (commented out, using CoC)
│   └── utils.lua              # Key mapping utilities
├── screenshots/                # README screenshots
├── themes/                     # Custom themes
│   ├── clean-minimal.zsh-theme  # Minimal zsh prompt
│   └── gruvbox-dark.itermcolors # iTerm2 legacy theme
├── ackrc                       # Ack search tool config
├── brew.sh                     # Homebrew reinstall script
├── gitignore_global            # Global git ignore patterns
├── install.sh                  # Main setup automation script
├── README.md                   # Basic installation docs
├── tern-config                 # Tern.js config (legacy)
├── tmux.conf                   # Tmux configuration (92 lines)
├── tmux-theme.conf             # Custom tmux theme
├── vimrc                       # Neovim configuration (933 lines)
└── zshrc                       # Zsh configuration (295 lines)
```

---

## Neovim Configuration Deep-Dive

### Plugin Management
- **Manager**: vim-plug
- **Total plugins**: 40+
- **Plugin directory**: `~/.vim/plugged`

### LSP & Completion
**CoC (Conquer of Completion)** - Primary LSP client
- Language servers installed:
  - `coc-tsserver` - TypeScript/JavaScript
  - `coc-pyright` - Python
  - `coc-go` - Go
  - `coc-kotlin` - Kotlin
  - `coc-json`, `coc-css`, `coc-html` - Web
  - `coc-styled-components` - CSS-in-JS
  - `coc-docker` - Dockerfile
  - `coc-yaml` - YAML (Kubernetes config support)
  - `@yaegassy/coc-tailwindcss3` - Tailwind CSS

**AI Completion**: Windsurf.vim (Codeium)
- Accept suggestion: `Ctrl-e`
- Previously used GitHub Copilot (now disabled)

**Experimental**: tsgo LSP for TypeScript (web-ui specific)

### Key Features by Category

#### Navigation & Search
- **fzf-lua**: Fuzzy file/buffer/tag finder (migrated from fzf.vim 2026-01-03)
  - `Ctrl-p`: Find files (git-aware, non-blocking)
  - `<leader>p`: Switch buffers
  - `<leader>l`: Search lines in current buffer
- **ctrlsf.vim**: Project-wide text search & replace
  - `<leader>/`: Search in project (uses ripgrep)
  - Quick fix integration
  - Compact view mode
- **leap.nvim**: Fast motion plugin
  - `<leader>j`: Leap forward
  - `<leader>k`: Leap backward
- **universal-ctags**: Code navigation
  - Auto-generates tags via git hooks
  - `Ctrl-]`: Jump to definition (uses CoC's tagfunc)
  - `gr`: Find references

#### Git Integration
- **vim-fugitive**: Core git commands
  - `:Git blame` (aliased to `:gb`)
  - `:GBrowse` - Open in browser
- **fugitive-gitlab.vim**: GitLab support (Roku domain configured)
- **vim-gitgutter**: Show git diff in sign column
  - `]g` / `[g`: Next/previous hunk
  - `<leader>ga`: Stage hunk
  - `<leader>gu`: Undo hunk
  - `<leader>gs`: Preview hunk
  - Update time: 100ms (very responsive)
- **vim-rhubarb**: GitHub `:GBrowse` support

#### UI & Appearance
- **Theme**: Nordic (AlexvZyl/nordic.nvim)
  - Previously: Gruvbox, Base16 Material, Oceanic Next
  - Custom overrides for visual selection and cursorline visibility
- **lightline.vim**: Minimal status line
  - Colorscheme: nord
  - Shows: mode, git branch, relative path, CoC status
  - ALE linting indicators
  - Buffer list in tabline
- **vim-startify**: Start screen with sessions
  - Sessions directory-scoped (not VCS root for monorepo compatibility)
  - Persistent sessions: `:SS` to save
- **nvim-colorizer.lua**: Highlight color codes (CSS, YAML)

#### Code Editing
- **nvim-treesitter**: Syntax highlighting & indentation
  - Parsers: JavaScript, TypeScript, GraphQL, Lua, C, Vim
  - Auto-install enabled
- **vim-surround**: Change surrounding quotes/brackets
- **vim-commentary**: Toggle comments
- **auto-pairs-gentle**: Auto-close brackets (fork for multiline support)
- **vim-move**: Move blocks up/down (Ctrl+j/k in visual mode)
- **vim-argwrap**: Format function arguments
  - `<leader>fa`: Toggle argument wrapping
- **vim-exchange**: Swap two text objects (`cx{motion}` + `.`)
- **vim-visual-multi**: Multi-cursor support
  - `Ctrl-n`: Add cursor at next match
  - `q`: Skip a match

#### Linting & Formatting
- **ALE (Asynchronous Lint Engine)**
  - Auto-fix on save enabled
  - JavaScript/TypeScript: prettier + eslint
  - Python: yapf
  - CSS/SCSS: prettier
  - GraphQL: prettier
  - No text-changed linting (performance)
  - Virtual text disabled

#### File Management
- **vim-floaterm**: Floating terminal with nnn
  - `-`: Open nnn file browser
  - `Esc`: Close floaterm
- **vim-eunuch**: Unix file operations
  - `:Delete!`: Delete file
  - `:Rename`: Rename file
  - `:Move`: Move file
- **auto-create-directory.nvim**: Auto-create parent directories on save

#### Other Utilities
- **vimux**: Tmux integration for running commands
- **vim-notes**: Note-taking (directory: ~/Downloads/VimNotes)
- **notational-fzf-vim**: Fast note search
  - `<leader>n`: Search notes
- **vim-markdown-preview**: GitHub-flavored markdown preview
  - Uses grip + Arc browser
  - `<leader>m`: Toggle preview
- **vim-tmux-navigator**: Seamless vim/tmux pane navigation
  - `Ctrl-h/j/k/l`: Navigate across vim splits and tmux panes

### Key Mappings

**Leader key**: `<Space>`

#### Core Navigation
- `j/k`: Move by display lines (wrapped)
- `H`: Go to line start (^)
- `L`: Go to line end ($)
- `Ctrl-h/j/k/l`: Navigate splits/tmux panes
- `[b / ]b`: Previous/next buffer
- `[q / ]q`: Previous/next quickfix item
- `[w / ]w`: Previous/next location list item
- `[t / ]t`: Previous/next tab
- `[g / ]g`: Previous/next git hunk
- `n / N`: Always search forward/backward (direction-aware)

#### Leader Commands
- `<leader>w`: Save file
- `<leader>q`: Save all and quit
- `<leader>v`: Vertical split
- `<leader>s`: Horizontal split
- `<leader>c`: Close window
- `<leader>z`: Zoom toggle (maximize/restore window)
- `<leader>ev`: Edit vimrc
- `<leader>et`: Edit todo.md
- `<leader>y`: Copy to system clipboard (visual mode)
- `<leader>cy`: Copy file path with line range in format `@file#L1-99` (visual mode)
- `<leader>i`: Show documentation (CoC hover)
- `<leader>rn`: Rename symbol (CoC)
- `<leader>fa`: Format arguments (argwrap)
- `<leader>m`: Markdown preview
- `<leader>n`: Search notes
- `<leader>p`: Buffer list
- `<leader>l`: Search lines in buffer
- `<leader>/`: Project-wide search (ctrlsf)
- `<leader>j`: Leap forward
- `<leader>k`: Leap backward
- `<leader>ga`: Git stage hunk
- `<leader>gu`: Git undo hunk
- `<leader>gs`: Git preview hunk
- `<Space><Space>`: Clear search highlights

#### Insert Mode
- `Tab`: CoC next suggestion
- `Shift-Tab`: CoC previous suggestion
- `Enter`: Accept CoC suggestion
- `Ctrl-space`: Trigger CoC completion / code action
- `Ctrl-e`: Accept Windsurf AI suggestion

#### Command Mode Abbreviations
- `:note` → `:Note`
- `:bd` → `:bd` (all variants work)
- `:gb` → `:Git blame`
- `:gbrowse` → `:GBrowse`
- `:rm` → `:Delete!`
- `:rn` → `:Rename`
- `:mv` → `:Move`
- `:chrome` → `:Chrome` (open in Chrome)
- `:arc` → `:Arc` (open in Arc)

#### Special Features
- Visual mode `@`: Execute macro on selected lines
- `Y`: Yank to end of line (like D and C)
- `Ctrl-u`: Uppercase word under cursor
- `Ctrl-]`: Smart tag jump (uses CoC)
- `gt`: Go to type definition (CoC)
- `gr`: Find references (CoC)
- `z=`: Auto-correct to first spelling suggestion (markdown files)

### Configuration Highlights

**Performance optimizations**:
- No swap files (noswapfile)
- No backup files (nobackup)
- Update time: 100ms (for gitgutter responsiveness)
- Undo file persistence (undofile)
- Hidden buffers (can hide unsaved buffers)

**Editor behavior**:
- 4-space indentation (expandtab)
- Smart case search (ignorecase + smartcase)
- Global substitute by default (gdefault)
- Line numbers: Disabled (cleaner look)
- Mouse: Disabled
- Live substitute preview (inccommand=nosplit)
- Cursorline with true colors
- Visual bell (no audio)

**File type specifics**:
- JavaScript/TypeScript: 2-space indentation
- CSS/SCSS: Hyphenated words treated as single word
- Markdown: Spell check enabled
- PHP: Custom syntax loading

---

## Zsh Configuration Deep-Dive

### Theme
**clean-minimal** (custom modification)
- Blue directory
- Yellow git branch
- Red/tilde for git status
- Minimal, no clutter

### Vi Mode
- **Enabled by default** with custom key bindings
- Mode indicator: Yellow `[NORMAL]` prompt on right side
- Vim key timeout: 1ms (instant mode switching)

**Non-vi keybindings preserved**:
- `Ctrl-p`: Up history
- `Ctrl-n`: Down history
- `Ctrl-w`: Backward kill word
- `Ctrl-r`: FZF history search
- `Ctrl-e`: End of line
- `Ctrl-a`: Beginning of line
- `Ctrl-u`: Backward kill line
- `Ctrl-y`: Yank
- `Ctrl-z`: Fancy toggle (switch between vim and shell)

### Plugins
- **git**: Git aliases and functions
- **z**: Jump to frequently used directories
- **docker**: Docker command completion
- **docker-compose**: Docker Compose completion
- **zsh-autosuggestions**: Fish-like suggestions (Ctrl-e to accept)

### Key Features

**FZF Integration**:
- Sourced with `fzf --zsh`
- `Ctrl-r`: History search
- Used by vim for file finding

**Git Helpers**:
- `glb`: List last 7 branches by commit date (reversed)
- `gg <pattern>`: Git grep (case-insensitive)
- `openpr`: Open GitHub PR for current branch against preprod (Datadog-specific)

**Fancy Ctrl-Z**:
- Empty buffer: Brings vim to foreground (`fg`)
- Non-empty buffer: Pushes input and clears screen
- Seamless vim/shell switching

**NVM**:
- Loaded synchronously (40ms load time accepted)
- Lazy-loading code commented out

**Aliases**:
- `vi`: Neovim with scm_breeze expansion
- `rc`: Edit vimrc
- `tx`: tmuxinator
- `composer`: PHP composer

### Environment Variables

**Neovim**:
- `VISUAL=nvim`
- `EDITOR=nvim`
- Binary path: `~/Downloads/nvim-macos/bin`

**Node/JavaScript**:
- `NODE_OPTIONS="--max-old-space-size=40000"` (40GB heap)
- Yarn bin in PATH

**Datadog-specific** (configured via Ansible):
- `GOPATH=~/go`
- `DATADOG_ROOT=~/dd`
- `GOPRIVATE=github.com/DataDog`
- `GOPROXY=binaries.ddbuild.io,https://proxy.golang.org,direct`
- AWS Vault keychain: login
- AWS session TTL: 24h
- Helm driver: configmap
- `GO111MODULE=auto`

**Python**:
- `pyenv` initialized
- Path: `~/Library/Python/2.7/bin` and `~/Library/Python/3.7/bin`

**Ruby**:
- `rbenv` initialized (needed for tmuxinator)
- RVM in PATH

**Other**:
- `direnv` hook enabled (end of file for proper precedence)
- Bazel completion enabled
- SSH key auto-load for gitsign

### Performance
- `zprof` and `timezsh` debug helpers available (commented out)
- Total shell load time: ~150ms (acceptable)

---

## Tmux Configuration Deep-Dive

### Basic Setup
- **Prefix**: `\` (backslash) instead of `Ctrl-b`
- **Escape time**: 1ms (no vim interference)
- **History limit**: 50,000 lines
- **Display time**: 2000ms
- **Base index**: 1 (windows and panes start at 1)
- **Status interval**: 1 second

### Key Bindings

**Prefix = `\`**

#### Pane Management
- `\ v`: Vertical split (opens in current path)
- `\ s`: Horizontal split (opens in current path)
- `\ c`: New window (opens in current path)
- `\ h/j/k/l`: Resize pane (repeatable, 5 cells at a time)
- `Ctrl-h/j/k/l`: Navigate panes (vim-aware via vim-tmux-navigator)

#### Session Management
- `\ a`: Choose session tree (replaces default `\ s`)
- `\ r`: Reload tmux config

#### Copy Mode
- `\ ]`: Enter copy mode (instead of `[`)
- `v`: Begin selection (vi mode)
- `y`: Copy selection and exit
- Vi mode keys: `hjkl` navigation

#### Pomodoro Timer
- `\ t`: Toggle pomodoro (start/pause)
- `\ T`: Cancel pomodoro
- Auto-repeat enabled
- Desktop notifications: on
- Sound: "Pop"

### Plugins (TPM)
- **tmux-mode-indicator**: Shows current mode (prefix, copy, etc.)
- **tmux-pomodoro-plus**: Productivity timer with notifications
  - 🍅 emoji when running
  - ⏸︎ when paused
  - 🌴 when complete

### Theme
- Custom theme from `tmux-theme.conf` (olimorris/dotfiles inspired)
- Nordic color palette integration (matches vim)

### Integration
- **vim-tmux-navigator**: Seamless split navigation
  - `Ctrl-h/j/k/l` works across vim splits and tmux panes
  - Smart detection of vim process
- **True color support**: Alacritty + tmux-256color
- **Terminal overrides**: `xterm-256color:Tc` for true color
- **Italics support**: Enabled for Alacritty

### UI
- Mouse: Disabled (keyboard-driven workflow)
- Pane borders: Single lines
- Pane border status: Off

---

## Window Management (Yabai + skhd)

### Yabai Configuration

**Layout**: BSP (Binary Space Partitioning)

**Padding & Gaps**:
- All sides: 5px
- Window gap: 5px

**Mouse Behavior**:
- Mouse follows focus: On
- Left-click drag: Move window
- Right-click drag: Resize window
- Drop action: Swap windows

**New Window Placement**: second_child
- Vertical split: Right side
- Horizontal split: Bottom

**Floating Apps** (not managed by yabai):
- System Settings
- Calculator
- Karabiner-Elements
- Stickies
- Cisco Secure Client
- Loom

**Borders** (JankyBorders):
- Active color: `0xffebcb8b` (Nordic yellow)
- Inactive color: `0x553b4252` (Nordic gray, semi-transparent)
- Width: 5.0px

### skhd Keyboard Shortcuts

**Window Focus** (alt + hjkl):
- `alt-h`: Focus left
- `alt-j`: Focus down
- `alt-k`: Focus up
- `alt-l`: Focus right

**Window Swap** (shift + alt + hjkl):
- `shift+alt-h`: Swap left
- `shift+alt-j`: Swap down
- `shift+alt-k`: Swap up
- `shift+alt-l`: Swap right

**Layout Modification**:
- `shift+alt-space`: Rotate layout 270° (clockwise)
- `shift+alt-y`: Mirror Y-axis
- `shift+alt-x`: Mirror X-axis
- `shift+alt-t`: Toggle float (4x4 grid, center 2x2)
- `shift+alt-r`: Balance windows (equal area)

**Window Size**:
- `alt-z`: Toggle zoom fullscreen

**Move to Space** (alt + ctrl + number):
- `alt+ctrl-1` through `alt+ctrl-6`: Move window to space 1-6

**No window restart required**: Changes take effect immediately

---

## Installation & Setup

### Install Script (`install.sh`)

**Single command setup**:
```bash
cd dotfiles
./install.sh
```

**What it does**:

1. **Zsh + Oh-My-Zsh**
   - Installs zsh and oh-my-zsh
   - Copies custom theme to `~/.oh-my-zsh/themes/`
   - Installs zsh-autosuggestions plugin

2. **Development Tools**
   - ripgrep (rg)
   - universal-ctags (uctags)
   - fzf
   - tmux + TPM
   - tmuxinator (+ rbenv for Ruby 2.6.10)

3. **Neovim Setup**
   - Installs vim-plug
   - Installs neovim (or uses binary from ~/Downloads)
   - Symlinks:
     - `~/.vimrc` → `~/.config/nvim/init.lua`
     - `~/.vim` → `~/.config/nvim`
     - `coc-settings.json` → `~/.vim/coc-settings.json`
     - `lua/` → `~/.vim/lua`
   - Installs pynvim (Python provider)

4. **Terminal**
   - Installs Alacritty + terminfo
   - Symlinks config to `~/.config/alacritty/alacritty.yml`
   - Enables font smoothing on macOS

5. **Window Management**
   - Installs yabai, skhd, borders
   - Symlinks configs to `~/.config/{yabai,skhd}/`
   - Starts services

6. **Git Tools**
   - Sets up ctags git hooks (auto-generate on commit/checkout/merge)
   - Installs diff-so-fancy
   - Installs scm_breeze
   - Sets global gitignore

7. **Dotfile Symlinking**
   - Symlinks these files from repo to home directory:
     - vimrc
     - zshrc
     - tmux.conf
     - tmux-theme.conf
     - tern-config
     - ackrc
     - gitignore_global

**Safety checks**:
- Confirms no existing files will be clobbered
- Checks all source files are readable
- Only installs if command doesn't already exist

---

## Known Issues & Improvements

### Current TODO List (from `docs/todo.md`)

#### Fixes Needed
- `:GBrowse` for Stash repos (needs fugitive-stash.vim)
- Copilot key bindings (currently using Windsurf)
- `ctrlsf` can't find some strings (investigate ripgrep settings)
- Change Alacritty font based on monitor connected

#### Currently Trying
- `zsh` `Ctrl-x Ctrl-e` (edit command in vim) - currently buggy
- `zsh-vi-mode` plugin slow in big repos - debug performance

#### Features to Explore
- Full Lua migration (currently mixed vimscript + Lua)
- Emacs Org Mode alternatives:
  - nvim-orgmode/orgmode
  - nvim-neorg/neorg
- Magit for Neovim (better git interface)
- Project-wide commands (e.g., `<leader>pb` to build project)

#### Improvements Wanted
- Accept incoming changes in merge conflicts (e.g., always accept master for specific file)
- Find and replace in repository:
  - Uses ripgrep ✓
  - Finding within pattern ✓
  - Search in node_modules when needed ✓
  - Replace functionality (needs work)
  - Quickfix list sync with ctrlsf window
- Paste enhancement (investigate nvim-pasta)
- Explore dirbuf.nvim for directory editing

#### Theme Exploration
- Current: Nordic (mostly satisfied)
  - TODO: Fix `gs` showing all files as green
  - TODO: Align tmux bar with Nordic colors
- Previously explored:
  - Rose Pine (too high contrast)
  - Dracula (too much green)
- To explore:
  - Zenburn
  - Tokyonight.nvim

---

## Development Environment Context

### Datadog-Specific Setup
Based on zshrc configuration, this setup is actively used at Datadog:
- **Primary repository**: web-ui (monorepo at `~/go/src/github.com/DataDog/web-ui`)
- **Tooling**: Bazel, yarn, devtools
- **Languages**: TypeScript (primary), Python, Go, Kotlin
- **Git workflow**: Feature branches against preprod
- **Special tooling**: tsgo (TypeScript LSP), gitsign, direnv

### Workflow Patterns

**Daily workflow**:
1. Start day: Alacritty → tmux → neovim
2. Navigation: fzf for files, ctrlsf for code search, leap for quick jumps
3. Git: fugitive for commits, gitgutter for staging hunks, GBrowse for PR links
4. Window management: yabai + skhd for app switching, tmux for terminal multiplexing
5. AI assistance: Windsurf for completions, CoC for LSP features

**Weekend improvements workflow**:
1. Notice annoyance during weekday work
2. Add to `docs/todo.md`
3. Weekend: Research fix/improvement with Claude Code
4. Test change, commit if successful
5. Update todo.md

---

## Quick Reference

### Most Common Commands

**Vim**:
- `Ctrl-p`: Find file
- `<leader>/`: Search in project
- `<leader>p`: Switch buffer
- `<leader>w`: Save
- `<leader>j/k`: Leap navigation
- `<leader>i`: Show docs (hover)
- `gr`: Find references
- `<leader>rn`: Rename

**Tmux**:
- `\ c`: New window
- `\ v`: Vertical split
- `\ s`: Horizontal split
- `Ctrl-h/j/k/l`: Navigate
- `\ t`: Start pomodoro

**Yabai**:
- `alt-h/j/k/l`: Focus window
- `shift+alt-h/j/k/l`: Swap window
- `alt-z`: Toggle fullscreen
- `alt+ctrl-[1-6]`: Move to space

**Zsh**:
- `Ctrl-z`: Toggle vim/shell
- `Ctrl-r`: FZF history
- `vi <file>`: Open in neovim
- `glb`: Recent branches

---

## Notes for Weekend Improvements

When working on improvements:

1. **Always check `docs/todo.md`** for context on known issues
2. **Test in a tmux session** to ensure vim-tmux-navigator still works
3. **Check performance** in large repos (web-ui monorepo)
4. **Maintain consistency** with existing key mappings (don't conflict with muscle memory)
5. **Document new plugins** in this file
6. **Update TODO** when issues are fixed

**Common improvement areas**:
- Neovim plugin performance (startup time, large file handling)
- Zsh plugin load times (profiling with zprof)
- Yabai window management edge cases
- LSP responsiveness (CoC settings tuning)
- Find/replace workflow improvements (ctrlsf enhancements)

**Testing checklist for changes**:
- [ ] Neovim starts without errors
- [ ] CoC LSP works (go to definition, hover, rename)
- [ ] Tmux splits and navigation work
- [ ] Yabai shortcuts work
- [ ] Git operations work (fugitive, gitgutter)
- [ ] FZF file finding works
- [ ] No performance degradation in web-ui repo

---

## Guidelines for Configuration Changes

When making changes to Neovim, Zsh, Tmux, or other tool configurations, follow these patterns to minimize back-and-forth:

### 1. Documentation First, Guessing Never
- **ALWAYS consult official documentation** before configuring options
- For Vim/Neovim plugins: Documentation is typically in the `docs/` folder of the plugin's GitHub repo
- Check source code if documentation is unclear (e.g., look at Lua files in plugin repo)
- Don't guess at configuration options or fzf field numbers
- Example: For fzf-lua buffer customization, read `buffers.lua` source to understand actual field structure

### 2. Start Minimal, Add Incrementally
- Begin with the **simplest possible configuration** that works
- Test each addition separately before adding more
- If something breaks, easier to identify the culprit
- Example: Start with `file_icons = false`, test, then add fzf_opts if needed

### 3. Clarify UI Preferences Upfront
When user mentions "minimal", "clean", "modern", or "simple", remember these preferences:
- **Borders**: User prefers normal/single-line borders over rounded
- **Icons**: Depends on context - always ask before adding/removing
- **Color highlighting**: Good where it makes sense (syntax highlighting, git diff, etc.)
- **Information density**: Ask about specific elements (buffer numbers, status indicators, line numbers)
- Example: "Should I keep buffer numbers visible, or hide them for a cleaner look?"

### 4. Performance Over Features (Default Priority)
- For dotfiles, **performance is always a priority**
- If a feature adds latency (e.g., git icons requiring `git status`), disable by default
- Measure impact in large repos (web-ui monorepo)
- Example: `git_icons = false` to avoid 200-500ms git status calls

### 5. Incremental Testing Protocol
For each configuration change:
1. Make ONE change at a time
2. Ask user to test (restart Neovim, try the functionality)
3. **Use user's help for testing** - don't try to predict all edge cases
4. Wait for user feedback before proceeding to next change
5. If broken, revert immediately before trying next approach

### 6. Don't Over-Engineer
- **Simplest solution wins** - no abstractions unless explicitly needed
- Avoid complex field parsing, regex delimiters, or fancy formatters unless necessary
- Example: Don't use `--delimiter='[:\\s]+'` when tab delimiter would suffice
- If achieving exact desired output is complex, settle for "good enough"

### 7. User Preferences from Context
Core preferences (always prioritize):
- **Performant code**: Speed and efficiency are critical (measure in large repos)
- **Simple code**: Avoid abstractions, keep solutions straightforward
- **Simplicity over complexity**: Fewer lines, fewer options, less configuration
- **Minimal UI**: Clean look, no clutter, normal borders (not rounded)
- **Keyboard-driven**: Mouse disabled, extensive key mappings
- **No proactive changes**: Only make requested changes, don't add "improvements"

### 8. When Stuck, Ask User Immediately
**Don't wait for 2-3 failed attempts** - utilize user where relevant instead of guessing:
- If unsure about approach, ask before implementing
- If documentation is unclear, ask user to clarify intent
- If multiple valid options exist, present choices to user
- Show current output and ask if direction is correct
- Example: "I can configure this with option A or B - which aligns better with your preference?"

### 9. Common Pitfalls to Avoid
- ❌ Assuming fzf field structure without reading source code
- ❌ Using complex regex delimiters without testing
- ❌ Adding features not explicitly requested (icons, previews, etc.)
- ❌ Making multiple changes simultaneously
- ❌ Continuing to iterate on cosmetic details without asking if current state is acceptable

### 10. Efficiency Patterns & 80/20 Rule
- **80/20 focus**: Tackle most important 20% that delivers 80% of value first
- **Prioritize ruthlessly**: Most important features → least important details last
- **Nudge about "good enough"**: User tends to go to extremes or waste time on minor details
  - Remind: "We've got the core functionality working - these cosmetic tweaks are diminishing returns"
  - Ask: "Should we move on to more impactful changes, or continue refining this?"
- **Batch documentation lookups**: Read all relevant docs at once, not incrementally
- **Provide escape hatches**: Always suggest "we can keep current state if you're happy with it"
- **Stop perfectionism early**: After achieving functional parity, ask if additional polish is worth the time

---

*Last updated: 2026-01-03*
