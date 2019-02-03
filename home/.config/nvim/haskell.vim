if executable('ghc')
  autocmd FileType Haskell call SetHaskellOptions()

  function! SetHaskellOptions()
      g:hindent_on_save = 1

      call SetupDev()
  endfunction
endif
