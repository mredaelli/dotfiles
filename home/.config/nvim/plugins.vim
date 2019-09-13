let $NVIM_COC_LOG_LEVEL = 'debug'

call plug#begin('~/.local/share/nvim/plugged')
   Plug 'conradirwin/vim-bracketed-paste'

   Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'} " 'do': './install.sh' }

   Plug 'airblade/vim-gitgutter'
   Plug 'tpope/vim-fugitive'

   " Text
   Plug 'junegunn/goyo.vim', { 'for': ['markdown', 'pandoc', 'mail' ] }
   Plug 'junegunn/limelight.vim', { 'for': ['markdown', 'pandoc', 'mail' ] }
   Plug 'reedes/vim-pencil', { 'for': ['markdown', 'pandoc', 'mail' ] }
   Plug 'vim-scripts/UniCycle', { 'for': ['markdown', 'pandoc', 'mail' ] }


   " Go
   if executable("go")
     Plug 'fatih/vim-go', { 'for': ['go'] }
   endif

   " Python
   if executable("python")
     Plug 'vim-python/python-syntax', { 'for': ['python'] }
   endif

   " Rust
   if executable('rustc')
     Plug 'rust-lang/rust.vim', { 'for': ['rust'] }
   endif

   " Pandoc
   Plug 'vim-pandoc/vim-pandoc', { 'for': ['markdown', 'pandoc'] }
   Plug 'vim-pandoc/vim-pandoc-after', { 'for': ['markdown', 'pandoc'] }
   Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown', 'pandoc'] }

   " Haskell
   if executable('ghc')
     Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell', 'cabal'] }
     " Plug 'alx741/vim-hindent', { 'for': ['haskell'] }
     " Plug 'bitc/vim-hdevtools', { 'for': ['haskell'] }
   endif

   " Scala
   if executable('scalac')
     Plug 'ensime/ensime-vim', { 'do': ':UpdateRemotePlugins' , 'for': 'scala' }
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

   Plug 'vimwiki/vimwiki'

   " Plug 'ctrlpvim/ctrlp.vim'
   Plug 'junegunn/fzf'
   Plug 'junegunn/fzf.vim'

   " Grepping
   Plug 'mileszs/ack.vim'

   Plug 'tpope/vim-commentary'

   Plug 'easymotion/vim-easymotion'

   Plug 'vim-airline/vim-airline'

   " themes
   Plug 'nanotech/jellybeans.vim'
call plug#end()

