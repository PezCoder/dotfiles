set nocompatible                       " don't need to be compatible with old vim
"Load up vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'                        " Emmet for html
Plugin 'evidens/vim-twig'                       " Twig Syntax highlighting
Plugin 'hail2u/vim-css3-syntax'                 " CSS3 Syntax
Plugin 'vim-airline/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'                     " Fuzzy file/buffer search
Plugin 'othree/html5.vim'                       " Html5 syntax, indent
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mhartington/oceanic-next'
Plugin 'osyo-manga/vim-anzu'                    " Show search results on vim-airline
Plugin 'pangloss/vim-javascript'                " Better syntax highlighting & indent
Plugin 'mxw/vim-jsx'                            " JSX highlighting (requires pangloss/vim-javascript)
Plugin 'elzr/vim-json'                          " JSON highlighting
Plugin 'ryanoasis/vim-devicons'
Plugin 'danro/rename.vim'                       " Rename using :Rename {newname}
Plugin 'stephpy/vim-yaml'                       " Coz Vanilla yaml in vim is slow
Plugin 'tpope/vim-surround'                     " Change the surrounding
Plugin 'tpope/vim-repeat'                       " Repeat plugin commands
Plugin 'jszakmeister/vim-togglecursor'          " Different cursors in different modes
Plugin 'othree/javascript-libraries-syntax.vim' "JS Plugin library syntax support
Plugin 'tpope/vim-commentary'                   " Comment/uncomment plugin

call vundle#end()
filetype plugin indent on

set nobackup                      " get rid of anoying ~file
if !has('nvim')
  set encoding=utf-8
end
runtime macros/matchit.vim        " autoload that extends % functionality
syntax on                         " show syntax highlighting
set autoindent                    " set auto indent
set ts=2                          " set indent to 2 spaces
set shiftwidth=2
set softtabstop=2
set expandtab                     " use spaces, not tab characters
set relativenumber                " show relative line numbers
set showmatch                     " show bracket matches
set ignorecase                    " ignore case in search
set hlsearch                      " highlight all search matches
set incsearch                     " show search results as I type
set cursorline                    " highlight current line
set smartcase                     " pay attention to case when caps are used
set ttimeoutlen=100               " decrease timeout for faster insert with 'O'
set vb                            " enable visual bell (disable audio bell)
set ruler                         " show row and column in footer
set scrolloff=2                   " minimum lines above/below cursor
set laststatus=2                  " always show status bar
set list listchars=tab:»·,trail:· " show extra space characters
set nofoldenable                  " disable code folding
set wildmenu                      " enable bash style tab completion
set wildmode=list:longest,full
set t_Co=256                      " Coz my iterm2 supports it
set mouse=c                       " Disable cursor
set hidden                        " Can hide buffer in non saved state

" Remap leader key
let mapleader = "\<Space>"

" Enable true colors if available
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
  set termguicolors
endif

" Color Scheme {"
set background=dark
if has("nvim")
  colorscheme OceanicNext
else
  let base16colorspace=256
  colorscheme base16-material
endif
" }

let g:jsx_ext_required = 0      "hightlight jsx in .js
let g:used_javascript_libs = 'angularjs,angularui,angularuirouter'

" Emmet Plugin Configs
let g:user_emmet_install_global = 0
autocmd FileType html,css,scss,html.twig,javascript.jsx EmmetInstall                      " Enable emmet for just few files
autocmd FileType html,css,scss,html.twig,javascript.jsx :call MapTabForEmmetExpansion()   " Tab expands the expression, woot!
let g:user_emmet_mode="i"                                                  " Use emmit for insert mode only
let g:cssColorVimDoNotMessMyUpdatetime = 1

" Current Directory remap to :%%
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' :'%%'

" Set tabstop, softtabstop and shiftwidth to the same value. ( Ex :Stab<CR>4 )
command! -nargs=* Stab call Stab()

" Key Mappings {
" Buffer Mappings
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j
nnoremap <leader>c <C-w>c
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
"Save file
nnoremap <Leader>w :w<CR>
"Save & Quit file
nnoremap <Leader>q :wqa<CR>
"Tabs switch
nmap <leader>[ :tabnext<CR>
nmap <leader>] :tabprev<CR>
" Quickly add empty lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
" Mappings extermal paste
nnoremap <silent> <leader>o  :call <SID>setup_paste()<CR>o
nnoremap <silent> <leader>O  :call <SID>setup_paste()<CR>O
" }

" Control-p configs {
" start in filesearch mode
let g:ctrlp_by_filename = 1
let g:ctrlp_custom_ignore = {
\ 'dir': '\v[\/]\.(dist|assetic|vendor|node_modules|DS_Store|git)$',
\ 'file': '\v\.(exe|so|dll)$',
\ }
let g:ctrlp_working_path_mode = ''      " Current working directory of vim

" Make Ctrl-P Faster
let g:ctrlp_use_caching = 0
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
  \ }
endif
" }

" Airline setup
let g:airline_powerline_fonts = 1                                 "Enable powerline fonts
let g:airline#extensions#tabline#enabled = 1                      "Enable tabline extension
let g:airline#extensions#tabline#left_sep = ' '                   "Left separator for tabline
let g:airline#extensions#tabline#left_alt_sep = '│'               "Right separator for tabline
let g:airline#extensions#tabline#fnamemod = ':t'                  " Show just the filename
let g:airline_theme='oceanicnext'

"Cursor Settings
let g:togglecursor_default = 'block'
let g:togglecursor_force = 'xterm'   " telling xterm style terminal to make it work in vagrant & ssh

"Auto commands
augroup vimrc
  autocmd!
augroup END
"autocmd vimrc FileType javascript setlocal sw=2 sts=2 ts=2                      "Set 2 indent for html
autocmd ColorScheme * highlight StatusLine ctermbg=darkgray cterm=NONE guibg=darkgray gui=NONE

" Vim Anzu (Search results on vim-airline)
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
nmap <silent> <leader><space> :nohlsearch<CR><Plug>(anzu-clear-search-status)
let g:anzu_enable_CursorMoved_AnzuUpdateSearchStatus=1        "When search with /

" One way behaviour for n & N
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

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

" multi-purpose tab key (auto-complete) {
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>
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
