let maplocalleader = "\\"
let mapleader = ' '

" Moving between buffers
nnoremap <C-\> :BA<CR>
nnoremap <leader>d :BD<cr>
nnoremap <leader>D :%bd<cr>

" Moving between tabs
nnoremap ]t :tabnext<CR>
nnoremap [t :tabprev<CR>

" redo
nnoremap U <C-r>
nnoremap Y y$

nnoremap Q gQ
" reload config on <leader>R
nnoremap <leader>R :so $MYVIMRC<CR>

nnoremap <leader>q :q<cr>
nnoremap <leader>Q :wqa<cr>
" prevent entering Ex mode by error
nnoremap Q <nop>
nnoremap <leader><space> :up<cr>

" select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" go to the folder of the current file
nnoremap <leader>cd :cd %:p:h<CR>

" clear last search
nnoremap <silent> <CR> :nohls<CR><CR>

nnoremap <Leader>g :silent grep<Space>

" fzf
nnoremap <Leader>f :GitFiles --recurse-submodules<CR>
nnoremap <Leader>F :ProjectFiles<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>r :Rg<Space>
nnoremap <Leader>C :Commands<CR>

nnoremap <Leader>gf :Gfetch<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gp :Gpull<CR>
nnoremap <Leader>gP :Gpush<CR>
nnoremap <Leader>gPP :GPushForce<CR>
nnoremap <Leader>go :Gbranch<CR>
nnoremap <Leader>gl :GV<CR>
nnoremap <Leader>gL :GV!<CR>
nnoremap <Leader>gb :Twiggy<CR>
nnoremap <Leader>grm :Git rebase master<CR>

nnoremap <Leader>gA :Git add %:p<cr><cr>

nnoremap ]h :GitGutterNextHunk<CR>
nnoremap [h :GitGutterPrevHunk<CR>
nnoremap <leader>ga :GitGutterStageHunk<CR>
nnoremap <leader>gu :GitGutterUndoHunk<CR>
nnoremap <leader>gd :GitGutterPreviewHunk<CR>


onoremap ih <Plug>(GitGutterTextObjectInnerPending)
onoremap ah <Plug>(GitGutterTextObjectOuterPending)
xnoremap ih <Plug>(GitGutterTextObjectInnerVisual)
xnoremap ah <Plug>(GitGutterTextObjectOuterVisual)

nnoremap <silent> [c :Lfprev<CR>
nnoremap <silent> ]c :Lfnext<CR>


"GitGutterLineNrHighlightsEnable

function! s:PushForceSafe()
  if confirm('Are you sure you want to force-push?', "&Yes\n&No", 1)==1
    execute('Gpush --force-with-lease')
  endif
endfunction

command! -bang GPushForce call s:PushForceSafe()

function! s:changebranch(branch)
  if a:branch =~ 'remotes/'
    execute 'Git checkout --track ' . a:branch
  else
    execute 'Git checkout' . a:branch
  endif
endfunction

command! -bang Gbranch call fzf#run({
            \ 'source': 'git branch -a --no-color | grep -v "^\* " ',
            \ 'sink': function('s:changebranch')
            \ })

" commenting with Ctrl-/
nmap <C-_>  gcc
vmap <C-_>  gc

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

""""""""""" terminal

tnoremap <Esc><Esc> <C-\><C-n>

nnoremap <leader>tt :tabnew term://fish<CR>
tnoremap <leader>tt <C-\><C-n>:tabnew term://fish<CR>

nnoremap <leader>t- :new +terminal<CR>
tnoremap <leader>t- <C-\><C-n>:new +terminal<CR>

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

" Do not include white space characters when using $ in visual mode
xnoremap $ g_
