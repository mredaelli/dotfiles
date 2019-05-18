if executable('ghc')
  set wildignore+=.cabal-sandbox

  let b:ale_haskell_hlint_options = '--with-group Generalise --with-group Dollar'
  let b:ale_linters = {'haskell': ['hlint', 'hie']}

  nnoremap <C-B> :ALEGoToDefinition<cr>
  nnoremap <C-U> :ALEFindReferences<cr>
  nnoremap <C-?> :ALEHover<cr>
  nnoremap <leader>e :ALENextWrap<cr>
  nnoremap <leader>E :ALEPrevious<cr>

  let b:ale_fixers = {'haskell': ['brittany']}
  let b:ale_fix_on_save = 1

  let b:run_command = "cargo run"
  let b:build_command = "cabal build"


  call SetupDev()
endif
