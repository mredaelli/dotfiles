" Theme
if (has("termguicolors"))
  set termguicolors
endif

" let g:jellybeans_use_term_italics = 1
let g:onedark_terminal_italics = 1
let g:lightline['colorscheme'] = 'onedark'

" let g:deepspace_italics=1
" let g:lightline = {
"       \ 'colorscheme': 'deepspace',
"       \ }

colorscheme onedark
set background=dark
" If the background is too washed-out
" hi Normal ctermbg=255  guibg=#000000

call onedark#set_highlight("Normal", { "gg": '000000' })
call onedark#set_highlight("Identifier", { "gui": 'italic' })

" highlight GitGutterAdd    guifg=#009900
" highlight GitGutterChange guifg=#bbbb00
" highlight GitGutterDelete guifg=#ff2222

augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE):/
          \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo

highlight ExtraWhitespace ctermbg=red guibg=ivory4
autocmd Syntax * syn match ExtraWhitespace /\s\+$/ containedin=ALL
