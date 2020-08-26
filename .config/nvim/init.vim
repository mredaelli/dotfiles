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
" %% is the directory of the open buffer
cabbr <expr> %% expand('%:p:h')

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax


if executable('rg')
  let g:ackprg = 'rg --vimgrep'
  let g:gitgutter_grep = 'rg'
endif

if &shell =~# 'fish$'
  set shell=/usr/bin/env\ bash
endif

set undofile
silent !mkdir ~/.local/share/nvim/undodir > /dev/null 2>&1
set undodir=~/.local/share/nvim/undodir
let s:undos = split(globpath(&undodir, '*'), "\n")
call filter(s:undos, 'getftime(v:val) < localtime() - (60 * 60 * 24 * 90)')
call map(s:undos, 'delete(v:val)')

" Theme
if (has("termguicolors"))
  set termguicolors
endif

set cmdheight=2
set signcolumn=auto:2

let g:gitgutter_map_keys = 0
set updatetime=200
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '┃ '
let g:gitgutter_sign_removed_first_line = '┃'
let g:gitgutter_sign_modified_removed = '┃'
let g:gitgutter_highlight_linenrs = 1 

let g:dirvish_mode = ':sort ,^.*[\/],'


source ~/.config/nvim/plugins.vim

" let g:jellybeans_use_term_italics = 1
let g:onedark_terminal_italics = 1
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
" let g:deepspace_italics=1
" let g:lightline = {
"       \ 'colorscheme': 'deepspace',
"       \ }

colorscheme onedark
set background=dark
" hi Normal ctermbg=255  guibg=#000000
call onedark#set_highlight("Normal", { "gg": '000000' })


" highlight GitGutterAdd    guifg=#009900
" highlight GitGutterChange guifg=#bbbb00
" highlight GitGutterDelete guifg=#ff2222

augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

let g:pear_tree_ft_disabled = ['text', 'markdown', 'mail']

" Use autocmds to check your text automatically and keep the highlighting
" up to date (easier):
" au FileType markdown,text,tex,mail DittoOn  " Turn on Ditto's autocmds
" nmap <leader>di <Plug>ToggleDitto      " Turn Ditto on and off

" " If you don't want the autocmds, you can also use an operator to check
" " specific parts of your text:
" " vmap <leader>d <Plug>Ditto	       " Call Ditto on visual selection
" " nmap <leader>d <Plug>Ditto	       " Call Ditto on operator movement

" nmap =d <Plug>DittoNext                " Jump to the next word
" nmap -d <Plug>DittoPrev                " Jump to the previous word
" nmap +d <Plug>DittoGood                " Ignore the word under the cursor
" nmap _d <Plug>DittoBad                 " Stop ignoring the word under the cursor
" nmap ]d <Plug>DittoMore                " Show the next matches
" nmap [d <Plug>DittoLess                " Show the previous matches

augroup LargeFile
        let g:large_file = 10485760 " 10MB

        " Set options:
        "   eventignore+=FileType (no syntax highlighting etc
        "   assumes FileType always on)
        "   noswapfile (save copy of file)
        "   bufhidden=unload (save memory when other file is viewed)
        "   buftype=nowritefile (is read-only)
        "   undolevels=-1 (no undo possible)
        au BufReadPre *
                \ let f=expand("<afile>") |
                \ if getfsize(f) > g:large_file |
                        \ set eventignore+=FileType |
                        \ setlocal noswapfile nofoldenable bufhidden=unload buftype=nowrite undolevels=-1 |
                \ else |
                        \ set eventignore-=FileType |
                \ endif
augroup END

augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE):/
          \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo

" augroup Prose
"   autocmd!
"   autocmd FileType markdown,mkd,mail call pencil#init()
"                             \ | call textobj#quote#init()
"                             \ | call textobj#sentence#init()
"                             " \ | call lexical#init()
"                             " \ | call litecorrect#init()
" augroup END

let g:vimwiki_list = [ {
      \ 'path': '~/carte/kb/',
      \ 'syntax': 'markdown',
      \ 'ext': '.md'
      \}
      \]
let g:vimwiki_auto_chdir = 1
let g:BufKillCreateMappings = 0

source ~/.config/nvim/mappings.vim
source ~/.config/nvim/coc.vim
source ~/.config/nvim/dev.vim
source ~/.config/nvim/statusline.vim

" Return to last edit position when opening files
augroup last_edit
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END


if exists("##TermOpen")
    augroup term_settings
        autocmd!
        autocmd TermOpen * setlocal norelativenumber nonumber scrollback=100000
        autocmd TermOpen * startinsert
        " autocmd TermOpen * setlocal
    augroup END
endif


" whitespace
highlight ExtraWhitespace ctermbg=red guibg=ivory4
autocmd Syntax * syn match ExtraWhitespace /\s\+$/ containedin=ALL

