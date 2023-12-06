let maplocalleader = "\\"
let mapleader = ' '

" don't jump to start of selection when copying
vnoremap y ygv<esc>

nnoremap H ^
nnoremap L $

" Moving between buffers
nnoremap <C-\> :b#<CR>
nnoremap <silent> <leader>d :Sayonara!<CR>
nnoremap <silent> <leader>D :%bd<cr>

" Moving between tabs
nnoremap ]t :tabnext<CR>
nnoremap [t :tabprev<CR>

" redo
nnoremap U <C-r>
nnoremap Y y$

nnoremap Q gQ
" reload config on <leader>R
nnoremap <leader>R :so $MYVIMRC<CR>

nnoremap <leader><space> :up<cr>

" select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" go to the folder of the current file
nnoremap <leader>cd :cd %:p:h<CR>

" clear last search
nnoremap <silent> <CR> :nohls<CR><CR>

nnoremap <Leader>g :silent grep<Space>


nnoremap <silent> [d :Lfprev<CR>
nnoremap <silent> ]d :Lfnext<CR>

" commenting with Ctrl-/
nmap <C-/>  gcc
vmap <C-/>  gc

nnoremap <C-k> <C-y>
nnoremap <C-j> <C-e>

" shifting text with arrows in visual mode
vmap <A-Left> <gv
vmap <A-Right> >gv
vmap <A-Down> :m '>+1<CR>gv=gv
vmap <A-Up> :m '<-2<CR>gv=gv

set splitbelow
set splitright
noremap <C-w>+ :resize +5<CR>
noremap <C-w>- :resize -5<CR>
noremap <C-w>< :vertical:resize -10<CR>
noremap <C-w>> :vertical:resize +10<CR>

tnoremap <C-w>+ <C-\><C-n>:resize +5<CR>
tnoremap <C-w>- <C-\><C-n>:resize -5<CR>
tnoremap <C-w>< <C-\><C-n>:vertical:resize -10<CR>
tnoremap <C-w>> <C-\><C-n>:vertical:resize +10<CR>

" Alt+[hjkl] to navigate through windows in insert mode
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

" Alt+[hjkl] to navigate through windows in normal mode
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Do not include white space characters when using $ in visual mode
xnoremap $ g_

nnoremap j gj
nnoremap k gk

