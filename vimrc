package.path = package.path .. ";./lua/?.lua"
local utils = require('utils');

vim.cmd([[
" Plugins --- {{{
call plug#begin('~/.vim/plugged')

Plug 'mattn/emmet-vim'                        " Emmet for html
Plug 'othree/html5.vim'                       " Html5 syntax, indent
Plug 'elzr/vim-json'                          " JSON highlighting
Plug 'stephpy/vim-yaml'                       " Coz Vanilla yaml in vim is slow
Plug 'tpope/vim-surround'                     " Change the surrounding
Plug 'tpope/vim-repeat'                       " Repeat plugin commands
Plug 'tpope/vim-commentary'                   " Comment/uncomment plugin
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'          " Gbrowse for gitlab
Plug 'itchyny/vim-gitbranch'
Plug 'windwp/nvim-autopairs' " Auto-close brackets with blink.cmp integration support
Plug 'christoomey/vim-tmux-navigator'
Plug 'matze/vim-move'                         " Moves a block of code up or down
Plug 'FooSoft/vim-argwrap'                    " Format arguments
Plug 'tommcdo/vim-exchange'                   " Exchange two words highlights usage: cx{motion} .(dot)
Plug 'benmills/vimux'
Plug 'StanAngeloff/php.vim'                   " syntax for php, fix some common bugs that occurs due to vim not knowing php syntax
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-rhubarb'                      " :Gbrowse
Plug 'tpope/vim-eunuch'                       " :Delete :Move :Rename
Plug 'qpkorr/vim-bufkill'
Plug 'alvan/vim-closetag'
Plug 'machakann/vim-highlightedyank'
" Plug 'w0rp/ale', {'do': ':!brew install languagetool'} " REMOVED: Replaced with conform.nvim
Plug 'itchyny/lightline.vim'
" Plug 'maximbaz/lightline-ale' " REMOVED: No longer needed without ALE
Plug 'mengelbrecht/lightline-bufferline'
Plug 'xolox/vim-misc'                         " Required by vim-notes
Plug 'xolox/vim-notes'
Plug 'airblade/vim-gitgutter'
Plug 'alok/notational-fzf-vim'
Plug 'AlexvZyl/nordic.nvim', { 'branch': 'main' }
" Pin the version because treesitter had a major upgarde after this which
" requires updating the init configuration completely to be usable
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'tag': 'v0.9.3'}
" rm -rf ~/.config/github-copilot/hosts.json to signout from copilot
" Plug 'github/copilot.vim'
Plug 'Exafunction/windsurf.vim', { 'branch': 'main' }

" How post update hook works
" https://github.com/junegunn/vim-plug/blob/master/README.md#post-update-hooks
function! PostInstallCocNvim(info)
  if a:info.status == 'installed' || a:info.force
    !brew install watchman
    " using coc-yaml with :CocConfig to super kubernetes config
    CocInstall coc-tsserver coc-json coc-css coc-html coc-pyright coc-styled-components coc-docker coc-yaml coc-kotlin @yaegassy/coc-tailwindcss3
  endif
endfunction
" Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': function('PostInstallCocNvim') }  " Disabled: migrated to native LSP + blink.cmp

Plug 'tpope/vim-sleuth'
Plug 'voldikss/vim-floaterm', {'do': ':!brew install nnn'} " nnn coz it's fast
Plug 'JamshedVesuna/vim-markdown-preview', {'do': ':!brew install grip'} "grip is github flavoured markdown & a prerequisite
Plug 'norcalli/nvim-colorizer.lua' " works well in alacritty.yml colors, css, html
Plug 'udalov/kotlin-vim'
Plug 'PezCoder/auto-create-directory.nvim'
Plug 'dyng/ctrlsf.vim' " Text find, navigate & replace
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Multi cursor support, with <c-n>, q to skip a word
Plug 'ggandor/leap.nvim'

" LSP & Completion --- {{{
" Plug 'neovim/nvim-lspconfig'            " REMOVED: Using native vim.lsp.config() (Neovim 0.11+)
Plug 'mason-org/mason-lspconfig.nvim'   " REMOVED: Not needed with native vim.lsp.config()
Plug 'saghen/blink.cmp'                   " Fast completion engine with native LSP support
Plug 'echasnovski/mini.icons'             " Automatic icons with ASCII fallback + colors
Plug 'j-hui/fidget.nvim'                  " LSP progress notifications
Plug 'mason-org/mason.nvim'               " LSP installer
Plug 'stevearc/conform.nvim'              " Formatting (replaces ALE fixers)
" }}}

call plug#end()
" }}}

" Basic Settings --- {{{
set noswapfile                    " get rid of annoying .swp exist, delete, read options to deal with
set nobackup                      " get rid of anoying ~file
set backspace=indent,eol,start    " Fixes not able to backspace in insert mode issue
if !has('nvim')
  set encoding=utf-8
end
runtime macros/matchit.vim        " autoload that extends % functionality
syntax on                         " show syntax highlighting
set autoindent                    " set auto indent
set ts=4
set shiftwidth=4
set softtabstop=4
set expandtab                     " use spaces, not tab characters
" Disable numbers temporarily, Looks much cleaner this way
" set relativenumber                " show relative line numbers
" set number
" set nu
set nonu
set showmatch                     " show bracket matches
set ignorecase                    " ignore case in search
set hlsearch                      " highlight all search matches
set incsearch                     " show search results as I type
set smartcase                     " pay attention to case when caps are used
set gdefault                      " substitute globally by default
set ttimeoutlen=100               " decrease timeout for faster insert with 'O'
set vb                            " enable visual bell (disable audio bell)
set ruler                         " show row and column in footer
set scrolloff=2                   " minimum lines above/below cursor
set laststatus=2                  " always show status bar
set list listchars=tab:»·,trail:· " show extra space characters
set nofoldenable                  " disable code folding
set wildmenu                      " enable bash style tab completion
set wildignorecase                " Ignore casing when tab completion while opening files/directories
set wildmode=list:longest,full
set mouse=c                       " Disable cursor
set hidden                        " Can hide buffer in non saved state
set undofile                      " Persists undo history on multiple repeat opening of files :help persistent-undo
" }}}

" Remap leader key
let mapleader = "\<Space>"

" Color Scheme --- {{{
set background=dark
if (has("termguicolors"))
  " Enable true colors if available
  set termguicolors
  " Enable italics, Make sure this is immediately after colorscheme
  " https://stackoverflow.com/questions/3494435/vimrc-make-comments-italic
  highlight Comment cterm=italic gui=italic
  set cursorline
else
  set t_Co=256
  let base16colorspace=256
  colorscheme base16-material
endif

" Vim Quirks --- {{{
" Save swap files separately to avoid cluttering cwd
if isdirectory($HOME . '/.vim/swap-files') == 0
    :silent !mkdir -p ~/.vim/swap-files > /dev/null 2>&1
endif
set directory^=$HOME/.vim/swap-files//

" Hyphen names as single word for style files
au FileType css,scss setl iskeyword+=-

" Resize all open windows propotionally when the terminal is resized
augroup vim_buffers_resize
    autocmd!
    autocmd VimResized * :wincmd =
augroup END

" Fix the vim's explorer window doesn't close with :bd
" TODO: Still isn't smooth, rather don't use it.
autocmd FileType netrw setl bufhidden=wipe

" Handle :paste toggle
" Author: tpope https://github.com/tpope/vim-unimpaired
function! s:setup_paste() abort
  let s:paste = &paste
  let s:mouse = &mouse
  set paste
  set mouse=
  augroup unimpaired_paste
    autocmd!
    autocmd InsertLeave *
          \ if exists('s:paste') |
          \   let &paste = s:paste |
          \   let &mouse = s:mouse |
          \   unlet s:paste |
          \   unlet s:mouse |
          \ endif |
          \ autocmd! unimpaired_paste
  augroup END
endfunction

" One way behaviour for n & N
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]
" }}}

" Plugins --- {{{
" emmet-vim --- {{{
let g:user_emmet_install_global = 0
augroup emmet_configuration
    autocmd!
    autocmd FileType html,css,scss,javascript.jsx,typescript.tsx,typescriptreact,javascriptreact EmmetInstall                      " Enable emmet for just few files
    autocmd FileType html,css,scss,javascript.jsx,typescript.tsx,typescriptreact,javascriptreact :call MapTabForEmmetExpansion()   " Tab expands the expression, woot!
augroup END
let g:user_emmet_mode="a"                                                  " Use emmit for insert mode only
let g:cssColorVimDoNotMessMyUpdatetime = 1
function! MapTabForEmmetExpansion()
  imap <expr> <leader><tab> emmet#expandAbbrIntelligent("\<tab>")
endfunc
" }}}

" vim-closetag --- {{{
let g:closetag_filenames = '*.html,*.jsx'
" }}}

" vim-startify --- {{{
" handle cwd when opening a file through startify
let g:startify_change_to_dir = 0
" Changing to vcs_root was a problem in case of monorepos which may contain multiple sub apps
" Where we would want the cwd to still be the sub app & not the root of repository
" let g:startify_change_to_vcs_root = 1
" Use :SS to save a session
let g:startify_session_persistence = 1
let g:startify_list_order = ['sessions', 'dir']
let g:startify_files_number = 5
let g:startify_list_order = [
            \ ['   Sessions'],
            \ 'sessions',
            \ ['   Recent Files'],
            \ 'dir',
            \ ]
" }}}

" vim-move --- {{{
let g:move_key_modifier_visualmode = 'C'
" }}}

" php.vim --- {{{
let g:php_html_load = 0
" }}}

" shumphrey/fugitive-gitlab.vim --- {{{
let g:fugitive_gitlab_domains = ['https://gitlab.eng.roku.com']
" }}}

" fzf.vim --- {{{
let g:fzf_tags_command = 'uctags -R'
let g:fzf_layout = { 'down': '~25%' }
" Empty value to disable preview window altogether
let g:fzf_preview_window = ''
nnoremap <silent> <C-p> :call FzfOmniFiles()<CR>
" nnoremap <leader>/ :Ag<CR>
nnoremap <silent> <leader>p :Buffers<CR>
nnoremap <silent> <leader>l :BLines<CR>
" Quick jump to function (uses :BTags to filter just the functions names)
" nnoremap <silent> <leader>j :call fzf#vim#buffer_tags('', { 'options': ['--nth', '1,2', '--query', '^f$ '] })<CR>
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" fzf search on top of word search using ripgrep with :Find
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --ignore-case --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" TODO: This causes the FZF to lag when c-p is pressed in a big repository
" where 'git status' is slow
" Run FZF based on the cwd & git detection
" 1. Runs :Files, If cwd is not a git repository
" 2. Runs :GitFiles <cwd> If root is a git repository
fun! FzfOmniFiles()
  " Throws v:shell_error if is not a git directory
  let git_status = system('git status')
  if v:shell_error != 0
    :Files
  else
    " Reference examples which made this happen:
    " https://github.com/junegunn/fzf.vim/blob/master/doc/fzf-vim.txt#L209
    " https://github.com/junegunn/fzf.vim/blob/master/doc/fzf-vim.txt#L290
    " --exclude-standard - Respect gitignore
    " --others - Show untracked git files
    " dir: getcwd() - Shows file names relative to cwd
    let git_files_cmd = ":GitFiles --exclude-standard --cached --others"
    call fzf#vim#gitfiles('--exclude-standard --cached --others', {'dir': getcwd()})
  endif
endfun
" }}}

" dyng/ctrlsf.vim --- {{{
" Defaults:
" Case sensitive - smart
" Regex - Literals by default. Use '-R' to pass regex
let g:ctrlsf_default_view_mode = 'compact' " Quickfix like view

" Use quick fix list to populate & open instead of ctrlsf window
" https://github.com/dyng/ctrlsf.vim/issues/340
let g:ctrlsf_populate_qflist = 1
let g:ctrlsf_auto_close = 1
let g:ctrlsf_auto_qf = 1

let g:ctrlsf_mapping = {
    \ "next": "j",
    \ "prev": "k",
    \ }
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
nnoremap <Leader>/ :CtrlSF<Space>
" }}}

" vim-argwrap --- {{{
let g:argwrap_tail_comma_braces = '['
" read mapping as format arguments
nnoremap <silent> <leader>fa :ArgWrap<CR>
" }}}

" itchyny/lightline.vim --- {{{
let g:lightline#bufferline#modified = ' ✎'
set showtabline=2
let g:lightline = {
      \ 'colorscheme': 'nord',
      \
      \ 'tabline': {
      \   'left': [ [ 'buffers' ] ],
      \   'right': []
      \ },
      \
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'gitbranch', 'relativepath' ] ],
      \   'right': [ ['lineinfo'], ['filetype'] ]
      \ },
      \
      \ 'inactive': {
      \   'left': [ [ 'filename' ] ],
      \   'right': [ [ 'lineinfo' ] ]
      \ },
      \
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \
      \ 'component': {
      \   'lineinfo': '%3l/%L'
      \},
      \
      \ 'component_expand': {
      \  'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \  'buffers': 'tabsel'
      \ }
      \ }
" }}}
" Use autocmd to force lightline update.
" autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()  " Disabled: CoC removed

" vim-highlightedyank --- {{{
if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif
let g:highlightedyank_highlight_duration=250
" }}}

" ALE REMOVED: Replaced with conform.nvim (see Lua config section for formatting setup)
" conform.nvim handles: prettier, eslint --fix, yapf
" Native LSP handles: diagnostics, completion, hover, go-to-definition
" }}}

" xolox/vim-notes --- {{{
let g:notes_directories = ['~/Downloads/VimNotes']
cnoreabbrev note Note
" }}}

" notational-fzf-vim --- {{{
" Search in notes directory quickly
nnoremap <silent> <leader>n :NV<CR>
let g:nv_search_paths = g:notes_directories
" }}}

" DISABLED: " neoclide/coc.nvim --- {{{
" " Disable CoC globally (using native LSP instead)
" let g:coc_start_at_startup = 0
" 
" " TODO look into these options to which one's are
" 
" " Reference: https://github.com/neoclide/coc.nvim#example-vim-configuration
" " Use tab for trigger completion with characters ahead and navigate
" " NOTE: There's always complete item selected by default, you may want to enable
" " no select by `"suggest.noselect": true` in your configuration file
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config
" function! CheckBackspace() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" 
" " Make <CR> to accept selected completion item or notify coc.nvim to format
" " <C-g>u breaks current undo, please make your own choice
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" 
" " Remap keys for gotos
" " Uses coc.nvim to go to a tag when c-]
" " set tagfunc=CocTagFunc
" nmap <silent> gr <Plug>(coc-references)
" nmap <leader>rn <Plug>(coc-rename)
" " Overrides gt which is for tabs, I don't use tabs anymore but in case things
" " break for tabs, remove this
" nmap <silent> gt <Plug>(coc-type-definition)
" 
" " Use <leader>i to show documentation under the cursor
" nnoremap <silent> <leader>i :call <SID>show_documentation()<CR>
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     " CocAction('doHover') used to hang, so changed this to async
"     call CocActionAsync('doHover')
"   endif
" endfunction
" 
" " Insert mode - <c-space> to trigger completion.
" " inoremap <silent><expr> <c-space> coc#refresh()
" " Normal mode - <c-space> to trigger codaction that lets quick import & other
" " smart operations.
" " Disabled for Go files (using native LSP instead)
" " nmap <c-space> <Plug>(coc-codeaction)
" 
" " Show parameter signature help when in insert mode
" " TODO: Figure, why does it goes away
" " https://github.com/neoclide/coc.nvim/issues/2951
" " inoremap <silent><c-space> <C-\><C-O>:call CocActionAsync('showSignatureHelp')<cr>
" 
" " Use c-f & c-b to scroll up & down the documentation if it exists
" " https://github.com/neoclide/coc.nvim/issues/1841
" nnoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
" nnoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" " }}}

" voldikss/vim-floaterm --- {{{
nnoremap <silent> - :FileBrowser<CR>
command! FileBrowser FloatermNew --width=0.8 --opener=edit nnn
autocmd FileType floaterm tnoremap <buffer> <Esc> q
" }}}

" vim-gitgutter --- {{{
" To update git signs almost immediately
set updatetime=100
" don't setup any default mappings
let g:gitgutter_map_keys = 0
nmap ]g <Plug>(GitGutterNextHunk)
nmap [g <Plug>(GitGutterPrevHunk)
nmap <Leader>ga <Plug>(GitGutterStageHunk)
vmap <Leader>ga <Plug>(GitGutterStageHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
nmap <Leader>gs <Plug>(GitGutterPreviewHunk)
" }}}

" JamshedVesuna/vim-markdown-preview --- {{{
let vim_markdown_preview_github=1
let vim_markdown_preview_temp_file=1
" Other value can be: Google Chrome
let vim_markdown_preview_browser='arc'
" To display images with the hotkey mapping (defaults to Control p).
let vim_markdown_preview_toggle=1
let vim_markdown_preview_hotkey='<leader>m'
" }}}

" telescope --- {{{
" Behaviour:
" Looks for all files if not a git project & considers .gitignore if it's a
" git project
" nnoremap <c-p> <cmd>Telescope find_files<cr>
" TODO: Find how to live grep but add into the buffer
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>p <cmd>Telescope buffers<cr>

" nvim-telescope/telescope-fzf-native.nvim
" One native telescope sorter to significantly improve sorting performance
" require('telescope').load_extension('fzf')
" }}}

" Helpful mappings --- {{{
" Current Directory remap to :%%
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' :'%%'

" Open chrom with :chrome command
" TODO: Make this available only on html file types
" TODO: Pick up the "default" system browser instead & change command to
" generic ":Open"
command! Chrome !open % -a Google\ Chrome
command! Arc !open % -a Arc
cnoreabbrev chrome Chrome
cnoreabbrev arc Arc

" Strip trailing white spaces --- {{{
" http://vimcasts.org/episodes/tidying-whitespace/
command! -nargs=* Whitespaces call StripTrailingWhitespaces()
function! StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" }}}

" Set tab with Stab --- {{{
" Set tabstop, softtabstop and shiftwidth to the same value. ( Ex :Stab<CR>4 )
command! -nargs=* Stab call Stab()

" Helpers for changing tab space settings
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction
" }}}

" Key Mappings --- {{{
" Usual spelling errors
cnoreabbrev bD bd
cnoreabbrev bd bd
cnoreabbrev Bd bd
cnoreabbrev Copen copen
cnoreabbrev gb Git blame
cnoreabbrev gbrowse GBrowse
cnoreabbrev Cd cd
iabbrev calender calendar

" Buffer Mappings
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j
nnoremap <leader>c <C-w>c

"Save file
nnoremap <Leader>w :w<CR>

"Save & Quit file
nnoremap <Leader>q :wqa<CR>

" j & k works as you expect it to on folded lines
nnoremap j gj
nnoremap gj j
nnoremap k gk

" Quickly add empty lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
" Mappings external paste (temp disable as it's auto detecting paste)
" nnoremap <silent> <leader>o  :call <SID>setup_paste()<CR>o
" nnoremap <silent> <leader>O  :call <SID>setup_paste()<CR>O
" nnoremap <silent> <leader>i  :call <SID>setup_paste()<CR>i
" Navigate buffer
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
" Navigate quickfix list
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
" Navigate location list
nnoremap <silent> [w :lprevious<CR>
nnoremap <silent> ]w :lnext<CR>
"Tabs switch
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>

" Zoom in & out using leader + z
nnoremap <silent><leader>z :ZoomToggle<CR>
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()

" Quick open vimrc
nmap <leader>ev :botright vnew ~/.vimrc<cr>

" Quick open todo.md
nmap <leader>et :botright vnew ~/Downloads/workspace/dotfiles/docs/todo.md<cr>

" Casing made easy
nnoremap <c-u> gUiw

" Y will yank till the end of the word
nnoremap Y y$

" Quick add single quote
vnoremap ' <esc>a'<esc>`<i'<esc>

" Copy to clipboard
vnoremap <leader>y "+y

" tags
nnoremap <C-]> g<C-]>
" Manually setting the tags directory, as Tag support was removed in fugitive here:
" https://github.com/tpope/vim-fugitive/commit/63a05a6935ec4a45551bf141089c13d5671202a1
set tags^=./.git/tags;

" Execute macro on visually selected lines with @{macro}
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" <space><space> removes the search highlights
nmap <silent> <space><space> :nohlsearch<CR>

" Delete always asks for 'tpope/vim-eunuch'
cnoreabbrev rm Delete!
cnoreabbrev rn Rename
cnoreabbrev mv Move
" }}}

" Autocmd --- {{{
" Auto source vimrc on save
autocmd! bufwritepost ~/.vimrc source $MYVIMRC

" <leader>r => Run
" Runs test case for respective file types
augroup leader_run
    autocmd FileType php map <buffer> <Leader>r :call VimuxRunCommand("clear;phpunit -c app/ " . bufname("%"))<CR>
    autocmd FileType java map <buffer> <Leader>r :call VimuxRunCommand("clear;javac ".bufname("%")." ;java ".expand("%:r"))<CR>
    autocmd FileType python map <buffer> <Leader>r :call VimuxRunCommand("clear;python '".bufname("%")."'")<CR>
augroup END

" Make :help appear in a full-screen tab, instead of a half window
augroup HelpInTabs
    autocmd!
    autocmd BufEnter *.txt call HelpInNewTab()
augroup END
function! HelpInNewTab ()
    if &buftype == 'help'
        "Convert the help window to a tab...
        execute "normal \<C-W>T"
    endif
endfunction

autocmd FileType javascript setlocal sw=2 sts=2 ts=2

" Spell correction
autocmd FileType markdown setlocal spell
nnoremap z= 1z=
" }}}

" Experimental --- {{{
" Goto left most character & right most character of a line
nnoremap H ^
nnoremap L $
" Temp: This is to make sure i learnt the above mappings right
nnoremap ^ <nop>
nnoremap $ <nop>

" Temp: $ goes to new line character as well, in virutal mode it's annoying
" Disabling it to encourage using operators like C, D, Y which changes deletes
" & yanks till the next line
vnoremap $ <nop>

" Neovim stuff --- {{{
if has('nvim')
    " Prefer insert mode when entering a terminal buffer
    autocmd BufEnter term://* startinsert

    " Escape to exit out of terminal insert mode
    tnoremap <Esc> <C-\><C-n>

    " Note: FZF also opens in terminal mode so this mapping breaks
    " the up & down motion with c-j & c-k in fzf
    " Navigate seamlessly from terminal mode to another window.
    " tnoremap <C-h> <C-\><C-n><C-w>h
    " tnoremap <C-j> <C-\><C-n><C-w>j
    " tnoremap <C-k> <C-\><C-n><C-w>k
    " tnoremap <C-l> <C-\><C-n><C-w>l

    " Hide numbers for terminal
    au TermOpen * setlocal nonumber norelativenumber

    " FZF fixes for terminal mode {
    " Make escape exit fzf
    autocmd FileType fzf tnoremap <buffer> <Esc> <c-c>
    " Remove visible clutter
    autocmd FileType fzf set laststatus=0 noshowmode noruler
                \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    " }

    " Live substitute with %s
    set inccommand=nosplit
endif
" }}}
]])

require('auto-create-directory').setup()

-- nvim-autopairs setup with blink.cmp integration
require('nvim-autopairs').setup({
  check_ts = true,  -- Use treesitter for better pair detection
  ts_config = {
    lua = {'string'},  -- Don't add pairs in lua string treesitter nodes
    javascript = {'template_string'},
    java = false,  -- Don't check treesitter on java
  }
})

-- TODO: Move this to find_replace.lua
function Sed(find, replace)
    local files = vim.fn.systemlist('git grep -l -- ' .. vim.fn.shellescape(find))
    local quickfix_list = {}
    for _, file in ipairs(files) do
        vim.api.nvim_command('edit ' .. file)
        local _, err = pcall(function() vim.api.nvim_command('%s/'..find..'/'..replace..'/g') end)
        if err == nil then
            print("inserting")
            table.insert(quickfix_list, {filename = file, lnum = 1, text = 'Replaced '..find..' with '..replace})
            -- vim.api.nvim_command("w") -- save the changes
        end
    end
    print('rohit', quickfix_list)
    for k, v in pairs(quickfix_list) do
      print('rahul')
      print(k, v)
    end
    vim.api.nvim_set_var("quickfix_list", quickfix_list)
end

-- Find replace in the repository
vim.api.nvim_command("command! -nargs=* Sed lua Sed(<f-args>)")

-- AlexvZyl/nordic.nvim {{
-- https://github.com/AlexvZyl/nordic.nvim/blob/main/lua/nordic/colors/nordic.lua
local nordicPalette = require 'nordic.colors'
local nordicOptions = require('nordic.config').options
require 'nordic' .setup {
  on_highlight = function(highlights, palette)
    highlights.Visual = {
      bg = palette.gray1,
    }
    highlights.CursorLine = {
      bg = palette.gray1,
    }
  end,

  reduced_blue = false,
}
vim.cmd.colorscheme 'nordic'
-- }}

require 'colorizer'.setup()

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
      -- default
      "c",
      "lua",
      "vim",
      "vimdoc",
      "query",
      -- custom
      "javascript",
      "typescript",
      "graphql",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- handle indentation using nvim-treesitter
  indent = { enable = true },

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- github/copilot.vim
-- vim.keymap.set('i', '<C-e>', 'copilot#Accept("\\<CR>")', {
--   expr = true,
--   replace_keycodes = false
-- })
-- vim.g.copilot_no_tab_map = true

-- Exafunction/windsurf.vim
vim.keymap.set('i', '<C-e>', 'codeium#Accept()', {
  expr = true,
  replace_keycodes = false
})
vim.g.codeium_disable_bindings = 1

-- vim.g.codeium_no_map_tab = true

-- ggandor/leap.nvim --- {{{
require('leap').add_repeat_mappings('<Leader>j', '<Leader>k', {
  -- False by default. If set to true, the keys will work like the
  -- native semicolon/comma, i.e., forward/backward is understood in
  -- relation to the last motion.
  relative_directions = true,
  -- By default, all modes are included.
  modes = {'n'},
})
vim.keymap.set({'n', 'x', 'o'}, '<leader>j', '<Plug>(leap-forward-to)')
vim.keymap.set({'n', 'x', 'o'}, '<leader>k', '<Plug>(leap-backward-to)')
require('leap').init_highlight(true)

-- :h leap-highlight
vim.api.nvim_set_hl(0, 'LeapLabelPrimary', {
    fg = nordicPalette.black1,
    bg = nordicPalette.yellow.bright,
    nocombine = true,
})
vim.api.nvim_set_hl(0, 'LeapMatch', {
    fg = nordicPalette.black1,
    bg = nordicPalette.yellow.bright,
    underline = true,
    nocombine = true,
})
-- }}}
-- Copy file path with line range to clipboard in format: @File#L1-99
vim.keymap.set("v", "<leader>cy", function()
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local file_path = vim.fn.expand("%:.")
  local result = string.format("@%s#L%d-%d", file_path, start_line, end_line)

  vim.fn.setreg("+", result)
  vim.notify(string.format("Copied: %s", result), vim.log.levels.INFO)

  vim.cmd("normal! \027")
end, { desc = "Copy file path with line range" })

-- Go LSP Configuration --- {{{
-- Based on LazyVim & community best practices

-- 1. Setup fidget.nvim for LSP progress notifications
require('fidget').setup({})

-- 2. Setup mini.icons with ASCII fallback (automatic icons + colors)
require('mini.icons').setup({
  style = 'ascii'  -- Automatic single-letter fallback, works with any font
})

-- 3. Setup blink.cmp (CoC parity configuration)
require('blink.cmp').setup({

  completion = {
    list = {
      max_items = 20,  -- Limit suggestions like CoC (not huge lists)
      selection = {
        preselect = false,      -- Don't auto-select first item (CoC: "suggest.noselect": true)
        auto_insert = true,    -- Don't auto-insert preview
      },
    },
    menu = {
      auto_show = true,
      draw = {
        columns = {
          { 'kind_icon', gap = 1 },
          { 'label', 'label_description', gap = 1 }
        },
        components = {
          kind_icon = {
            text = function(ctx)
              local icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
              return icon .. ctx.icon_gap
            end,
            highlight = function(ctx)
              local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              return hl
            end,
          }
        }
      }
    },
    documentation = {
      auto_show = true,
      treesitter_highlighting = true,
      -- auto_show_delay_ms = 500  -- Show docs with slight delay
    },
    ghost_text = {
      enabled = false  -- Disabled (using Windsurf for AI completion)
    },
  },

  -- Key mappings matching CoC behavior
  keymap = {
    preset = 'none',  -- Start from scratch for full control
    ['<Tab>'] = { 'select_next', 'fallback' },      -- Navigate or insert tab
    ['<S-Tab>'] = { 'select_prev', 'fallback' },    -- Navigate backwards
    ['<CR>'] = {
      function(cmp)
        if cmp.is_visible() then
          return cmp.accept()
        end
      end,
      'fallback'  -- Let nvim-autopairs handle <CR> when completion menu not visible
    },
    ['<C-Space>'] = { 'show', 'hide' },             -- Manual trigger/toggle
    -- ['<C-e>'] = { 'hide', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },  -- Scroll docs
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },    -- Scroll docs
  },

  -- Sources (LSP, path, buffer - no snippets)
  sources = {
    default = { 'lsp', 'path', 'buffer' },
  },

  -- Snippets disabled (matching preference)
  snippets = {
    expand = function() end,
    active = function() return false end,
  },
})

-- 4. Setup Mason (LSP binary installer only)
require('mason').setup()
require("mason-lspconfig").setup {
    ensure_installed = { "tsgo", "gopls" },

   -- vim.lsp.config handles enabling automatically
   -- if we don't do this we end up invoking 2 instances of the LSP server which is bad
    automatic_enable = false
}

-- 4.5. Setup conform.nvim (Formatting - replaces ALE fixers)
require('conform').setup({
  formatters_by_ft = {
    javascript = { 'prettier', 'eslint' },
    javascriptreact = { 'prettier', 'eslint' },
    typescript = { 'prettier', 'eslint' },
    typescriptreact = { 'prettier', 'eslint' },
    css = { 'prettier' },
    scss = { 'prettier' },
    python = { 'yapf' },
    graphql = { 'prettier' },
  },
  -- Auto-format on save (replaces ALE's ale_fix_on_save)
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,  -- Use LSP formatter if conform formatter not available
  },
})

-- 5. Configure LSP servers using modern Neovim 0.11+ API
-- Get LSP capabilities from blink.cmp
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- Helper: Determine tsgo binary path (web-ui Yarn SDK vs mason)
local function get_tsgo_cmd()
  -- Search upward from CWD for Yarn SDK binary (web-ui projects)
  -- The ".;" pattern means "search in . and parent directories"
  local yarn_tsgo = vim.fn.findfile(".yarn/sdks/typescript-go/lib/tsgo", ".;")

  if yarn_tsgo ~= "" then
    -- Found Yarn SDK version - use relative path (LSP will resolve from root_dir)
    -- This version has telemetry and proper Yarn PnP context
    return { "./.yarn/sdks/typescript-go/lib/tsgo", "--lsp", "--stdio" }
  end

  -- Fallback to mason-installed tsgo (other projects)
  local mason_tsgo = vim.fn.expand("~/.local/share/nvim/mason/bin/tsgo")
  return { mason_tsgo, "--lsp", "--stdio" }
end

-- Configure tsgo language server (auto-selects: web-ui Yarn SDK or mason binary)
vim.lsp.config('tsgo', {
  cmd = get_tsgo_cmd(),
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  capabilities = capabilities,  -- Use simple capabilities like gopls
  on_attach = function(client, bufnr)
    -- Show initialization notification
    local fidget = require('fidget.progress')
    local handle = fidget.handle.create({
      title = "tsgo",
      message = "Initialising...",
      lsp_client = client,
    })

    -- Auto-dismiss after 2 seconds
    vim.defer_fn(function()
      if handle then
        handle:finish()
      end
    end, 2000)

    -- Disable tsgo formatting (use conform.nvim/prettier instead)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  settings = {
    typescript = {
      preferences = {
        importModuleSpecifier = "non-relative",  -- Use package names instead of relative paths
        autoImportSpecifierExcludeRegexes = { "packages/", "^packages" },  -- Exclude packages from auto-import
      },
      tsserver = {
        useSyntaxServer = "auto",
        maxTsServerMemory = 1024 * 32,  -- 32GB memory limit for large monorepo
        nodePath = "node",
        watchOptions = {
          excludeDirectories = { "**/node_modules", "**/.yarn", "**/.sarif" },  -- Improve performance
          excludeFiles = { ".pnp.cjs" },  -- Exclude Yarn PnP file from watching
        },
      },
    },
  },
})

-- Configure gopls language server
vim.lsp.config('gopls', {
  capabilities = capabilities,
  cmd = {
    'gopls',
    '-remote.debug=:0',
  },
  filetypes = { 'go', 'gomod', 'gosum', 'gotmpl', 'gohtmltmpl', 'gotexttmpl' },
  root_markers = { 'go.work', 'go.mod', '.git', 'go.sum' },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true,
    },
  },
})

-- Enable both LSP servers
vim.lsp.enable({'tsgo', 'gopls'})

-- Configure diagnostics display (show errors/warnings with underlines)
vim.diagnostic.config({
  underline = true,  -- Show squiggly underlines under errors/warnings
  virtual_text = false,  -- Disabled (using floating windows on CursorHold instead)
  signs = true,  -- Show signs in gutter (E, W, I, H)
  update_in_insert = false,  -- Don't update diagnostics while typing
  severity_sort = true,  -- Sort by severity (errors first)
  float = {
    border = "none",  -- No border for minimal look
    header = "",  -- Remove "Diagnostics:" header
    source = "if_many",  -- Only show source when multiple LSPs present
    prefix = "",  -- Remove bullet/icon prefix
    focusable = false,  -- Prevent cursor from entering float
    pad_top = 1,  -- Vertical padding above
    pad_bottom = 1,  -- Vertical padding below
    -- Note: pad_left/pad_right not supported in Neovim API
  },
  loclist = {
    open = false,  -- Populate location list silently for ]w/[w navigation
  },
})

-- Auto-show diagnostic float when cursor pauses
vim.api.nvim_create_augroup('DiagnosticFloat', { clear = true })
vim.api.nvim_create_autocmd('CursorHold', {
  group = 'DiagnosticFloat',
  pattern = '*',
  callback = function()
    vim.diagnostic.open_float({
      focusable = false,
      scope = 'cursor',
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' }
    })
  end,
})

-- Auto-populate location list when diagnostics change
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function()
    vim.diagnostic.setloclist({ open = false })  -- Populate location list silently
  end,
})

-- 6. LSP keybindings (applied to all filetypes with LSP attached)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- Enable LSP-based tag navigation (Ctrl-] uses LSP instead of ctags)
    vim.bo[args.buf].tagfunc = 'v:lua.vim.lsp.tagfunc'

    local opts = { buffer = args.buf, silent = true }

    -- Navigation
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.hover, opts)

    -- Actions
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<c-space>', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
  end,
})
-- }}}
