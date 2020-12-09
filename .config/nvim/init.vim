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
set tabstop=4

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

let g:lexical#spelllang = ['en_us', 'it']

let g:textobj_python_no_default_key_mappings = 1

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

if new_nvim
  let g:polyglot_disabled = [ 'bash.plugin', 'c.plugin', 'c_sharp.plugin', 'cpp.plugin', 'css.plugin', 'dart.plugin', 'fennel.plugin', 'go.plugin',  'html.plugin', 'java.plugin', 'javascript.plugin', 'jsdoc.plugin', 'json.plugin', 'lua.plugin', 'ocaml.plugin', 'ocaml_interface.plugin', 'ocamllex.plugin', 'php.plugin', 'python.plugin', 'ql.plugin', 'regex.plugin', 'rst.plugin', 'ruby.plugin', 'rust.plugin','teal.plugin', 'toml.plugin', 'typescript.plugin']
endif

runtime plugins.vim


if exists("*ncm2#enable_for_buffer")
  autocmd BufEnter * call ncm2#enable_for_buffer()
  set completeopt=noinsert,menuone,noselect
endif

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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
lua <<EOF

local nvim_lsp = require("lspconfig")
local nvim_completion = require("completion")

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = true,
      -- swap_next = {
      --  ["<leader>a"] = "@parameter.inner",
      -- },
    },
    move = {
      enable = true,
     -- goto_next_start = {
     --   ["]m"] = "@function.outer",
     --   ["]]"] = "@class.outer",
     -- },
    },
  },
}

require "nvim-treesitter.parsers".get_parser_configs().markdown = nil

local lsp_status = require('lsp-status')

local custom_attach = function(client, bufnr)
   nvim_completion.on_attach(client, bufnr)

   -- bug in lsp=status, and I don't want it anyway
   local old = client.resolved_capabilities.document_symbol
   client.resolved_capabilities.document_symbol = false
   lsp_status.on_attach(client, bufnr)
   client.resolved_capabilities.document_symbol = old
   print("LSP Attached.")
end

nvim_lsp.rust_analyzer.setup{ on_attach = custom_attach, capabilities = lsp_status.capabilities }
nvim_lsp.pyls.setup{
  settings = {
    pyls = {
      configurationSources = { "pycodestyle", "pyflakes" },
      plugins = {
        pyflakes = {enabled= true},
        pycodestyle = { enabled= true},
        mccabe = { enabled= true},
        pylint = { enabled= true},
        rope = { enabled= true},
        black = { enabled= true},
        isort = { enabled= true},
        pyls_mypy = {
          enabled= true,
          live_mode= true,
        },
        pydocstyle = { enabled= false},
        autopep8 = { enabled= false},
        yapf = { enabled= false }
      }
    }
  },
  on_attach = custom_attach, capabilities = lsp_status.capabilities
}

local dap = require('dap')
dap.adapters.cpp = {
  type = 'executable',
  attach = {
    pidProperty = "pid",
    pidSelect = "ask"
  },
  command = 'lldb-vscode',
  sourceLanguages = {"rust"},
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
  },
  name = "lldb"
}
vim.g.dap_virtual_text = true

require('telescope').setup{
  defaults = {
    prompt_prefix = ">",
    layout_strategy = "vertical",
    --width = 0.75,
    --preview_cutoff = 120,
    results_height = 12,
    --results_width = 0.8,
    --color_devicons = true,
    --use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
  }
}
require('telescope').load_extension('dap')
require'nvim-web-devicons'.setup { default = true; }

EOF
command! -complete=file -nargs=* DebugRust lua require "my_debug".start_c_debugger({<f-args>}, "gdb", "rust-gdb")

nnoremap <silent> <leader>xx :lua require'dap'.repl.toggle()<CR>
nnoremap <silent> <leader>x<Space> :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>xs :lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>xi :lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>xo :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>xb :lua require'dap'.toggle_breakpoint()<CR>

  autocmd BufEnter * lua require'completion'.on_attach()
      " @block.inner @block.outer
      " @call.inner @call.outer
      " @class.inner @class.outer
      " @comment.outer @conditional.inner
      " @conditional.outer @function.inner
      " @function.outer @loop.inner
      " @loop.outer @parameter.inner
      " @statement.outer
  set omnifunc=lsp#omnifunc

  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()

  let g:polyglot_disabled = [ 'bash.plugin', 'c.plugin', 'c_sharp.plugin', 'cpp.plugin', 'css.plugin', 'dart.plugin', 'fennel.plugin', 'go.plugin',  'html.plugin', 'java.plugin', 'javascript.plugin', 'jsdoc.plugin', 'json.plugin', 'lua.plugin', 'ocaml.plugin', 'ocaml_interface.plugin', 'ocamllex.plugin', 'php.plugin', 'python.plugin', 'ql.plugin', 'regex.plugin', 'rst.plugin', 'ruby.plugin', 'rust.plugin','teal.plugin', 'toml.plugin', 'typescript.plugin']


  set completeopt=menuone,noinsert,noselect
  " Avoid showing message extra message when using completion
  set shortmess+=c

endif
