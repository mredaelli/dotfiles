autocmd FileType markdown,pandoc call SetMarkdownOptions()

function! SetMarkdownOptions()
    set  filetype=markdown.pandoc
    set fo+=t
    set fo-=l
    set tw=79
    Goyo 80
    Pencil
    UniCycleOn
endfunction

