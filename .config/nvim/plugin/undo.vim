set undofile
silent !mkdir ~/.local/share/nvim/undodir > /dev/null 2>&1
set undodir=~/.local/share/nvim/undodir
let s:undos = split(globpath(&undodir, '*'), "\n")
call filter(s:undos, 'getftime(v:val) < localtime() - (60 * 60 * 24 * 90)')
call map(s:undos, 'delete(v:val)')
