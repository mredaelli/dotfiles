autocmd BufNewFile,BufRead /tmp/neomutt*  call Mutt()
autocmd BufNewFile,BufRead ~/tmp/neomutt* call Mutt()

function! Mutt()
  set noautoindent 
  set filetype=mail 
  set wm=0 
  set tw=78 
  set comments+=nb:> 
  set fo+=q 
  set nonumber 
  set digraph 
  set nolist

  Goyo 80
  SoftPencil
  UniCycleOn
endfunction

