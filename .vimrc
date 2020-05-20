" .vimrc

" requirements
" curl, git, powerline_font
" jedi, flake8, autopep8, black, isort for python


" plugin
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'thinca/vim-quickrun'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'

Plug 'davidhalter/jedi-vim', {'for': 'python'}

call plug#end()


" leader
let mapleader="\<Space>"


" file
set nobackup
set noswapfile
set autoread
set hidden

" encode
set enc=utf-8

" clopboard
set clipboard+=unnamed,autoselect

" looklike
set showcmd
set number
set cursorline
set showmatch

" tab
set list listchars=tab:\?\-
set expandtab
set tabstop=2
set shiftwidth=2

" search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

" nobeeep
set noerrorbells
set vb t_vb=

" no auto-commentout
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" move
nnoremap j gj
nnoremap k gk
nnoremap s <nop>
nnoremap <silent>sp :bprevious<CR>
nnoremap <silent>sn :bnext<CR>
nnoremap <silent>sb :b#<CR>
nnoremap <silent>sd :bdelete<CR>
nnoremap <silent>sv :vs<CR>
nnoremap <silent>ss :sp<CR>
nnoremap <silent>sh <c-w>h
nnoremap <silent>sj <c-w>j
nnoremap <silent>sk <c-w>k
nnoremap <silent>sl <c-w>l


" colorscheme
set background=dark
try
  colorscheme molokai
catch
  colorscheme elflord
endtry
set t_Co=256
syntax on


" vim-airline
set laststatus=2
let g:airline_theme='molokai'
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled=1


" ale
let g:ale_sign_column_always=1
let g:ale_lint_on_save=1
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_enter=0
let g:ale_fix_on_save = 0
nnoremap <silent> <C-k> <Plug>(ale_previous_wrap)
nnoremap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_linters = {
    \ 'python': ['flake8'],
    \ }
let g:ale_fixers = {
    \ 'python': ['autopep8', 'black', 'isort'],
    \ }


" nerdtree
nnoremap <Leader>f :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1


" vim-quickrun
nnoremap <silent> <Leader>q :QuickRun<CR>
nnoremap <silent> <Leader><Leader>q :QuickRun -input =@+<CR>
let g:quickrun_config = {
\   '_' : {
\     'runner' : 'job',
\     'outputter/buffer/split'  : ':rightbelow 8sp',
\   },
\}


" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" ctrlp
let g:ctrlp_map = '<Nop>'
nnoremap sb :<C-u>CtrlPBuffer<CR>
nnoremap sf :<C-u>CtrlP<CR>
nnoremap st :<C-u>CtrlPTag<CR>
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_extensions = ['tag']
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:18'


" jedi-vim
autocmd FileType python setlocal completeopt-=preview
let g:jedi#popup_on_dot=0


" load own vimrc
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
