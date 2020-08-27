" https://vi.stackexchange.com/questions/14356/go-to-quickfix-next-previous-cnext-cprevious-relative-to-current-file-position#

" TODO: :cabove will be available soon

command! -bar -count=1 Cfnext execute <SID>cfnext(<count>, 'qf')
command! -bar -count=1 Cfprev execute <SID>cfnext(<count>, 'qf', 1)
command! -bar -count=1 Lfnext execute <SID>cfnext(<count>, 'loc')
command! -bar -count=1 Lfprev execute <SID>cfnext(<count>, 'loc', 1)


function! s:cfnext(count, list, ...) abort
  let reverse = a:0 && a:1 
  let func = 'get' . a:list . 'list'
  let params = a:list == 'loc' ? [0] : []
  let cmd = a:list == 'loc' ? 'll' : 'cc'

  let items = call(func, params)
  if len(items) == 0
    return 'echoerr ' . string('E42: No Errors')
  endif

  call map(items, 'extend(v:val, {"idx": v:key + 1})')
  if reverse
    call reverse(items)
  endif

  let [bufnr, cmp] = [bufnr('%'), reverse ? 1 : -1]
  let context = [line('.'), col('.')]
  if v:version > 800 || has('patch-8.0.1112')
    let current = call(func, extend(copy(params), [{'idx':1}])).idx
  else
    redir => capture | execute cmd | redir END
    let current = str2nr(matchstr(capture, '(\zs\d\+\ze of \d\+)'))
  endif
  call add(context, current)

  call filter(items, 'v:val.bufnr == bufnr && s:cmp(context, [v:val.lnum, v:val.col, v:val.idx]) == cmp')

  let idx = get(get(items, 0, {}), 'idx', 'E553: No more items')

  if type(idx) == type(0)
    return cmd . idx
  else
     return 'echoerr' . string(idx)
  endif
endfunction

function! s:cmp(a, b)
  for i in range(len(a:a))
    if a:a[i] < a:b[i]
      return -1
    elseif a:a[i] > a:b[i]
      return 1
    endif
  endfor
  return 0
endfunction
