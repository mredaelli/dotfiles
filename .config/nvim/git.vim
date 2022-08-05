function! s:PushForceSafe()
  if confirm('Are you sure you want to force-push?', "&Yes\n&No", 1)==1
    execute('Git! push --force-with-lease')
  endif
endfunction

command! -bang GPushForce call s:PushForceSafe()

 function! s:ToggleGstatus() abort
	for l:winnr in range(1, winnr('$'))
		if !empty(getwinvar(l:winnr, 'fugitive_status'))
			execute l:winnr.'close'
		else
			Git
		endif
	endfor
endfunction

nnoremap <Leader>gf :Git fetch<CR>
nnoremap <Leader>gs :call <SID>ToggleGstatus()<CR>
nnoremap <Leader>gp :Git pull<CR>
nnoremap <Leader>gP :Git! push<CR>
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


nmap <leader>ms <plug>(MergetoolStart)
nmap <leader>mq <plug>(MergetoolStop)
nmap <leader>mt <plug>(MergetoolToggle)
nnoremap <silent> <leader>mb :call mergetool#toggle_layout('mr,b')<CR>
nnoremap <silent> <leader>m2 :call mergetool#toggle_layout('mr')<CR>
nmap <expr> <C-Left> &diff? '<Plug>(MergetoolDiffExchangeLeft)' : '<C-Left>'
nmap <expr> <C-Right> &diff? '<Plug>(MergetoolDiffExchangeRight)' : '<C-Right>'
nmap <expr> <C-Down> &diff? '<Plug>(MergetoolDiffExchangeDown)' : '<C-Down>'
nmap <expr> <C-Up> &diff? '<Plug>(MergetoolDiffExchangeUp)' : '<C-Up>'

function! s:setup_git_messenger_popup() abort
    nmap <buffer>[ o
    nmap <buffer>] O
endfunction
autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()

lua <<EOF
require("gitsigns").setup({
	keymaps = {
		["n ]h"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
		["n [h"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

		["n <leader>ga"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
		["v <leader>ga"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		["n <leader>gr"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
		["n <leader>gu"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
		["v <leader>ru"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		["n <leader>gd"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
		["n <leader>gb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

		-- Text objects
		["o ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
		["x ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
	},
})
EOF
