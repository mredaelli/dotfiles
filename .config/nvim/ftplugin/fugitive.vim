command! -bang -count=1 GitRebaseHead Git rebase -i HEAD~<count>

nnoremap <buffer> <silent> rh  :GitRebaseHead<CR>
nnoremap <buffer> <silent> rM :Git rebase master<CR>
nnoremap <buffer> <silent> f :Git fetch<CR>
nnoremap <buffer> <silent> _ :Git pull<CR>
nnoremap <buffer> <silent> ^ :Git! push<CR>
nnoremap <buffer> <silent> ^^ :GPushForce<CR>
