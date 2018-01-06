call plug#begin('~/.local/share/nvim/plugged')
   Plug 'vim-pandoc/vim-pandoc'
   Plug 'vim-pandoc/vim-pandoc-syntax'
   Plug 'bling/vim-airline'
call plug#end()

set modeline

" shifting text with arrows in visual mode
vmap <A-Left> <gv
vmap <A-Right> >gv
vmap <A-Down> :m '>+1<CR>gv=gv 
vmap <A-Up> :m '<-2<CR>gv=gv

autocmd FileType markdown,pandoc noremap <buffer> <silent> k gk
autocmd FileType markdown,pandoc noremap <buffer> <silent> j gj
autocmd FileType markdown,pandoc noremap <buffer> <silent> 0 g0
autocmd FileType markdown,pandoc noremap <buffer> <silent> $ g$

autocmd FileType markdown,pandoc noremap <buffer> <silent> <Up> gk
autocmd FileType markdown,pandoc noremap <buffer> <silent> <Down> gj
autocmd FileType markdown,pandoc noremap <buffer> <silent> <Home> g0
autocmd FileType markdown,pandoc noremap <buffer> <silent> <End> g$

