call plug#begin('~/.local/share/nvim/plugged')
   Plug 'conradirwin/vim-bracketed-paste'

   " newer versions require pynvim 0.3.x, but NixOS is lagging behind
   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins', 'tag': '4.0' }
   "Plug 'neomake/neomake', { 'for': ['scala', 'cpp', 'python', 'haskell', 'rust'] }
   Plug 'w0rp/ale', { 'for': ['scala', 'cpp', 'python', 'haskell', 'rust'] }
   
   " Text
   Plug 'junegunn/goyo.vim', { 'for': ['markdown', 'pandoc', 'mail' ] }
   Plug 'junegunn/limelight.vim', { 'for': ['markdown', 'pandoc', 'mail' ] }
   Plug 'reedes/vim-pencil', { 'for': ['markdown', 'pandoc', 'mail' ] }
   Plug 'vim-scripts/UniCycle', { 'for': ['markdown', 'pandoc', 'mail' ] }

   " Rust
   if executable('rustc')
     Plug 'rust-lang/rust.vim', { 'for': ['rust'] }
     Plug 'racer-rust/vim-racer', { 'for': ['rust'] }
   endif

   " Pandoc
   Plug 'vim-pandoc/vim-pandoc', { 'for': ['markdown', 'pandoc'] }
   Plug 'vim-pandoc/vim-pandoc-after', { 'for': ['markdown', 'pandoc'] }
   Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown', 'pandoc'] }

   " Haskell
   if executable('ghc')
     Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell', 'cabal'] }
     Plug 'alx741/vim-hindent', { 'for': ['haskell'] }
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
   Plug 'ledger/vim-ledger', { 'for': 'ledger' }

   Plug 'ctrlpvim/ctrlp.vim'

   " Grepping
   Plug 'mileszs/ack.vim'

   Plug 'tpope/vim-commentary'

   Plug 'easymotion/vim-easymotion'

   Plug 'vim-airline/vim-airline'
   Plug 'vim-airline/vim-airline-themes'

   " themes
   "Plug 'sjl/badwolf'
   "Plug 'joshdick/onedark.vim'
   "Plug 'jacoborus/tender.vim'
   "Plug 'morhetz/gruvbox'
   "Plug 'notpratheek/vim-luna'
   Plug 'romainl/Apprentice'
   "Plug 'NLKNguyen/papercolor-theme'
call plug#end()

