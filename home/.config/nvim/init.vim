call plug#begin('~/.local/share/nvim/plugged')
   Plug 'conradirwin/vim-bracketed-paste'

   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
   "Plug 'roxma/nvim-yarp'
   "Plug 'roxma/vim-hug-neovim-rpc'
   
   " Text
   Plug 'junegunn/goyo.vim', { 'for': ['markdown', 'pandoc', 'mail' ] }
   Plug 'reedes/vim-pencil', { 'for': ['markdown', 'pandoc', 'mail' ] }
   Plug 'vim-scripts/UniCycle', { 'for': ['markdown', 'pandoc', 'mail' ] }


   " Pandoc
   Plug 'vim-pandoc/vim-pandoc', { 'for': ['markdown', 'pandoc'] }
   Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown', 'pandoc'] }

   " Haskell
   Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell', 'cabal'] }
   Plug 'alx741/vim-hindent', { 'for': ['haskell'] }
   
   " Scala
   Plug 'ensime/ensime-vim', { 'do': ':UpdateRemotePlugins' , 'for': 'scala' }
   Plug 'derekwyatt/vim-scala', { 'for': 'scala' }

   " C/C++
   Plug 'https://github.com/Rip-Rip/clang_complete.git'
   Plug 'octol/vim-cpp-enhanced-highlight'
   Plug 'rhysd/vim-clang-format' 

   " R
   Plug 'jalvesaq/Nvim-R', { 'for': 'r' }

   Plug 'LnL7/vim-nix', { 'for': 'nix' }
   Plug 'dag/vim-fish', { 'for': 'fish' }
   Plug 'ledger/vim-ledger', { 'for': 'ledger' }


   Plug 'ctrlpvim/ctrlp.vim'

   " Grepping
   Plug 'mileszs/ack.vim'

   Plug 'tpope/vim-commentary'

   Plug 'neomake/neomake', { 'for': ['scala', 'cpp', 'python', 'haskell'] }

   " linting
   Plug 'w0rp/ale'

   Plug 'easymotion/vim-easymotion'

   Plug 'bling/vim-airline'
" themes
   "Plug 'sjl/badwolf'
   "Plug 'joshdick/onedark.vim'
   "Plug 'jacoborus/tender.vim'
   Plug 'morhetz/gruvbox'
   "Plug 'NLKNguyen/papercolor-theme'
call plug#end()

let g:ctrlp_cmd = 'CtrlPMixed'

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

if &shell =~# 'fish$'
    set shell=sh
endif

set modeline
set cursorline
set mouse=a
set hidden
set number

set scrolloff=12

set colorcolumn=80

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=4
filetype indent on
syntax on

set scrolloff=4

set undofile
set undodir=~/.local/share/nvim/undodir
let s:undos = split(globpath(&undodir, '*'), "\n")
call filter(s:undos, 'getftime(v:val) < localtime() - (60 * 60 * 24 * 90)')
call map(s:undos, 'delete(v:val)')

" complete on TAB
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
autocmd InsertLeave, CompletedDone * if pumvisible() == 0 | pclose | endif

" clear last search
nnoremap <silent> <ESC> :nohlsearch<CR><CR> 
nnoremap <esc>[ <esc>[

autocmd BufNewFile,BufRead /tmp/neomutt*  call Mutt()
autocmd BufNewFile,BufRead ~/tmp/neomutt* call Mutt()

function Mutt()
  set noautoindent 
  set filetype=mail 
  set wm=0 
  set tw=78 
  set comments+=nb:> 
  set fo+=q 
  set nonumber 
  set digraph 
  set nolist

  Goyo 80
  Pencil
  UniCycleOn
endfunction

" shifting text with arrows in visual mode
vmap <A-Left> <gv
vmap <A-Right> >gv
vmap <A-Down> :m '>+1<CR>gv=gv 
vmap <A-Up> :m '<-2<CR>gv=gv

let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#input_patterns={} 
let g:deoplete#sources={} 
let g:deoplete#sources._=['buffer', 'member', 'tag', 'file', 'omni', 'ultisnips'] 


" Haskell
autocmd FileType Haskell call SetHaskellOptions()
function SetHaskellOptions()
    g:hindent_on_save = 1

    call SetupDev()
endfunction

" Markdown
autocmd FileType python call SetPythonOptions()
function SetPythonOptions()
    let python_highlight_all=1
    let b:ale_fixers = ['black']

    call SetupDev()
endfunction

" Markdown
autocmd FileType markdown,pandoc call SetMarkdownOptions()
function SetMarkdownOptions()
	set  filetype=markdown.pandoc
    set fo+=t
    set fo-=l
    set tw=79
    Goyo 80
    Pencil
    UniCycleOn
endfunction

" C/C++
autocmd FileType cpp,c call SetupCpp()
function SetupCpp()
	let g:clang_complete_auto = 0
	let g:clang_library_path = '/nix/store/fggspvgd8sw122p322whbhim7k4myv8p-clang-5.0.1-lib/lib/libclang.so.5.0'
	let g:clang_auto_select = 0
	let g:clang_omnicppcomplete_compliance = 0
	let g:clang_make_default_keymappings = 0

	let g:neomake_error_sign = { 'text': 'E', 'texthl': 'NeomakeErrorSign' }
	let g:neomake_warning_sign = { 'text': 'W', 'texthl': 'NeomakeWarningSign' }   
	"let g:neomake_open_list = 0
	"let g:neomake_list_height = 5
	let g:neomake_highlight_lines = 1
	let g:neomake_cpp_enabled_markers=['clangtidy']
	"let g:neomake_cpp_gcc_maker = {
	"\ 'exe': 'g++',
	"\ 'args': ['-Wall', '-Iinclude', '-Wextra'] 
	"\ }
	let g:neomake_cpp_clangtidy_maker = {
	\ 'exe': 'clang-tidy',
	\ 'args': ['-checks=\*'] 
	\ }

	let g:cpp_class_scope_highlight = 1
	let g:cpp_member_variable_highlight = 1
	let g:cpp_class_decl_highlight = 1
	let g:cpp_experimental_simple_template_highlight = 1

	call neomake#configure#automake('rw', 1000)

	ClangFormatAutoEnable
	ClangFormatAutoEnable

	call SetupDev()
endfunction

" Scala

autocmd BufNewFile,BufRead *.scala call SetupScala()
function SetupScala()
	set ft=scala " Set syntax highlighting for .scala files
	
	au BufWritePost *.scala Neomake! sbt
	
	let g:ensime_maker = {'name': 'Ensime'}
	function! g:ensime_maker.get_list_entries(jobinfo) abort
	  return b:ensime_notes
	endfunction
	
	"ensime only populates b:ensime_notes if it detects Syntastic
	command! -nargs=1 SyntasticCheck execute "call neomake#Make(1, [g:ensime_maker])"
	function! Ensime_retypecheck() abort
	  let b:ensime_notes=[]
	  exe "SyntasticCheck ensime"
	  exe "EnTypeCheck"
	endfunction
	autocmd BufWritePost *.scala call Ensime_retypecheck()
	"	let g:neomake_scala_enabled_makers = []

	nnoremap <C-b> :EnDeclaration<CR>

	let g:deoplete#omni#input_patterns.scala='[^. *\t]\.\w*'
	let g:neomake_scala_enabled_makers = ['sbt']
	let g:neomake_verbose=3
	call SetupDev()
endfunction
         
function SetupDev()

endfunction


" colorscheme badwolf
if (has("termguicolors"))
 set termguicolors
endif

au ColorScheme * hi Normal ctermbg=none guibg=none
au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red

" Theme
set background=dark
let g:gruvbox_improved_strings = 1
let g:gruvbox_italicize_comments = 1
let g:gruvbox_italic = 1
"let g:gruvbox_contrast_dark = 'light'
colorscheme gruvbox
"let g:airline_theme='gruvbox'

