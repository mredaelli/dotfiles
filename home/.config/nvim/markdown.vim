autocmd FileType markdown,pandoc call SetMarkdownOptions()

function! SetMarkdownOptions()
    set  filetype=markdown.pandoc
    set fo+=t
    set fo-=l
    set tw=79
    let g:pencil#wrapModeDefault = 'soft'
    let g:pencil#conceallevel = 0
    Goyo 80
    SoftPencil
    UniCycleOn
endfunction

