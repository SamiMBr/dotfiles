
" keybinds
" remove arrows usability in normal mode

noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>

" leader
let mapleader = ","

" normal mode maps

"" Reload vimrc
nnoremap <leader>r :source $MYVIMRC<CR>

"" unhighlight with Esc
nnoremap <silent> <Esc> :noh<CR><Esc>

" buffers navigation

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>

"" buffers write quit

nnoremap <leader>w :w<CR>
nnoremap <leader>W :wa<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>Q :qa!<CR>
nnoremap <leader>x :wq<CR>
nnoremap <leader>X :wqa<CR>

"" window navigation

nnoremap <leader>h <C-W>h
nnoremap <leader>l <C-W>l
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k

"" tab navigation


nnoremap <silent> <C-l> :tabn<CR> 
nnoremap <silent> <C-h> :tabp<CR> 

"" fzf plugin


nnoremap <leader>ff :Files<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>/ :History/<CR>
nnoremap <leader>ft :Filetypes<CR>

" simplify system clipboard yank and paste

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
