source ~/.config/nvim/plugins.vim

set modeline
set cursorline
set mouse=a
set hidden
set number

set colorcolumn=80

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=4

set showmatch

filetype plugin indent on
syntax on

set scrolloff=4

let g:ctrlp_cmd = 'CtrlPMixed'

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

if &shell =~# 'fish$'
    set shell=sh
endif

set undofile
set undodir=~/.local/share/nvim/undodir
let s:undos = split(globpath(&undodir, '*'), "\n")
call filter(s:undos, 'getftime(v:val) < localtime() - (60 * 60 * 24 * 90)')
call map(s:undos, 'delete(v:val)')


" ALE
let g:ale_completion_enabled = 0
let g:ale_cursor_detail = 1
"let g:ale_close_preview_on_insert = 1
"let g:ale_open_list = 1
let g:ale_list_window_size = 5
"let g:ale_set_loclist = 1 " default
"let g:ale_set_quickfix = 1

augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END


" Deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer', 'around']


" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1


autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!


source ~/.config/nvim/mappings.vim
source ~/.config/nvim/dev.vim

" Return to last edit position when opening files
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END

" colorscheme badwolf
if (has("termguicolors"))
 set termguicolors
endif

au ColorScheme * hi Normal ctermbg=none guibg=none
au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red

" whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$/ containedin=ALL


" Theme
set background=dark
"let g:gruvbox_improved_strings = 1
"let g:gruvbox_italicize_comments = 1
"let g:gruvbox_italic = 1
"let g:gruvbox_contrast_dark = 'light'
colorscheme apprentice
let g:airline_theme='luna'
