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
endfunction

source ~/.config/nvim/haskell.vim
source ~/.config/nvim/mutt.vim
source ~/.config/nvim/rust.vim
source ~/.config/nvim/python.vim
source ~/.config/nvim/markdown.vim
source ~/.config/nvim/c.vim
source ~/.config/nvim/scala.vim
