set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

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
