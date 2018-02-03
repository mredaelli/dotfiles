call plug#begin('~/.local/share/nvim/plugged')
   Plug 'vim-pandoc/vim-pandoc'
   Plug 'vim-pandoc/vim-pandoc-syntax'
   Plug 'bling/vim-airline'
   
   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
   Plug 'https://github.com/Rip-Rip/clang_complete.git'
   Plug 'neomake/neomake'
   Plug 'octol/vim-cpp-enhanced-highlight'
   Plug 'rhysd/vim-clang-format' 

" themes
   "Plug 'sjl/badwolf'
   "Plug 'joshdick/onedark.vim'
   "Plug 'jacoborus/tender.vim'
   Plug 'morhetz/gruvbox'
   "Plug 'NLKNguyen/papercolor-theme'
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

let g:deoplete#enable_at_startup = 1

let g:clang_complete_auto = 0
let g:clang_library_path = '/usr/lib/llvm-4.0/lib/libclang.so.1'
let g:clang_auto_select = 0
let g:clang_omnicppcomplete_compliance = 0
let g:clang_make_default_keymappings = 0


let g:neomake_error_sign = { 'text': 'E', 'texthl': 'NeomakeErrorSign' }
let g:neomake_warning_sign = { 'text': 'W', 'texthl': 'NeomakeWarningSign' }   
"let g:neomake_open_list = 0
"let g:neomake_list_height = 5
let g:neomake_highlight_lines = 1
let g:neomake_cpp_enabled_markers=['clangtidy']
"let g:neomake_cpp_gcc_maker = {
"\ 'exe': 'g++',
"\ 'args': ['-Wall', '-Iinclude', '-Wextra'] 
"\ }
let g:neomake_cpp_clangtidy_maker = {
\ 'exe': 'clang-tidy',
\ 'args': ['-checks=\*'] 
\ }

call neomake#configure#automake('rw', 1000)

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1

autocmd FileType c ClangFormatAutoEnable
autocmd FileType cpp ClangFormatAutoEnable

" colorscheme badwolf
if (has("termguicolors"))
 set termguicolors
endif

au ColorScheme * hi Normal ctermbg=none guibg=none
au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red

" Theme
set background=dark
let g:gruvbox_improved_strings = 1
let g:gruvbox_italicize_comments = 1
let g:gruvbox_italic = 1
"let g:gruvbox_contrast_dark = 'light'
colorscheme gruvbox
let g:airline_theme='gruvbox'

