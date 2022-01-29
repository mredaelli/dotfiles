let new_nvim = has("nvim-0.5")

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

runtime mappings.vim
runtime packages.vim
runtime macros/matchit.vim
runtime git.vim
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

aug fzf_setup
  au!
  au TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
aug END

lua require('init')

let g:indent_blankline_buftype_exclude = ['terminal']
let g:indent_blankline_filetype_exclude = ['help']
let g:indent_blankline_char = '▏'
let g:indent_blankline_space_char = ' '
let g:indent_blankline_space_char_blankline_highlight_list = ['IndentNegative', 'StatusLine']
let g:indent_blankline_show_trailing_blankline_indent = 0
let g:indent_blankline_use_treesitter = 1


let g:firenvim_config = { 'globalSettings': { 'alt': 'all'  }, 'localSettings': { }}
let fc = g:firenvim_config['localSettings']
let fc['.*'] = { 'takeover': 'never' }

function! SetLinesForFirefox(timer)
  set lines=10 columns=90 laststatus=0
endfunction
function! OnUIEnter(event) abort
  if 'Firenvim' ==# get(get(nvim_get_chan_info(a:event.chan), 'client', {}), 'name', '')
    call timer_start(300, function("SetLinesForFirefox"))
    set guifont=JetBrains_Mono_Medium:h10
  endif
endfunction
autocmd UIEnter * call OnUIEnter(deepcopy(v:event))

let g:Illuminate_delay = 500
