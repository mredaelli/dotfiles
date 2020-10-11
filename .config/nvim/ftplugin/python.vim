set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

if exists(':LspInstallInfo')
  autocmd BufWritePre <buffer> :call LanguageClient#textDocument_formatting_sync()
endif

call SetupDev()

if exists("*textobj#user#map")
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
endif

if !new_nvim
  let b:python_highlight_all = 1
  setlocal foldmethod=indent  foldnestmax=2
endif

