set nocompatible                       " don't need to be compatible with old vim
"Load up vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'ryanoasis/vim-webdevicons'
Plugin 'mattn/emmet-vim'                " Emmet for html
Plugin 'evidens/vim-twig'               " Twig Syntax highlighting
Plugin 'hail2u/vim-css3-syntax'         " CSS3 Syntax
Plugin 'vim-airline/vim-airline'
Plugin 'kien/ctrlp.vim'                 " Fuzzy file/buffer search
Plugin 'othree/html5.vim'               " Html5 syntax, indent
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
filetype plugin indent on

set nobackup                      " get rid of anoying ~file
set encoding=utf-8
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
set clipboard=unnamed             " use the system clipboard
set wildmenu                      " enable bash style tab completion
set wildmode=list:longest,full
set t_Co=256                      " Coz my iterm2 supports it

" Color Scheme Settings
set background=dark
let base16colorspace=256
colorscheme base16-material

" emmet key remap
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
let g:cssColorVimDoNotMessMyUpdatetime = 1

" Current Directory remap
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' :'%%'

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
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

" Buffer Mappings
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j
nnoremap <leader>c <C-w>c
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Custom Leader mappings
nmap <silent> <leader><space> :nohlsearch<CR>

" Control-p configs
let g:ctrlp_custom_ignore = 'dist\|assetic\|vendor\|node_modules\|DS_Store\|git'
let g:ctrlp_working_path_mode = '' " Current working directory of vim

" Airline setup
let g:airline_powerline_fonts = 1                                               "Enable powerline fonts
let g:airline_theme = "hybrid"                                                  "Set theme to powerline default theme
let g:airline_section_y = '%{substitute(getcwd(), expand("$HOME"), "~", "g")}'  "Set relative path
let g:airline#extensions#whitespace#enabled = 0                                 "Disable whitespace extension
let g:airline#extensions#tabline#enabled = 1                                    "Enable tabline extension
let g:airline#extensions#tabline#left_sep = ' '                                 "Left separator for tabline
let g:airline#extensions#tabline#left_alt_sep = '│'                             "Right separator for tabline


" ================ Auto commands ======================
augroup vimrc
  autocmd!
augroup END

"autocmd vimrc FileType javascript setlocal sw=2 sts=2 ts=2                      "Set 2 indent for html
