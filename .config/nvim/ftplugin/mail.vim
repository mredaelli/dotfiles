setlocal noautoindent
setlocal wm=0
setlocal comments+=nb:>
setlocal fo=qaw2tn
setlocal nonumber
setlocal nolist
setlocal textwidth=72

let g:pencil#textwidth = 74
let g:pencil#wrapModeDefault = 'soft'
" let g:pencil#conceallevel = 0

" LiteDFM

" Limelight

UniCycleOn

call pencil#init()
    \ | call lexical#init()
    \ | call textobj#quote#init()
    \ | call textobj#sentence#init()

execute ":s/^/\r\r/"
execute ":normal gg"
execute ":startinsert"

