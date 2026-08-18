" plugins 

call plug#begin()
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'tomasiser/vim-code-dark'
Plug 'ku1ik/vim-monokai'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
call plug#end()
