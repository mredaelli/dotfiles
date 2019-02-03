if executable('scalac')
  autocmd BufNewFile,BufRead *.scala call SetupScala()

  function! SetupScala()

      set ft=scala " Set syntax highlighting for .scala files
      
      au BufWritePost *.scala Neomake! sbt
      
      let g:ensime_maker = {'name': 'Ensime'}
      function! g:ensime_maker.get_list_entries(jobinfo) abort
        return b:ensime_notes
      endfunction
      
      "ensime only populates b:ensime_notes if it detects Syntastic
      command! -nargs=1 SyntasticCheck execute "call neomake#Make(1, [g:ensime_maker])"
      function! Ensime_retypecheck() abort
        let b:ensime_notes=[]
        exe "SyntasticCheck ensime"
        exe "EnTypeCheck"
      endfunction
      autocmd BufWritePost *.scala call Ensime_retypecheck()
      "	let g:neomake_scala_enabled_makers = []

      nnoremap <C-b> :EnDeclaration<CR>

      let g:deoplete#omni#input_patterns.scala='[^. *\t]\.\w*'
      let g:neomake_scala_enabled_makers = ['sbt']
      let g:neomake_verbose=3
      call SetupDev()
  endfunction
endif
