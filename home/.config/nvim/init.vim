set modeline
set cursorline
set hidden
set number

set colorcolumn=88

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=4

set showmatch

set clipboard+=unnamedplus

syntax on

set scrolloff=4

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  let g:gitgutter_grep = 'ag'
endif

set shell=/bin/sh

set undofile
silent !mkdir ~/.local/share/nvim/undodir > /dev/null 2>&1
set undodir=~/.local/share/nvim/undodir
let s:undos = split(globpath(&undodir, '*'), "\n")
call filter(s:undos, 'getftime(v:val) < localtime() - (60 * 60 * 24 * 90)')
call map(s:undos, 'delete(v:val)')

let g:gitgutter_map_keys = 0
set updatetime=300

source ~/.config/nvim/plugins.vim

augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#whitespace#enabled = 1

let g:vimwiki_list = [ {
      \ 'path': '~/carte/kb/',
      \ 'syntax': 'markdown',
      \ 'ext': '.md'
      \}
      \]

source ~/.config/nvim/mappings.vim
source ~/.config/nvim/coc.vim
source ~/.config/nvim/dev.vim

" Return to last edit position when opening files
augroup last_edit
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

" Theme
if (has("termguicolors"))
  set termguicolors
endif


set background=dark
let g:jellybeans_use_term_italics = 1
colorscheme jellybeans

" whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$/ containedin=ALL

