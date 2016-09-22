set nocompatible                    " don't need to be compatible with old vim
"Load up vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'             " Emmet for html
Plugin 'evidens/vim-twig'            " Twig Syntax highlighting
Plugin 'hail2u/vim-css3-syntax'      " CSS3 Syntax
Plugin 'mhartington/oceanic-next'
Plugin 'vim-airline/vim-airline'
Plugin 'kien/ctrlp.vim'              " Fuzzy file/buffer search
Plugin 'othree/html5.vim'            " Html5 syntax, indent

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
" set cursorline                    " highlight current line
set smartcase                     " pay attention to case when caps are used
set incsearch                     " show search results as I type
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

" Color Scheme Settings
set background=dark
let g:airline_theme='oceanicnext'
let g:airline_powerline_fonts = 1            " use poweline supported fonts
let g:airline#extensions#tabline#enabled = 1 " airline on top
colorscheme OceanicNext

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

" Control-p configs
let g:ctrlp_custom_ignore = 'dist\|assetic\|vendor\|node_modules\|DS_Store\|git'
let g:ctrlp_working_path_mode = '' " Current working directory of vim
let g:ctrlp_cmd = 'CtrlPMRU'       " File search by default
