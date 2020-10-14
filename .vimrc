" .vimrc

" requirements
" curl, powerline_font


" plugin
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" looking
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" edit support
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" file operation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'thinca/vim-quickrun'

" lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" others
Plug 'jmcantrell/vim-virtualenv'

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
set clipboard+=unnamed

" looklike
set showcmd
set number
set signcolumn=yes
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

" other
set backspace=indent,eol,start

" colorscheme
set background=dark
syntax on
set t_Co=256
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none
try
  colorscheme onedark
catch
  colorscheme elflord
endtry

" vim-airline
set laststatus=2
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts=1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_idx_mode=1
let g:airline#extensions#virtualenv#enabled = 1

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

" ctrlp
let g:ctrlp_map = '<Nop>'
nnoremap sb :<C-u>CtrlPBuffer<CR>
nnoremap sf :<C-u>CtrlP<CR>
nnoremap st :<C-u>CtrlPTag<CR>
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_extensions = ['tag']
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:18'

" vim-easymotion
nmap <Leader>s <Plug>(easymotion-s2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
nmap g/ <Plug>(easymotion-sn)

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" asyncomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
imap <C-e> <Plug>(asyncomplete_force_refresh)

" vim-lsp
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_virtual_text_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_signs_information = {'text': 'i'}
let g:lsp_signs_hint = {'text': '?'}
nnoremap <C-]> :<C-u>LspDefinition<CR>
nnoremap K :<C-u>LspHover<CR>
nnoremap <Leader>R :<C-u>LspRename<CR>
nnoremap <Leader>n :<C-u>LspReferences<CR>
nnoremap <Leader>b :<C-u>LspDocumentDiagnostics<CR>
nnoremap <Leader>g :<C-u>LspDocumentFormat<CR>

" load own vimrc
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
