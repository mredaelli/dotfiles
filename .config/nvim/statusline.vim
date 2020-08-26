set noshowmode

let g:lightline = {
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'git', 'readonly', 'filename', 'modified',
\               'coc_error', 'coc_warning', 'coc_hint', 'coc_info',
\               'langclient_error', 'langclient_warning', 'langclient_hint', 'langclient_info',
\               'linter_warnings', 'linter_errors' ],
\             ['coc_status'] ],
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
  return s:lightline_coc_diagnostic('error', '✘')
endfunction
function! LightlineCocWarnings() abort
  return s:lightline_coc_diagnostic('warning', '⚠')
endfunction
function! LightlineCocInfos() abort
  return s:lightline_coc_diagnostic('information', '🛈')
endfunction
function! LightlineCocHints() abort
  return s:lightline_coc_diagnostic('hint', '💡')
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
  return l:counts.total == 0 ? '' : printf('%d ▲', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
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
  return s:lightline_langclient_diagnostic('E', '✘')
endfunction
function! Lightlinelang_clientWarnings() abort
  return s:lightline_langclient_diagnostic('W', '⚠')
endfunction
function! Lightlinelang_clientInfos() abort
  return s:lightline_langclient_diagnostic('I', '🛈')
endfunction
function! Lightlinelang_clientHints() abort
  return s:lightline_langclient_diagnostic('H', '💡')
endfunction
