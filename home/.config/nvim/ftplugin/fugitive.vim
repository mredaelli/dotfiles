command! -bang -count=1 GitRebaseHead Git rebase -i HEAD~<count>
nnoremap <buffer> <silent> rh  :GitRebaseHead<CR>
