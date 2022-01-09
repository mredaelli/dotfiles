let maplocalleader = "\\"
let mapleader = ' '

" Moving between buffers
nnoremap <C-\> :b#<CR>
nnoremap <leader>d :Sayonara!<CR>
nnoremap <leader>D :%bd<cr>

" nmap J <Plug>(interactiveJoin)
" xmap J <Plug>(interactiveJoin)
nmap <leader>J <Plug>(interactiveGJoin)
xmap <leader>J <Plug>(interactiveGJoin)

" Moving between tabs
nnoremap ]t :tabnext<CR>
nnoremap [t :tabprev<CR>

" redo
nnoremap U <C-r>
nnoremap Y y$

nnoremap Q gQ
" reload config on <leader>R
nnoremap <leader>R :so $MYVIMRC<CR>

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

if new_nvim
  command! -nargs=1 Rg call luaeval('require("fzf-commands").rg(_A)', <f-args>)
  nnoremap <Leader>r :<c-u>Rg<space>

  nnoremap <Leader>f :Telescope git_files show_untracked=false recurse_submodules=true<CR>
  nnoremap <Leader>F :Telescope find_files<CR>
  nnoremap <Leader>b :Telescope buffers<CR>
  nnoremap <Leader>th :Telescope command_history<CR>
  nnoremap <Leader>tt :Telescope tags<CR>
  nnoremap <Leader>tr :Telescope live_grep<CR>
  nnoremap <Leader>tc :Telescope commands<CR>
  nnoremap <Leader>tm :Telescope marks<CR>
  nnoremap <Leader>ts :Telescope treesitter<CR>
  nnoremap <Leader>/ :Telescope current_buffer_fuzzy_find<CR>
  nnoremap <Leader>tT :Telescope current_buffer_tags<CR>
  nnoremap <Leader>q :Telescope quickfix<CR>
  nnoremap <Leader>l :Telescope loclist<CR>
  nnoremap <Leader>tH :Telescope help_tags<CR>
  nnoremap <Leader>tr :Telescope lsp_references<CR>
  nnoremap <Leader>tS :Telescope lsp_workspace_symbols<CR>
  nnoremap <Leader>ta :Telescope lsp_code_actions<CR>
  nnoremap <Leader>t] :Telescope lsp_code_definitions<CR>
  nnoremap <Leader>td :Telescope lsp_code_document_diagnostics<CR>
  nnoremap <Leader>tD :Telescope lsp_code_workspace_diagnostics<CR>
  nnoremap <Leader>gh :Telescope git_commits<CR>
  nnoremap <Leader>gH :Telescope git_bcommits<CR>
  nnoremap <Leader>gB :Telescope git_branches<CR>
  " nnoremap <Leader>tdv <cmd>lua require('telescope').extensions.dap.variables()<cr>
  " require'telescope'.extensions.dap.commands{}
" require'telescope'.extensions.dap.configurations{}
" require'telescope'.extensions.dap.list_breakpoints{}
" require'telescope'.extensions.dap.variables{}
else
  nnoremap <Leader>f :GitFiles --recurse-submodules<CR>
  nnoremap <Leader>F t:ProjectFiles<CR>
  nnoremap <Leader>b :Buffers<CR>
  nnoremap <Leader>h :History<CR>
  nnoremap <Leader>tt :BTags<CR>
  nnoremap <Leader>r :Rg<Space>
  nnoremap <Leader>tc :Commands<CR>
endif

nnoremap <Leader>gf :Git fetch<CR>
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gp :Git pull<CR>
nnoremap <Leader>gP :Git push<CR>
nnoremap <Leader>gPP :GPushForce<CR>
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

nnoremap <silent> [d :Lfprev<CR>
nnoremap <silent> ]d :Lfnext<CR>


"GitGutterLineNrHighlightsEnable

function! s:PushForceSafe()
  if confirm('Are you sure you want to force-push?', "&Yes\n&No", 1)==1
    execute('Git push --force-with-lease')
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

nnoremap <C-s> :NvimTreeToggle<CR>
" nnoremap <C-s> :NvimTreeFindFile<CR>
