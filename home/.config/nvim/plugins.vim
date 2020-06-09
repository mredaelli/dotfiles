call plug#begin('~/.local/share/nvim/plugged')
  Plug 'conradirwin/vim-bracketed-paste'
  Plug 'tmsvg/pear-tree'
  Plug 'kana/vim-textobj-user', { 'for': ['markdown', 'pandoc', 'mail', 'python' ] }
  Plug 'tpope/vim-unimpaired'

  if executable('node')
    Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
  endif

  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim'
  Plug 'tpope/vim-git'
  Plug 'rhysd/git-messenger.vim'
  Plug 'sodapopcan/vim-twiggy'

  " Text
  " Plug 'junegunn/goyo.vim', { 'for': ['markdown', 'pandoc', 'mail' ] }
  Plug 'bilalq/lite-dfm', { 'for': ['markdown', 'pandoc', 'mail' ] }
  " Plug 'junegunn/limelight.vim', { 'for': ['markdown', 'pandoc', 'mail' ] }
  " Plug 'reedes/vim-pencil', { 'for': ['markdown', 'pandoc', 'mail' ] }
  Plug 'vim-scripts/UniCycle', { 'for': ['markdown', 'pandoc', 'mail' ] }
  Plug 'reedes/vim-textobj-quote', { 'for': ['markdown', 'pandoc', 'mail' ] }
  Plug 'reedes/vim-textobj-sentence', { 'for': ['markdown', 'pandoc', 'mail' ] }
  Plug 'dbmrq/vim-ditto', { 'for': ['markdown', 'pandoc', 'mail' ] }

  " Pandoc
  Plug 'vim-pandoc/vim-pandoc', { 'for': ['markdown', 'pandoc'] }
  Plug 'vim-pandoc/vim-pandoc-after', { 'for': ['markdown', 'pandoc'] }
  Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown', 'pandoc'] }

 " Development
  Plug 'idanarye/vim-vebugger', {'for': ['python'] }
  " Plug 'wellle/context.vim'

  " Typescript
  if executable("tsc")
    Plug 'leafgarland/typescript-vim', {'for': ['typescript']}
    Plug 'Quramy/vim-js-pretty-template', {'for': ['typescript']}
    Plug 'HerringtonDarkholme/yats.vim', {'for': ['typescript']}
  endif

  " Go
  if executable("go")
    Plug 'fatih/vim-go', { 'for': ['go'] }
  endif

  " Python
  if executable("python")
    Plug 'numirias/semshi', { 'for': ['python'], 'do': ':UpdateRemotePlugins'}
    " Plug 'kh3phr3n/python-syntax', { 'for': ['python'] }
    Plug 'bps/vim-textobj-python', { 'for': ['python'] }
    Plug 'tmhedberg/SimpylFold', { 'for': ['python'] }
  endif

  " Rust
  if executable('rustc')
    Plug 'rust-lang/rust.vim', { 'for': ['rust'] }
  endif


  " Haskell
  if executable('ghc')
    Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell', 'cabal'] }
    " Plug 'alx741/vim-hindent', { 'for': ['haskell'] }
    " Plug 'bitc/vim-hdevtools', { 'for': ['haskell'] }
  endif

  " Scala
  if executable('scalac')
    Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
  endif

  " C/C++
  Plug 'https://github.com/Rip-Rip/clang_complete.git', { 'for': ['c', 'c++'] }
  Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'c++'] }
  Plug 'rhysd/vim-clang-format' , { 'for': ['c', 'c++'] }

  " R
  if executable('R')
    Plug 'jalvesaq/Nvim-R', { 'for': 'r' }
  endif

  Plug 'LnL7/vim-nix', { 'for': 'nix' }
  Plug 'dag/vim-fish', { 'for': 'fish' }
  Plug 'nathangrigg/vim-beancount', { 'for': 'beancount' }

  Plug 'satabin/hocon-vim'

  Plug 'vimwiki/vimwiki'

  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'yuki-ycino/fzf-preview.vim'

  Plug 'qpkorr/vim-bufkill'

  Plug 'tpope/vim-commentary'

  Plug 'easymotion/vim-easymotion'

  " Plug 'vim-airline/vim-airline'
  Plug 'itchyny/lightline.vim'

  Plug 'AndrewRadev/inline_edit.vim'

  " themes
  Plug 'nanotech/jellybeans.vim'
call plug#end()
