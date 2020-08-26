"""" Lager

" let g:pear_tree_ft_disabled = ['text', 'markdown', 'mail']

" Use autocmds to check your text automatically and keep the highlighting
" up to date (easier):
" au FileType markdown,text,tex,mail DittoOn  " Turn on Ditto's autocmds
" nmap <leader>di <Plug>ToggleDitto      " Turn Ditto on and off

" If you don't want the autocmds, you can also use an operator to check
" specific parts of your text:
" vmap <leader>d <Plug>Ditto	       " Call Ditto on visual selection
" nmap <leader>d <Plug>Ditto	       " Call Ditto on operator movement

" nmap =d <Plug>DittoNext                " Jump to the next word
" nmap -d <Plug>DittoPrev                " Jump to the previous word
" nmap +d <Plug>DittoGood                " Ignore the word under the cursor
" nmap _d <Plug>DittoBad                 " Stop ignoring the word under the cursor
" nmap ]d <Plug>DittoMore                " Show the next matches
" nmap [d <Plug>DittoLess                " Show the previous matches




" augroup Prose
"   autocmd!
"   autocmd FileType markdown,mkd,mail call pencil#init()
"                             \ | call textobj#quote#init()
"                             \ | call textobj#sentence#init()
"                             " \ | call lexical#init()
"                             " \ | call litecorrect#init()
" augroup END
