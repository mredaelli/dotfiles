if executable('ghc')
  autocmd FileType haskell call SetHaskellOptions()

  function! SetHaskellOptions()
    set wildignore+=.cabal-sandbox

    let g:ale_haskell_hlint_options = '--with-group Generalise --with-group Dollar'
    let g:ale_haskell_hie_executable = 'hie-wrapper'
    let g:ale_linters = {'haskell': ['hlint', 'hie']} "'cabal-ghc']}

    let g:ale_fixers = {'haskell': ['brittany']}
    let g:ale_fix_on_save = 1

    let g:run_command = "cargo new-run"
    let g:build_command = "cabal new-build"

     " au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
     " au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsInfo<CR>
     " au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsClear<CR>

    call SetupDev()
  endfunction
endif
