let g:large_file = 10485760 " 10MB

function! s:slim_it() abort
        let f=expand("<afile>")
        if getfsize(f) > g:large_file
                echom "Big file! slimming vim down"
                set eventignore+=FileType

                setlocal noswapfile 
                setlocal nofoldenable 
                setlocal bufhidden=unload 
                setlocal buftype=nowrite 
                setlocal undolevels=-1
                setlocal noundofile
                setlocal foldmethod=manual

                syntax off
                filetype off

                if exists(':TSBufDisable') 
                        exec 'TSBufDisable autotag' 
                        exec 'TSBufDisable context_commentstring'
                        exec 'TSBufDisable highlight'
                        exec 'TSBufDisable incremental_selextion'
                        exec 'TSBufDisable indent'
                        exec 'TSBufDisable rainbow'
                endif
        else
                set eventignore-=FileType
        endif
endfunction

augroup BigFileDisable 
        autocmd! 
        autocmd BufWinEnter * call <SID>slim_it()
augroup END

