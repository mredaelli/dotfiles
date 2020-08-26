set modeline
set cursorline
set hidden
set number
set relativenumber
set number

set colorcolumn=88
set virtualedit=all

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=4

set showmatch

set clipboard+=unnamedplus

set backspace=indent,eol,start
set ignorecase smartcase

set ttimeout
set ttimeoutlen=100

set cmdheight=2

" refresh gitgutter quickly
set updatetime=200

" let g:loaded_netrwPlugin = 1
let g:loaded_2html_plugin = 1

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" set autoread
set autowrite

if !&scrolloff
  set scrolloff=2
endif
if !&sidescrolloff
  set sidescrolloff=5
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

syntax on

if has("nvim")
  " show preview on replace
  set inccommand=nosplit
endif

" %% is the directory of the open buffer
cabbr <expr> %% expand('%:p:h')

if &shell =~# 'fish$'
  set shell=/usr/bin/env\ bash
endif

let g:dirvish_mode = ':sort ,^.*[\/],'

let g:BufKillCreateMappings = 0

" let g:deoplete#enable_at_startup = 1

runtime plugins.vim

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect


runtime mappings.vim
" runtime coc.vim
runtime dev.vim
runtime statusline.vim
runtime theme.vim
runtime text.vim
runtime ale.vim
runtime gitgutter.vim
runtime vimwiki.vim
runtime language_client.vim

augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

if exists("##TermOpen")
    augroup term_settings
        autocmd!
        autocmd TermOpen * setlocal norelativenumber nonumber scrollback=100000
        autocmd TermOpen * startinsert
        " autocmd TermOpen * setlocal
    augroup END
endif
