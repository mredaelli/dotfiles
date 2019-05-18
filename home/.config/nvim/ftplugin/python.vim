if executable('python')
      let python_highlight_all=1
      let b:ale_fixers = ['black']

      call SetupDev()
endif
