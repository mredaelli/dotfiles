if executable('rustc')
  autocmd FileType rust call SetRustOptions()

  function! SetRustOptions()
    let g:ale_linters = {'rust': ['cargo', 'rustfmt']}

    let g:racer_experimental_completer = 1

    au FileType rust nmap <F1> <Plug>(rust-doc)
    au FileType rust nmap <C-b> <Plug>(rust-def)
    au FileType rust nmap <leader>rs <Plug>(rust-def-split)

    let g:rustfmt_autosave = 1

    let g:run_command = "cargo run"
    let g:build_command = "cargo build"

    call SetupDev()
  endfunction
endif
