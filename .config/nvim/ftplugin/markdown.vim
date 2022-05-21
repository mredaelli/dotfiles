" setlocal fo+=t
" setlocal fo-=l
" setlocal textwidth=72

" setlocal noautoindent
" let g:pencil#textwidth = 72
" let g:pencil#wrapModeDefault = 'soft'
" let g:pencil#conceallevel = 0

let g:pandoc#spell#default_langs = ['en_US', 'it']

" SoftPencil

" markdownWikiLink is a new region
syn region markdownWikiLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" contains=markdownUrl keepend oneline concealends
" markdownLinkText is copied from runtime files with 'concealends' appended
syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends
" markdownLink is copied from runtime files with 'conceal' appended
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal

setlocal conceallevel=2
