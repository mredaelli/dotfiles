if executable('python')
  autocmd FileType python call SetPythonOptions()

  function! SetPythonOptions()
      let python_highlight_all=1
      let b:ale_fixers = ['black']

      call SetupDev()
  endfunction
endif
