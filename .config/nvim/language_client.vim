let g:LanguageClient_settingsPath = 'ls-settings.json'
let g:LanguageClient_rootMarkers = ['env']
let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_serverCommands = {
 \ 'rust': ['rust-analyzer'],
 \ 'python': ['pyls', '-vv', '--log-file', '~/pyls.log'],
\}
"  \ 'python': ['pyls'],

" note that if you are using Plug mapping you should not use `noremap` mappings.


  " augroup LanguageClient_config
  "   autocmd!
  "   autocmd User LanguageClientStarted setlocal signcolumn=yes
  "   autocmd User LanguageClientStopped setlocal signcolumn=auto
  " augroup END

if exists("*lightline#update")
  autocmd User LanguageClientDiagnosticsChanged call lightline#update()
endif

" function LC_maps()
  " if has_key(g:LanguageClient_serverCommands, &filetype)
  "   nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
  "   nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
  "   nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
  " endif
" endfunction

" autocmd FileType * call LC_maps()

" command! -nargs=1 QFNextRegex call QFNextRegex(<f-args>)
" command! QFNextError call QFNextRegex('error:')
" function! QFNextRegex(regex)
" " Gather info about the window state
" let l:winnr = winnr()
" let l:winrest = winrestcmd()
" let l:lastwin = winnr('$')
" " Use the error window to find the current error number
" copen
" let l:errnum = line('.') - 1
" " Restore the window state
" if l:lastwin != winnr('$')
" cclose
" endif
" exec l:winnr . "wincmd w"
" exe l:winrest
" " Get the quickfix list
" let l:qf = getqflist()
" " Find and go to the next matching item in the list
" let l:len = len(l:qf)
" let l:errnum += 1
" while l:errnum < l:len
" if l:qf[l:errnum]['text'] =~ a:regex
" exe "cc " . (l:errnum + 1)
" return
" endif
" let l:errnum += 1
" endwhile
" " Give error if not found (hardcoded to English error message)
" echoerr "E553: No more items"
" endfunction

" :QFNextError
" :QFNextRegex \<mykeyword\>


