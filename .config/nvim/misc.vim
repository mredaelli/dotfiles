set modeline
set cursorline
set hidden
set number

set colorcolumn=88,100
set virtualedit=all

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

set showmatch

set wildmenu
set wildmode=longest:full,full
set wildignorecase

set clipboard+=unnamedplus

set backspace=indent,eol,start
set ignorecase smartcase

set ttimeout
set ttimeoutlen=100

set cmdheight=2

let g:loaded_2html_plugin = 1

if &listchars ==# 'eol:$'
	set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

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

let g:lexical#spelllang = ['en_us', 'it']

let g:textobj_python_no_default_key_mappings = 1

if executable("rg")
		set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif


augroup CloseLoclistWindowGroup
	autocmd!
	autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

let g:cursorhold_updatetime = 500
set updatetime=5000

