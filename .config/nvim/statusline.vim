set noshowmode

let g:symbolE = '😡'
let g:symbolW = '😱'
let g:symbolI = '🙏'
let g:symbolH = '🙈'

let g:lightline = {
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'git', 'readonly', 'filename', 'modified',
\               'coc_error', 'coc_warning', 'coc_hint', 'coc_info',
\               'langclient_error', 'langclient_warning', 'langclient_hint', 'langclient_info',
\               'linter_warnings', 'linter_errors' ],
\             ['coc_status', 'nvlsp_status'] ],
\ 'right': [ [ 'lineinfo' ],
\            [ 'fileformat', 'fileencoding', 'filetype' ] ]
\ },
\ 'component': {
\   'lineinfo': 'C%v|L%l/%L',
\ },
\ 'component_function': {
\   'git': 'LightlineGit',
\   'readonly': 'LightlineReadonly',
\   'fileformat': 'LightlineFileformat',
\   'fileencoding': 'LightlineFileencoding',
\   'coc_status': 'LightlineCocStatus',
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\ },
\ 'component_expand': {
\   'nvlsp_status': 'LightLineNeovimLspStatus',
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'langclient_error'        : 'Lightlinelang_clientErrors',
\   'langclient_warning'      : 'Lightlinelang_clientWarnings',
\   'langclient_info'         : 'Lightlinelang_clientInfos',
\   'langclient_hint'         : 'Lightlinelang_clientHints',
\   'coc_error'        : 'LightlineCocErrors',
\   'coc_warning'      : 'LightlineCocWarnings',
\   'coc_info'         : 'LightlineCocInfos',
\   'coc_hint'         : 'LightlineCocHints',
\   'coc_fix'          : 'LightlineCocFixes',
\ },
\ 'colorscheme': 'material',
\ 'mode_map': {
\    'n' : 'N',
\    'i' : 'I',
\    'R' : 'R',
\    'v' : 'V',
\    'V' : 'VL',
\    "\<C-v>": 'VB',
\    'c' : 'C',
\    's' : 'S',
\    'S' : 'SL',
\    "\<C-s>": 'SB',
\    't': 'T',
\ },
\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
\}

let g:lightline.component_type = {
\   'linter_errors'        : 'error',
\   'linter_warnings'      : 'warning',
\   'coc_error'        : 'error',
\   'coc_warning'      : 'warning',
\   'coc_info'         : 'tabsel',
\   'nvlsp_status'         : 'raw',
\   'coc_hint'         : 'middle',
\   'coc_fix'          : 'middle',
\ }


function! s:lightline_coc_diagnostic(kind, sign) abort
  let info = get(b:, 'coc_diagnostic_info', 0)
  if empty(info) || get(info, a:kind, 0) == 0
    return ''
  endif
  return printf('%s%d', a:sign, info[a:kind])
endfunction

function! LightlineCocErrors() abort
  return s:lightline_coc_diagnostic('error', g:symbolE)
endfunction
function! LightlineCocWarnings() abort
  return s:lightline_coc_diagnostic('warning', g:symbolW)
endfunction
function! LightlineCocInfos() abort
  return s:lightline_coc_diagnostic('information', g:symbolI)
endfunction
function! LightlineCocHints() abort
  return s:lightline_coc_diagnostic('hint',g:symbolH)
endfunction
function! LightlineCocStatus() abort
  return get(g:, 'coc_status', '')
endfunction

function! LightlineFileformat()
  return &fileformat !=# 'unix' ? &fileformat : ''
endfunction

function! LightlineFileencoding()
  return &fileencoding !=# 'utf-8' ? &fileencoding : ''
endfunction

function! LightlineReadonly()
  return &readonly && &filetype !=# 'help' ? '🔒' : ''
endfunction

function! LightlineGit()
  let branch = fugitive#head()[:10]
  if branch ==# ''
      return ''
  endif
  let [a,m,r] = GitGutterGetHunkSummary()
  let s = ' '
  if a != 0
    let s = s . printf('+%d', a)
  endif
  if m != 0
    let s = s . printf('~%d', m)
  endif
  if r != 0
    let s = s . printf('-%d', r)
  endif
  if s ==# ' '
      return branch
  endif
  return (' ' . branch[:10] . s)
endfunction

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d '.g:symbolW, all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d '.g:symbolE, all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓' : ''
endfunction


function! s:lightline_langclient_diagnostic(kind, sign) abort
  let info = LanguageClient#statusLineDiagnosticsCounts()
  if empty(info) || get(info, a:kind, 0) == 0
    return ''
  endif
  return printf('%s%d', a:sign, info[a:kind])
endfunction

function! Lightlinelang_clientErrors() abort
  return s:lightline_langclient_diagnostic('E', g:symbolE)
endfunction
function! Lightlinelang_clientWarnings() abort
  return s:lightline_langclient_diagnostic('W', g:symbolW)
endfunction
function! Lightlinelang_clientInfos() abort
  return s:lightline_langclient_diagnostic('I', g:symbolI)
endfunction
function! Lightlinelang_clientHints() abort
  return s:lightline_langclient_diagnostic('H',g:symbolH)
endfunction

" Statusline
function! LightLineNeovimLspStatus() abort
  if !exists(':LspInstallInfo')
    return ''
  endif
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return substitute(luaeval("require('lsp-status').status()"), '%', '%%', 'g') 
  endif

  return ''
endfunction

call sign_define("LspDiagnosticsSignError", {"text" : g:symbolE, "texthl" : "LspDiagnosticsVirtualTextError"}) 
call sign_define("LspDiagnosticsSignWarning", {"text" : g:symbolW, "linehl" : "LspDiagnosticsUnderlineWarning"})
call sign_define("LspDiagnosticsSignInformation", {"text" : g:symbolI, "texthl" : "LspDiagnosticsVirtualTextInformation"})
call sign_define("LspDiagnosticsSignHint", {"text" : g:symbolH, "texthl" : "LspDiagnosticsVirtualTextHint"})

if new_nvim
lua <<EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      spacing = 2,
      prefix = '😾',
    },
    signs = true,
  }
)

local lsp_status = require('lsp-status')
lsp_status.config {
  indicator_errors = vim.g.symbolE,
  indicator_warnings = vim.g.symbolW,
  indicator_info = vim.g.symbolI,
  indicator_hint = vim.g.symbolH,
  status_symbol = "",
}
lsp_status.register_progress()
require('lualine').setup{
  options = { theme = 'material' },
  sections = {
    lualine_a = { {'mode', upper = true, format = function(mode_name) return mode_name:sub(1,1) end} },
    lualine_b = { {'branch', icon = '', format = function(name) return name:sub(1,10) end} },
    lualine_c = { {'filename', file_status = true}, 'diff', {'diagnostics', sources = {'nvim_lsp'} } },
    lualine_x = { {'fileformat', full_path=true, shorten=true}, 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location'  },
  },
}
EOF
" autocmd User LspDiagnosticsChanged call lightline#update()
" autocmd User LspDiagnosticsChanged lua vim.lsp.diagnostic.set_loclist()
endif
