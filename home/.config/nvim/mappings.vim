map <space> <leader>
noremap ; :

" Moving between buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" complete on shift-tab
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : deoplete#mappings#manual_complete()
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" complete navigation
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>\<Esc>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
autocmd InsertLeave, CompletedDone * if pumvisible() == 0 | pclose | endif

" redo
nnoremap U <C-r>


" reload config on Ctrl-R
nnoremap <C-r> :so $MYVIMRC<CR>


nnoremap <leader>q :q<cr>
nnoremap <leader>Q :wqa<cr>
" prevent entering Ex mode by error
nnoremap Q <nop>
nnoremap <leader>s :w<cr>

" go to the folder of the current file
nnoremap <leader>cd :cd %:p:h<CR>

" normal mode with jk
imap jk <Esc>

" clear last search
nnoremap <silent> <ESC> :nohlsearch<CR><CR> 
nnoremap <esc>[ <esc>[

" commenting with Ctrl-/
nmap <C-_>  gcc
vmap <C-_>  gc

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

""""""""""" terminal

tnoremap <Esc><Esc> <C-\><C-n>
" Maps ctrl-b + c to open a new tab window
"
nnoremap <leader>tt :tabnew +terminal<CR>
tnoremap <leader>tt <C-\><C-n>:tabnew +terminal<CR>

" Maps ctrl-b + " to open a new horizontal split with a terminal
nnoremap <leader>t- :new +terminal<CR>
tnoremap <leader>t- <C-\><C-n>:new +terminal<CR>

" Maps ctrl-b + % to open a new vertical split with a terminal
nnoremap <leader>t\| :vnew +terminal<CR>
tnoremap <leader>t\| <C-\><C-n>:vnew +terminal<cr>

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

augroup neovim_terminal
  autocmd!
  autocmd TermOpen * startinsert
  autocmd TermOpen * :set nonumber norelativenumber
augroup END
