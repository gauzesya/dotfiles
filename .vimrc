" .vimrc

" requirements
" curl, powerline_font, fzf

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
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'

" file operation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'thinca/vim-quickrun'

" highlight
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" linter & formatter
Plug 'dense-analysis/ale'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" clojure
Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'liquidz/vim-iced', {'for': 'clojure'}
Plug 'liquidz/vim-iced-asyncomplete', {'for': 'clojure'}

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

" indent
set smartindent

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
try
  colorscheme onedark
catch
  colorscheme elflord
endtry

" vim-airline
set laststatus=2
let g:airline_theme='onedark'
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
nnoremap st :<C-u>CtrlPBuffer<CR>
nnoremap sf :<C-u>CtrlP<CR>
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_extensions = ['tag']
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:18'

" vim-easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap <Leader>s <Plug>(easymotion-s2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
nmap g/ <Plug>(easymotion-sn)

" Vista
let g:vista_default_executive = 'vim_lsp'
nnoremap <Leader>t :Vista!!<CR>
nnoremap <Leader>r :Vista finder<CR>

" asyncomplete & vim-lsp
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> K <plug>(lsp-hover)

    let g:lsp_format_sync_timeout = 1000
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_popup_delay = 200
let g:lsp_signs_enabled = 0
let g:lsp_diagnostics_enabled = 0
let g:lsp_document_code_action_signs_enabled = 0

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

if executable('typescript-language-server')
    " npm install -g typescript-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx', 'typescriptreact'],
        \ })
endif

" ale
let g:ale_linters = {
      \ 'python': ['flake8', 'mypy'],
      \ 'typescript': ['eslint'],
      \}
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'python': ['autopep8', 'black', 'isort'],
      \ 'typescript': ['eslint', 'prettier'],
      \ 'typescriptreact': ['eslint', 'prettier'],
      \}
let g:ale_sign_column_always = 1
let g:ale_change_sign_column_color = 1
nmap <silent> =G <Plug>(ale_fix)

" vim-iced
let g:iced_enable_default_key_mappings = v:true

" load own vimrc
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
