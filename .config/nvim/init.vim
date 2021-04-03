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

" met clipboard+=unnamedplus

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


" " Use <TAB> to select the popup menu:
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" imap <Tab> <Plug>(completion_smart_tab)
" imap <S-Tab> <Plug>(completion_smart_s_tab)

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

lua << EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
--  elseif vim.fn.call("vsnip#available", {1}) == 1 then
--    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
--  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
--    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end
  vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
  vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
  vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
  vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF


runtime macros/matchit.vim

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

" Removes the delay in closing fzf window with ESC
if has('nvim')
  aug fzf_setup
    au!
    au TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
  aug END
end

if new_nvim
  lua require('init')

  lua <<EOF

  local lsp_status = require('lsp-status')
  lsp_status.register_progress()


  require('telescope').setup{
    defaults = {
      prompt_prefix = ">",
     --" layout_strategy = "vertical",
      --results_height = 12,
      set_env = { ['COLORTERM'] = 'truecolor' },
    }
  }
  -- require('telescope').load_extension('dap')

  require'nvim-web-devicons'.setup { default = true; }

  require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
      path = true;
      buffer = true;
      calc = true;
      nvim_lsp = true;
      nvim_lua = true;
      snippets_nvim = true;
    };
  }
EOF

" command! -complete=file -nargs=* DebugRust lua require "my_debug".start_c_debugger({<f-args>}, "gdb", "rust-gdb")


" autocmd BufEnter * lua require'completion'.on_attach()
    " @block.inner @block.outer
    " @call.inner @call.outer
    " @class.inner @class.outer
    " @comment.outer @conditional.inner
    " @conditional.outer @function.inner
    " @function.outer @loop.inner
    " @loop.outer @parameter.inner
    " @statement.outer
" set omnifunc=lsp#omnifunc

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

let g:polyglot_disabled = [ 'bash.plugin', 'c.plugin', 'c_sharp.plugin', 'cpp.plugin', 'css.plugin', 'dart.plugin', 'fennel.plugin', 'go.plugin',  'html.plugin', 'java.plugin', 'javascript.plugin', 'jsdoc.plugin', 'json.plugin', 'lua.plugin', 'ocaml.plugin', 'ocaml_interface.plugin', 'ocamllex.plugin', 'php.plugin', 'python.plugin', 'ql.plugin', 'regex.plugin', 'rst.plugin', 'ruby.plugin', 'rust.plugin','teal.plugin', 'toml.plugin', 'typescript.plugin']


" Avoid showing message extra message when using completion
set shortmess+=c
set complete=kspell
set completeopt=menuone,noinsert,noselect

" autocmd BufEnter * lua require'completion'.on_attach()

highlight IndentNegative ctermfg=145 ctermbg=240
let g:indent_blankline_buftype_exclude = ['terminal']
let g:indent_blankline_filetype_exclude = ['help']
let g:indent_blankline_char = '▏'
" let g:indent_blankline_char_blankline_highlight_list = ['Error', 'Function']
let g:indent_blankline_space_char = ' '
let g:indent_blankline_space_char_blankline_highlight_list = ['IndentNegative', 'StatusLine']
let g:indent_blankline_show_trailing_blankline_indent = 0
let g:indent_blankline_use_treesitter = 1
" let g:indent_blankline_show_current_context = 1
" let g:indent_blankline_context_patterns = [
"     'class', 'return', 'function', 'method', '^if', '^while', 'jsx_element', '^for', '^object', '^table', 'block',
"     'arguments', 'if_statement', 'else_clause', 'jsx_element', 'jsx_self_closing_element', 'try_statement',
"     'catch_clause', 'import_statement', 'operation_type'
" ]


endif

highlight link CompeDocumentation NormalFloat
nnoremap <C-s> :NvimTreeToggle<CR>
" nnoremap <C-s> :NvimTreeFindFile<CR>


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
