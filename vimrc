call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'
Plug 'mattn/emmet-vim'                        " Emmet for html
Plug 'evidens/vim-twig'                       " Twig Syntax highlighting
Plug 'hail2u/vim-css3-syntax'                 " CSS3 Syntax
Plug 'vim-airline/vim-airline'
Plug 'othree/html5.vim'                       " Html5 syntax, indent
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'
Plug 'osyo-manga/vim-anzu'                    " Show search results on vim-airline
Plug 'pangloss/vim-javascript'                " Better syntax highlighting & indent
Plug 'mxw/vim-jsx'                            " JSX highlighting (requires pangloss/vim-javascript)
Plug 'elzr/vim-json'                          " JSON highlighting
Plug 'ryanoasis/vim-devicons'
Plug 'stephpy/vim-yaml'                       " Coz Vanilla yaml in vim is slow
Plug 'tpope/vim-surround'                     " Change the surrounding
Plug 'tpope/vim-repeat'                       " Repeat plugin commands
Plug 'jszakmeister/vim-togglecursor'          " Different cursors in different modes
Plug 'othree/javascript-libraries-syntax.vim' "JS Plugin library syntax support
Plug 'tpope/vim-commentary'                   " Comment/uncomment plugin
Plug 'tpope/vim-fugitive'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
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
Plug 'tpope/vim-sleuth'                       " Adjust tabs & spaces for you, Note: REMOVE if this annoys me

call plug#end()

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
set wildmode=list:longest,full
set mouse=c                       " Disable cursor
set hidden                        " Can hide buffer in non saved state

" Remap leader key
let mapleader = "\<Space>"

" Color Scheme {"
set background=dark
if (has("termguicolors"))
  " Enable true colors if available
  set termguicolors
  colorscheme gruvbox
  set cursorline
else
  set t_Co=256
  let base16colorspace=256
  colorscheme base16-material
endif
" }

let g:jsx_ext_required = 0      "hightlight jsx in .js
let g:used_javascript_libs = 'angularjs,angularui,angularuirouter'

" Emmet Plugin Configs
let g:user_emmet_install_global = 0
autocmd FileType html,css,scss,html.twig,javascript.jsx,htmldjango.twig EmmetInstall                      " Enable emmet for just few files
autocmd FileType html,css,scss,html.twig,javascript.jsx,htmldjango.twig :call MapTabForEmmetExpansion()   " Tab expands the expression, woot!
let g:user_emmet_mode="i"                                                  " Use emmit for insert mode only
let g:cssColorVimDoNotMessMyUpdatetime = 1

" Startify plugin configs
" Use :SS to save a session
let g:startify_change_to_dir = 0 "Don't change the cwd to opened file through startify
let g:startify_session_persistence = 1
let g:startify_list_order = ['sessions', 'dir']
let g:startify_files_number = 5
let g:startify_list_order = [
            \ ['   Sessions'],
            \ 'sessions',
            \ ['   Recent Files'],
            \ 'dir',
            \ ]

" Tagbar alias
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_sort = 0 " Sort according to their structure in file & not filename
nmap <leader>t :TagbarToggle<CR>/

" Move plugin alias
vmap <C-k> <Plug>MoveBlockUp
vmap <C-j> <Plug>MoveBlockDown

" Current Directory remap to :%%
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' :'%%'

" Set tabstop, softtabstop and shiftwidth to the same value. ( Ex :Stab<CR>4 )
command! -nargs=* Stab call Stab()

" php.vim config
let g:php_html_load = 0

" auto-pairs config
" let g:AutoPairsMultilineClose = 0
let g:AutoPairsUseInsertedCount = 1

" Key Mappings {
" Map annoying bD to bd => to delete buffer
cnoreabbrev bD bd
" Buffer Mappings
" Buffer kill and persist window
cnoreabbrev bd BD
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

" --- [ and ] prefix mappings --- {"
" Quickly add empty lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
" Mappings external paste
nnoremap <silent> <leader>o  :call <SID>setup_paste()<CR>o
nnoremap <silent> <leader>O  :call <SID>setup_paste()<CR>O
nnoremap <silent> <leader>i  :call <SID>setup_paste()<CR>i
" Navigate buffer
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
" Navigate quickfix
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
"Tabs switch
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>
" }

" Zoom in & out using leader + z
nnoremap <silent><leader>z :ZoomToggle<CR>

" Run phpunit test cases for the current file
autocmd FileType php map <buffer> <Leader>r :call VimuxRunCommand("clear;phpunit -c app/ " . bufname("%"))<CR>
autocmd FileType java map <buffer> <Leader>r :call VimuxRunCommand("clear;javac ".bufname("%")." ;java ".expand("%:r"))<CR>

" Y will yank till the end of the word
nmap Y y$
" }

" Some vimfu to make life easier {
" Hyphen names as single word for style files
au FileType css,scss setl iskeyword+=-

" Resize all open windows propotionally when the terminal is resized
autocmd VimResized * :wincmd =

" }

" tags
nnoremap <C-]> g<C-]>

" FZF configs {
let g:fzf_layout = { 'down': '~25%' }
nnoremap <C-p> :call FzfOmniFiles()<CR>
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
" }

" Ack {
" Don't jump to first match
cnoreabbrev Ack Ack!

nnoremap <Leader>/ :Ack!<Space>

" use ripgrep for searching ⚡️
let g:ackprg = 'rg --vimgrep --no-heading --smart-case'
let g:ack_autoclose = 1
let g:ack_use_cword_for_empty_search = 1 "Any empty ack search will search for the work the cursor is on
" }

" ArgWrap Config {
let g:argwrap_tail_comma_braces = '['
" read mapping as format arguments
nnoremap <silent> <leader>fa :ArgWrap<CR>
" }

" Airline setup
let g:airline_powerline_fonts = 1                                 " Enable powerline fonts
let g:airline#extensions#tabline#enabled = 1                      " Enable tabline extension
let g:airline#extensions#tabline#left_sep = ' '                   " Left separator for tabline
let g:airline#extensions#tabline#left_alt_sep = '│'               " Right separator for tabline
let g:airline#extensions#tabline#fnamemod = ':t'                  " Show just the filename
let g:airline_theme='gruvbox'
" remove encoding text & devicon
au VimEnter * let g:airline_section_x = airline#section#create_right(['tagbar']) | :AirlineRefresh
let g:airline_section_y = ''
let g:webdevicons_enable_airline_statusline_fileformat_symbols=0

"Cursor Settings
let g:togglecursor_default = 'block'
let g:togglecursor_insert = 'line'
let g:togglecursor_force = 'xterm'   " telling xterm style terminal to make it work in vagrant & ssh

"Auto commands
autocmd FileType javascript setlocal sw=2 sts=2 ts=2
autocmd ColorScheme * highlight StatusLine ctermbg=darkgray cterm=NONE guibg=darkgray gui=NONE

" Vim Anzu (Search results on vim-airline)
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
nmap <silent> <leader><space> :nohlsearch<CR><Plug>(anzu-clear-search-status)
let g:anzu_enable_CursorMoved_AnzuUpdateSearchStatus=1        "When search with /
let g:airline#extensions#anzu#enabled=0

" One way behaviour for n & N
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

" YouCompleteMe settings {
let g:ycm_min_num_of_chars_for_completion = 4
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_comments = 1
" Don't show YCM's preview window
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
" For line completion close the ycm dialogue first, otherwise it comes in the way
inoremap <expr> <C-x><C-l> CloseYcmIfOpen()
function! CloseYcmIfOpen()
  if pumvisible()
    return "\<C-e>\<C-x>\<C-l>"
  endif
  return "\<C-x>\<C-l>"
endfunction
" }

" Custom Functions
function! MapTabForEmmetExpansion()
  imap <expr> <leader><tab> emmet#expandAbbrIntelligent("\<tab>")
endfunc

" Helpers for changing tab space settings {
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
" }

" YouCompleteMe is the best & if that's not working, this is a pretty good
" auto completion on tab pressing
" multi-purpose tab key (auto-complete) {
" function! InsertTabWrapper()
"   let col = col('.') - 1
"   if !col || getline('.')[col - 1] !~ '\k'
"     return "\<tab>"
"   else
"     return "\<c-p>"
"   endif
" endfunction
" inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" }

" Execute macro on visually selected lines with @{macro} {{
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
" }}

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

" Run FZF in git mode if available else normal file mode
fun! FzfOmniFiles()
  " When I change current working directory, I'm just concerned with files
  " inside that directory (:Files) & not all project files (:GitFiles)
  let git_root = split(system('git rev-parse --show-toplevel'), '\n')[0]
  let cwd = getcwd()
  " Throws v:shell_error if is not a git directory
  let is_git = system('git status')
  if cwd != git_root || v:shell_error
    :Files
  else
    " --exclude-standard means respecting gitignore
    " --others help in showing the untracked git files
    :GitFiles --exclude-standard --cached --others
  endif
endfun
