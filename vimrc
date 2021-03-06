" Plugins --- {{{
call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'
Plug 'mattn/emmet-vim'                        " Emmet for html
Plug 'evidens/vim-twig'                       " Twig Syntax highlighting
Plug 'hail2u/vim-css3-syntax'                 " CSS3 Syntax
Plug 'vim-airline/vim-airline'
Plug 'othree/html5.vim'                       " Html5 syntax, indent
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'
Plug 'pangloss/vim-javascript'                " Better syntax highlighting & indent
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'            " To support jsx inside typescript i.e .tsx
Plug 'MaxMEllon/vim-jsx-pretty'               " JSX highlighting (requires pangloss/vim-javascript)
Plug 'elzr/vim-json'                          " JSON highlighting
Plug 'stephpy/vim-yaml'                       " Coz Vanilla yaml in vim is slow
Plug 'tpope/vim-surround'                     " Change the surrounding
Plug 'tpope/vim-repeat'                       " Repeat plugin commands
Plug 'jszakmeister/vim-togglecursor'          " Different cursors in different modes
Plug 'othree/javascript-libraries-syntax.vim' "JS Plugin library syntax support
Plug 'tpope/vim-commentary'                   " Comment/uncomment plugin
Plug 'tpope/vim-fugitive'
" Plug 'jiangmiao/auto-pairs'
Plug 'dimonomid/auto-pairs-gentle' " Trying this fork, for the bracket not able to autoclose in multiline
Plug 'christoomey/vim-tmux-navigator'
Plug 'majutsushi/tagbar'
Plug 'matze/vim-move'                         " Moves a block of code up or down
Plug 'mileszs/ack.vim'
Plug 'FooSoft/vim-argwrap'                    " Format arguments
Plug 'tommcdo/vim-exchange'                   " Exchange two words highlights usage: cx{motion} .(dot)
Plug 'benmills/vimux'
Plug 'StanAngeloff/php.vim'                   " syntax for php, fix some common bugs that occurs due to vim not knowing php syntax
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'michaeljsmith/vim-indent-object'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-rhubarb'                      " :Gbrowse
Plug 'tpope/vim-eunuch'                       " :Delete :Move :Rename
Plug 'qpkorr/vim-bufkill'
Plug 'alvan/vim-closetag'
Plug 'machakann/vim-highlightedyank'
Plug 'w0rp/ale'                               " Asynchronous linting engine
Plug 'xolox/vim-misc'                         " Required by vim-notes
Plug 'xolox/vim-notes'
Plug 'airblade/vim-gitgutter'
Plug 'alok/notational-fzf-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':CocInstall coc-tsserver coc-json coc-css coc-html coc-tabnine'}
Plug 'tpope/vim-sleuth'
Plug 'voldikss/vim-floaterm', {'do': ':!brew install nnn'} " nnn coz it's fast
" Plug 'JamshedVesuna/vim-markdown-preview'

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
set relativenumber                " show relative line numbers
set number
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
  colorscheme gruvbox
  " Enable italics, Make sure this is immediately after colorscheme
  " https://stackoverflow.com/questions/3494435/vimrc-make-comments-italic
  highlight Comment cterm=italic gui=italic
  set cursorline
else
  set t_Co=256
  let base16colorspace=256
  colorscheme base16-material
endif

" Highlight current line
autocmd ColorScheme * highlight StatusLine ctermbg=darkgray cterm=NONE guibg=darkgray gui=NONE
" }}}

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

" On new file save, auto create directories if doesn't exist
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir)
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

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

" vim-jsx --- {{{
let g:jsx_ext_required = 0      "hightlight jsx in .js
let g:used_javascript_libs = 'angularjs,angularui,angularuirouter'
" }}}

" emmet-vim --- {{{
let g:user_emmet_install_global = 0
augroup emmet_configuration
    autocmd!
    autocmd FileType html,css,scss,html.twig,javascript.jsx,htmldjango.twig EmmetInstall                      " Enable emmet for just few files
    autocmd FileType html,css,scss,html.twig,javascript.jsx,htmldjango.twig :call MapTabForEmmetExpansion()   " Tab expands the expression, woot!
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
let g:startify_change_to_vcs_root = 1
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

" tagbar --- {{{
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_sort = 0 " Sort according to their structure in file & not filename
let g:tagbar_ctags_bin = '/usr/local/bin/uctags'
nnoremap <leader>t :TagbarToggle<CR>
" }}}

" vim-move --- {{{
vmap <C-k> <Plug>MoveBlockUp
vmap <C-j> <Plug>MoveBlockDown
" }}}

" php.vim --- {{{
let g:php_html_load = 0
" }}}

" auto-pairs-gentle --- {{{
" let g:AutoPairsMultilineClose = 0
let g:AutoPairsUseInsertedCount = 1
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
nnoremap <silent> <leader>j :call fzf#vim#buffer_tags('', { 'options': ['--nth', '1,2', '--query', '^f$ '] })<CR>
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

" ack.vim --- {{{
" use ripgrep for searching ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search
" case sensitively otherwise
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'
" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1
" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1
" Don't jump to first match
cnoreabbrev Ack Ack!
" Maps <leader>/ so we're ready to type the search keyword
nnoremap <Leader>/ :Ack!<Space>
" }}}

" vim-argwrap --- {{{
let g:argwrap_tail_comma_braces = '['
" read mapping as format arguments
nnoremap <silent> <leader>fa :ArgWrap<CR>
" }}}

" vim-airline --- {{{
let g:airline_powerline_fonts = 1                                 " Enable powerline fonts
let g:airline#extensions#tabline#enabled = 1                      " Enable tabline extension
let g:airline#extensions#tabline#left_sep = ' '                   " Left separator for tabline
let g:airline#extensions#tabline#left_alt_sep = '│'               " Right separator for tabline
let g:airline#extensions#tabline#fnamemod = ':t'                  " Show just the filename
let g:airline_theme='gruvbox'

" Customize airline content
"+-----------------------------------------------------------------------------+
"| A | B |                     C                            X | Y | Z |  [...] |
"+-----------------------------------------------------------------------------+<Paste>
" remove encoding text & devicon
au VimEnter * let g:airline_section_x = airline#section#create_right(['tagbar']) | :AirlineRefresh
let g:airline_section_y = ''
" Line number/Total lines | Column Number with right padding
let g:airline_section_z='%4l/%L : %-3v'
" disable +32 ~9 -0 hunks information in airline section B
let g:airline#extensions#hunks#enabled = 0
" }}}

" vim-togglecursor --- {{{
let g:togglecursor_default = 'block'
let g:togglecursor_insert = 'line'
let g:togglecursor_force = 'xterm'   " telling xterm style terminal to make it work in vagrant & ssh
" }}}

" vim-highlightedyank --- {{{
if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif
let g:highlightedyank_highlight_duration=250
" }}}

" ale --- {{{
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
" By default it expects .eslintrc jo be at the root
" For custom eslintrc use:
" let g:ale_javascript_eslint_options = '--config ./config/eslint.config.js'
" Auto fix linting errors on save
let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
let g:ale_fixers = {
\   'typescript': ['prettier', 'eslint'],
\   'javascript': ['prettier', 'eslint'],
\   'scss': ['prettier'],
\   'css': ['prettier']
\}
let g:ale_fix_on_save = 1
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

" neoclide/coc.nvim --- {{{
" TODO look into these options to which one's are

" Reference: https://github.com/neoclide/coc.nvim#example-vim-configuration
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Remap keys for gotos
" Uses coc.nvim to go to a tag when c-]
set tagfunc=CocTagFunc
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
" Overrides gt which is for tabs, I don't use tabs anymore but in case things
" break for tabs, remove this
nmap <silent> gt <Plug>(coc-type-definition)

" Use <leader>i to show documentation under the cursor
nnoremap <silent> <leader>i :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Insert mode - <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Normal mode - <c-space> to trigger codaction that lets quick import & other
" smart operations.
nmap <c-space> <Plug>(coc-codeaction)

" Show parameter signature help when in insert mode
" TODO: Figure, why does it goes away
" https://github.com/neoclide/coc.nvim/issues/2951
" inoremap <silent><c-space> <C-\><C-O>:call CocActionAsync('showSignatureHelp')<cr>

" Use c-f & c-b to scroll up & down the documentation if it exists
" https://github.com/neoclide/coc.nvim/issues/1841
nnoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" }}}

" voldikss/vim-floaterm --- {{{
nnoremap <silent> - :FileBrowser<CR>
command! FileBrowser FloatermNew --width=0.8 nnn
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
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
nmap <Leader>gs <Plug>(GitGutterPreviewHunk)
" }}}

" JamshedVesuna/vim-markdown-preview --- {{{
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=2
" }}}

" }}}

" Helpful mappings --- {{{
" Current Directory remap to :%%
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' :'%%'

" Open chrom with :chrome command
" TODO: Make this available only on html file types
command! Chrome !open % -a Google\ Chrome
cnoreabbrev chrome Chrome

" Strip trailing white spaces --- {{{
" http://vimcasts.org/episodes/tidying-whitespace/
command! -nargs=* StripTrailingWhitespaces call StripTrailingWhitespaces()
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
cnoreabbrev bd BD
cnoreabbrev Bd BD
cnoreabbrev Copen copen
cnoreabbrev gblame Gblame
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

" Casing made easy
nnoremap <c-u> gUiw

" Y will yank till the end of the word
nnoremap Y y$

" Quick add single quote
vnoremap ' <esc>a'<esc>`<i'<esc>

" Paste to clipboard
vnoremap <leader>y "+Y

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
" }}}

" Autocmd --- {{{
" Auto source vimrc on save
autocmd! bufwritepost ~/.vimrc source $MYVIMRC

" <leader>r => Run
augroup leader_run
    " Runs respective test case for php file
    autocmd FileType php map <buffer> <Leader>r :call VimuxRunCommand("clear;phpunit -c app/ " . bufname("%"))<CR>
    " Compiles & runs the java file
    autocmd FileType java map <buffer> <Leader>r :call VimuxRunCommand("clear;javac ".bufname("%")." ;java ".expand("%:r"))<CR>
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
" }}}
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

" Make focused windwo more prominent in VIM --- {{{
let g:WincentColorColumnFileTypeBlacklist = ['command-t', 'diff', 'dirvish', 'fugitiveblame', 'undotree', 'qf']
let g:WincentColorColumnBufferNameBlacklist = []
function! ShouldColorColumn() abort
  if index(g:WincentColorColumnBufferNameBlacklist, bufname(bufnr('%'))) != -1
    return 0
  endif
  if index(g:WincentColorColumnFileTypeBlacklist, &filetype) != -1
    return 0
  endif
  return &buflisted
endfunction

if exists('+winhighlight')
  autocmd BufEnter,FocusGained,VimEnter,WinEnter * set winhighlight=
  autocmd FocusLost,WinLeave * set winhighlight=CursorLineNr:LineNr,EndOfBuffer:ColorColumn,IncSearch:ColorColumn,Normal:ColorColumn,NormalNC:ColorColumn,SignColumn:ColorColumn
  if exists('+colorcolumn')
    autocmd BufEnter,FocusGained,VimEnter,WinEnter * if ShouldColorColumn() | let &l:colorcolumn='+' . join(range(0, 254), ',+') | endif
  endif
elseif exists('+colorcolumn')
  autocmd BufEnter,FocusGained,VimEnter,WinEnter * if ShouldColorColumn() | let &l:colorcolumn='+' . join(range(0, 254), ',+') | endif
  autocmd FocusLost,WinLeave * if ShouldColorColumn() | let &l:colorcolumn=join(range(1, 255), ',') | endif
endif
" }}}

" }}}
