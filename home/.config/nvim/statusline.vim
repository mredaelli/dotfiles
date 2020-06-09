set noshowmode

let g:lightline = {
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'git', 'readonly', 'filename', 'modified',
\               'coc_error', 'coc_warning', 'coc_hint', 'coc_info'],
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
\ },
  \ 'component_expand': {
  \   'coc_error'        : 'LightlineCocErrors',
  \   'coc_warning'      : 'LightlineCocWarnings',
  \   'coc_info'         : 'LightlineCocInfos',
  \   'coc_hint'         : 'LightlineCocHints',
  \   'coc_fix'          : 'LightlineCocFixes',
  \ },
\ 'colorscheme': 'material',
\ 'mode_map': {
\ 'n' : 'N',
\ 'i' : 'I',
\ 'R' : 'R',
\ 'v' : 'V',
\ 'V' : 'VL',
\ "\<C-v>": 'VB',
\ 'c' : 'C',
\ 's' : 'S',
\ 'S' : 'SL',
\ "\<C-s>": 'SB',
\ 't': 'T',
\ },
\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
\}

let g:lightline.component_type = {
\   'coc_error'        : 'error',
\   'coc_warning'      : 'warning',
\   'coc_info'         : 'tabsel',
\   'coc_hint'         : 'middle',
\   'coc_fix'          : 'middle',
\ }

autocmd User CocDiagnosticChange call lightline#update()

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
  let branch = fugitive#head()
  return branch ==# '' ? '' : (' ' . branch[:10] )
endfunction
