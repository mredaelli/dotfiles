if executable('python')

  let g:python_highlight_all = 1

  set tabstop=8
  set expandtab
  set shiftwidth=4
  set softtabstop=4

  call SetupDev()
else
  echo "No python interpreter"
endif
