map <space> <leader>
noremap ; :

" Moving between buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" redo
nnoremap U <C-r>
nnoremap Y y$
nnoremap S hs

nnoremap Q gQ
" reload config on Ctrl-R
nnoremap <C-r> :so $MYVIMRC<CR>

nnoremap <leader>q :q<cr>
nnoremap <leader>Q :wqa<cr>
" prevent entering Ex mode by error
nnoremap Q <nop>
nnoremap <leader>s :up<cr>
nnoremap <leader>d :bd<cr>
nnoremap <leader>D :%bd<cr>

" go to the folder of the current file
nnoremap <leader>cd :cd %:p:h<CR>

" normal mode with jk
" imap jk <Esc>

" clear last search
nnoremap <silent> \\ :nohlsearch<CR><CR>
"<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" fzf
nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>F :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>a :Rg<Space>
nnoremap <Leader>C :Commands<CR>

nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gp :Gpull<CR>
nnoremap <Leader>gP :Gpush<CR>
nnoremap <Leader>gPP :call s:PushForceSafe()<CR>
nnoremap <Leader>go :Gbranch<CR>
nnoremap <Leader>gv :GV<CR>
nnoremap <Leader>gV :GV!<CR>
nnoremap <Leader>gb :Twiggy<CR>

function! s:PushForceSafe()
  if confirm('Are you sure you want to force-push?', "&Yes\n&No", 1)==1
    execute('Gpush --force')
  endif
endfunction

function! s:changebranch(branch)
    execute 'Git checkout' . a:branch
    " call feedkeys("i")
endfunction

command! -bang Gbranch call fzf#run({
            \ 'source': 'git branch -a --no-color | grep -v "^\* " ',
            \ 'sink': function('s:changebranch')
            \ })

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

augroup nmeovim_terminal
autocmd!
autocmd TermOpen * :setlocal nonumber norelativenumber
augroup END
