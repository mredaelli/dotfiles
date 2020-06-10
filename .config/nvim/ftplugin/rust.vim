if executable('rustc')

  if executable('rls')
  else
    if executable('cargo')
      echo "rls not found: unsing cargo"
    endif
  endif


  let g:run_command = "cargo run"
  let g:build_command = "cargo build"

  call SetupDev()
else
  echo "rustc not found: skipping Rust configuration"
endif
