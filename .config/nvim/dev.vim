function! BuildProgram()
  silent !clear
  execute "!" . g:build_command
endfunction

function! RunProgram()
  silent !clear
  execute "!" . g:run_command
endfunction

function! SetupDev()
  " call neomake#configure#automake('rw', 1000)

  nnoremap <F8> :call BuildProgram()<CR>
  nnoremap <leader>c :call BuildProgram()<CR>
  
  nnoremap <F9> :call RunProgram()<CR>
  nnoremap <Leader>x :call RunProgram()<CR>

  " let g:neomake_open_list = 2
  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
endfunction

