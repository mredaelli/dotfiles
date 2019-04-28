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

" navigate lint errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" redo 
nnoremap U <C-r>


" reload config on Ctrl-R
nnoremap <C-r> :so $MYVIMRC<CR>


nnoremap <leader>q :q<cr>
nnoremap <leader>Q :wq<cr>
nnoremap <leader>w :w<cr>


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
