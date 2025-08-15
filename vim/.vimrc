" ========================
" Basic Settings
" ========================
set nocompatible              " Disable Vi compatibility
filetype off                  " Required before using plugins
set encoding=utf-8
set number                    " Show line numbers
set relativenumber            " Relative line numbers
set cursorline                " Highlight current line
set hidden                    " Allow buffer switching without saving
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
set clipboard=unnamedplus     " Use system clipboard
set wildmenu
set incsearch
set hlsearch
set ignorecase
set smartcase
syntax on

" ========================
" Plugin Manager: vim-plug
" ========================

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Color scheme
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

" File explorer
Plug 'preservim/nerdtree'

" Git integration
Plug 'tpope/vim-fugitive'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Syntax highlighting for many languages
Plug 'sheerun/vim-polyglot'

" Auto pairs for brackets
Plug 'jiangmiao/auto-pairs'

" Commenting
Plug 'tpope/vim-commentary'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" ========================
" Color scheme
" ========================
set termguicolors
set background=dark
colorscheme catppuccin_mocha

" ========================
" coc.nvim (LSP & Completion)
" ========================
" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Use K to show documentation
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" Auto format on save
autocmd BufWritePre *.js,*.ts,*.py,*.go,*.rs,*.html,*.css,*.json,*.lua :silent! :CocCommand editor.action.formatDocument

" ========================
" NERDTree toggle
" ========================
nmap <C-n> :NERDTreeToggle<CR>

" ========================
" FZF keybinding
" ========================
nmap <C-p> :Files<CR>

" ========================
" Airline config
" ========================
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='catppuccin_mocha'

" ========================
" Misc
" ========================
" Faster updates
set updatetime=300

" Remember cursor position
augroup resCur
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

