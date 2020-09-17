let b:python_highlight_all = 1
call textobj#user#map('python', {
      \   'class': {
      \     'select-a': '<buffer>ac',
      \     'select-i': '<buffer>ic',
      \     'move-n': '<buffer>}',
      \     'move-p': '<buffer>{',
      \   },
      \   'function': {
      \     'select-a': '<buffer>af',
      \     'select-i': '<buffer>if',
      \     'move-n': '<buffer>)',
      \     'move-p': '<buffer>(',
      \   }
      \ })

setlocal foldmethod=indent  foldnestmax=2
" setlocal foldmethod=indent foldlevel=1 foldnestmax=2

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

autocmd BufWritePre <buffer> :call LanguageClient#textDocument_formatting_sync()
