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
