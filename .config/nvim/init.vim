let new_nvim = has("nvim-0.5")

set modeline
set cursorline
set hidden
set number
set relativenumber
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

" set clipboard+=unnamedplus

set backspace=indent,eol,start
set ignorecase smartcase

set ttimeout
set ttimeoutlen=100

set cmdheight=2

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
let g:sneak#label = 1

let g:lexical#spelllang = ['en_us', 'it']

let g:textobj_python_no_default_key_mappings = 1

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

if new_nvim
  let g:polyglot_disabled = [ 'bash.plugin', 'c.plugin', 'c_sharp.plugin', 'cpp.plugin', 'css.plugin', 'dart.plugin', 'fennel.plugin', 'go.plugin',  'html.plugin', 'java.plugin', 'javascript.plugin', 'jsdoc.plugin', 'json.plugin', 'lua.plugin', 'ocaml.plugin', 'ocaml_interface.plugin', 'ocamllex.plugin', 'php.plugin', 'python.plugin', 'ql.plugin', 'regex.plugin', 'rst.plugin', 'ruby.plugin', 'rust.plugin','teal.plugin', 'toml.plugin', 'typescript.plugin']
endif

runtime plugins.vim

runtime macros/matchit.vim

runtime mappings.vim
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

" Removes the delay in closing fzf window with ESC
if has('nvim')
  aug fzf_setup
    au!
    au TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
  aug END

  lua require('init')
end

let g:polyglot_disabled = [ 'bash.plugin', 'c.plugin', 'c_sharp.plugin', 'cpp.plugin', 'css.plugin', 'dart.plugin', 'fennel.plugin', 'go.plugin',  'html.plugin', 'java.plugin', 'javascript.plugin', 'jsdoc.plugin', 'json.plugin', 'lua.plugin', 'ocaml.plugin', 'ocaml_interface.plugin', 'ocamllex.plugin', 'php.plugin', 'python.plugin', 'ql.plugin', 'regex.plugin', 'rst.plugin', 'ruby.plugin', 'rust.plugin','teal.plugin', 'toml.plugin', 'typescript.plugin']

" highlight IndentNegative ctermfg=145 ctermbg=240
let g:indent_blankline_buftype_exclude = ['terminal']
let g:indent_blankline_filetype_exclude = ['help']
let g:indent_blankline_char = '▏'
let g:indent_blankline_space_char = ' '
let g:indent_blankline_space_char_blankline_highlight_list = ['IndentNegative', 'StatusLine']
let g:indent_blankline_show_trailing_blankline_indent = 0
let g:indent_blankline_use_treesitter = 1




" " Normal color in popup window with 'CursorLine'
" hi link gitmessengerPopupNormal CursorLine
" " Header such as 'Commit:', 'Author:' with 'Statement' highlight group
" hi link gitmessengerHeader Statement
" " Commit hash at 'Commit:' header with 'Special' highlight group
" hi link gitmessengerHash Special
" " History number at 'History:' header with 'Title' highlight group
" hi link gitmessengerHistory Title

function! s:setup_git_messenger_popup() abort
    nmap <buffer>[ o
    nmap <buffer>] O
endfunction
autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()
