let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
    Plug 'nvim-lua/plenary.nvim' " for gitsigns and telescope
    Plug 'nvim-lua/popup.nvim' " telescope

    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-telescope/telescope-symbols.nvim' " emoji etc
    Plug 'crispgm/telescope-heading.nvim' " markdown. Works?
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'p00f/nvim-ts-rainbow'
    " Unnecessary?
    Plug 'vijaymarupudi/nvim-fzf'
    Plug 'vijaymarupudi/nvim-fzf-commands'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'JoosepAlviste/nvim-ts-context-commentstring'
    Plug 'nvim-treesitter/nvim-treesitter-refactor'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'lewis6991/spellsitter.nvim'

    Plug 'jakewvincent/mkdnflow.nvim'

    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'ThePrimeagen/refactoring.nvim'

    Plug 'sheerun/vim-polyglot'
    Plug 'dmix/elvish.vim', { 'on_ft': ['elvish']}
    Plug 'satabin/hocon-vim'

    Plug 'wellle/targets.vim'
    Plug 'echasnovski/mini.nvim', { 'branch': 'stable' } " For surround

    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-eunuch'
    Plug 'anuvyklack/pretty-fold.nvim'
    Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
    Plug 'tpope/vim-commentary'
    " in this order!
    Plug 'ggandor/lightspeed.nvim'

    Plug 'kyazdani42/nvim-web-devicons'

    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/lsp_extensions.nvim'
    Plug 'kosayoda/nvim-lightbulb'
    Plug 'onsails/lspkind-nvim'
    Plug 'scalameta/nvim-metals'   
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'nvim-lua/lsp-status.nvim'
    Plug 'folke/trouble.nvim'

    Plug 'hkupty/iron.nvim'
    Plug 'jubnzv/mdeval.nvim'
    " Plug 'mfussenegger/nvim-dap'
    " Plug 'theHamsta/nvim-dap-virtual-text'
    " Plug 'nvim-telescope/telescope-dap.nvim'


    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'

    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'

    Plug 'tpope/vim-fugitive'
    Plug 'TimUntersberger/neogit'
    Plug 'samoshkin/vim-mergetool'
    Plug 'junegunn/gv.vim'
    Plug 'tpope/vim-git'
    Plug 'rhysd/git-messenger.vim'
    Plug 'sodapopcan/vim-twiggy'
    Plug 'sindrets/diffview.nvim'
    Plug 'lewis6991/gitsigns.nvim'

    " Text
    Plug 'reedes/vim-pencil', { 'for': ['markdown', 'pandoc', 'mail' ] }
    Plug 'vim-scripts/UniCycle', { 'for': ['markdown', 'pandoc', 'mail' ] }
    Plug 'reedes/vim-textobj-quote', { 'for': ['markdown', 'pandoc', 'mail' ] }
    Plug 'reedes/vim-textobj-sentence', { 'for': ['markdown', 'pandoc', 'mail' ] }
    Plug 'dbmrq/vim-ditto', { 'for': ['markdown', 'pandoc', 'mail' ] }
    Plug 'reedes/vim-lexical', { 'for': ['markdown', 'pandoc', 'mail' ] }


    Plug 'mickael-menu/zk-nvim'

    Plug 'RRethy/vim-illuminate'
    Plug 'edluffy/specs.nvim'
    Plug 'elihunter173/dirbuf.nvim'

    Plug 'nvim-lualine/lualine.nvim'

    Plug 'AndrewRadev/inline_edit.vim'
    Plug 'bogado/file-line'

    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

    Plug 'nvim-neorg/neorg'

    " themes
    Plug 'catppuccin/nvim', {'as': 'catppuccin'}
call plug#end()
