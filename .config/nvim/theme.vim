" Theme
if (has("termguicolors"))
  set termguicolors
endif

let g:onedark_terminal_italics = 1

let g:material_style = 'darker'
let g:material_italic_comments=1


" call onedark#set_highlight("Normal", { "gg": '000000' })
" call onedark#set_highlight("Identifier", { "gui": 'italic' })

set background=dark
colorscheme onedark_nvim

augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE):/
          \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo

highlight ExtraWhitespace ctermbg=red guibg=ivory4
autocmd Syntax * syn match ExtraWhitespace /\s\+$/ containedin=ALL
