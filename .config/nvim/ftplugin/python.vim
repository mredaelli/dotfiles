let b:python_highlight_all = 1
" setlocal foldmethod=indent
" setlocal foldnestmax=2

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

autocmd BufWritePre <buffer> :call LanguageClient#textDocument_formatting_sync()
