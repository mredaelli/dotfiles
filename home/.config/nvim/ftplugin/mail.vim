set noautoindent
set wm=0
set comments+=nb:>
set fo=qaw2tn
set nonumber
set nolist

" Goyo 80
LiteDFM
" let g:pencil#wrapModeDefault = 'hard'
" let g:pencil#conceallevel = 0
" let g:pencil#textwidth = 74

" let g:limelight_default_coefficient = 0.7
" let g:limelight_paragraph_span = 1
" let g:limelight_conceal_ctermfg = 'gray'
setlocal textwidth=72
" Limelight
" HardPencil
UniCycleOn

execute ":s/^/\r/"
execute ":startinsert"
