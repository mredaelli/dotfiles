let $NVIM_COC_LOG_LEVEL = 'debug'

call plug#begin('~/.local/share/nvim/plugged')
   Plug 'conradirwin/vim-bracketed-paste'

   Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh',
         \ 'for': ['scala', 'cpp', 'python', 'haskell', 'rust']}

   Plug 'airblade/vim-gitgutter'
   Plug 'tpope/vim-fugitive'

   " Text
   Plug 'junegunn/goyo.vim', { 'for': ['markdown', 'pandoc', 'mail' ] }
   Plug 'junegunn/limelight.vim', { 'for': ['markdown', 'pandoc', 'mail' ] }
   Plug 'reedes/vim-pencil', { 'for': ['markdown', 'pandoc', 'mail' ] }
   Plug 'vim-scripts/UniCycle', { 'for': ['markdown', 'pandoc', 'mail' ] }

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

   Plug 'ctrlpvim/ctrlp.vim'

   " Grepping
   Plug 'mileszs/ack.vim'

   Plug 'tpope/vim-commentary'

   Plug 'easymotion/vim-easymotion'

   Plug 'vim-airline/vim-airline'
   " Plug 'vim-airline/vim-airline-themes'

   " themes
   Plug 'nanotech/jellybeans.vim'
call plug#end()

