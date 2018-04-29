filetype plugin on
syntax on

set ttyfast
set noerrorbells novisualbell
set hlsearch
set ignorecase smartcase
set incsearch
set showcmd
set number
set background=dark

highlight Comment cterm=italic gui=italic

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
