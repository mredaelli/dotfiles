call plug#begin('~/.local/share/nvim/plugged')

    Plug 'kana/vim-textobj-user', { 'for': ['markdown', 'pandoc', 'mail' ] }
    Plug 'wellle/targets.vim'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-eunuch'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'tpope/vim-surround'

    Plug 'sheerun/vim-polyglot'

    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    " Plug 'nvim-treesitter/nvim-treesitter-refactor'
    Plug 'windwp/nvim-ts-autotag'

    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/lsp_extensions.nvim'
    Plug 'kosayoda/nvim-lightbulb'
    Plug 'folke/trouble.nvim'

    Plug 'hrsh7th/nvim-compe'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'norcalli/snippets.nvim'

    Plug 'hkupty/iron.nvim'

    Plug 'nvim-lua/lsp-status.nvim'

    " Git
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'
    Plug 'tpope/vim-git'
    Plug 'rhysd/git-messenger.vim'
    Plug 'sodapopcan/vim-twiggy'
    Plug 'sindrets/diffview.nvim'

    Plug 'kyazdani42/nvim-tree.lua'

    " Text
    Plug 'reedes/vim-pencil', { 'for': ['markdown', 'pandoc', 'mail' ] }
    Plug 'vim-scripts/UniCycle', { 'for': ['markdown', 'pandoc', 'mail' ] }
    Plug 'reedes/vim-textobj-quote', { 'for': ['markdown', 'pandoc', 'mail' ] }
    Plug 'reedes/vim-textobj-sentence', { 'for': ['markdown', 'pandoc', 'mail' ] }
    Plug 'dbmrq/vim-ditto', { 'for': ['markdown', 'pandoc', 'mail' ] }
    Plug 'reedes/vim-lexical', { 'for': ['markdown', 'pandoc', 'mail' ] }

    " Pandoc
    Plug 'vim-pandoc/vim-pandoc', { 'for': ['markdown', 'pandoc'] }
    " Plug 'vim-pandoc/vim-pandoc-after', { 'for': ['markdown', 'pandoc'] }
    Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown', 'pandoc'] }

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'vijaymarupudi/nvim-fzf'
    Plug 'vijaymarupudi/nvim-fzf-commands'
    " Plug 'mfussenegger/nvim-dap'
    " Plug 'theHamsta/nvim-dap-virtual-text'
    " Plug 'nvim-telescope/telescope-dap.nvim'
    "
    Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
    Plug 'p00f/nvim-ts-rainbow'
    Plug 'JoosepAlviste/nvim-ts-context-commentstring'

    Plug 'nathangrigg/vim-beancount', { 'for': 'beancount' }

    Plug 'satabin/hocon-vim'

    Plug 'lervag/wiki.vim'

    Plug 'qpkorr/vim-bufkill'

    Plug 'tpope/vim-commentary'

    Plug 'justinmk/vim-sneak'
    Plug 'danilamihailov/beacon.nvim'
    Plug 'justinmk/vim-dirvish'

    Plug 'hoob3rt/lualine.nvim'

    Plug 'AndrewRadev/inline_edit.vim'

    " themes
    Plug 'joshdick/onedark.vim'

    Plug 'rktjmp/lush.nvim'
    Plug 'olimorris/onedark.nvim'

    Plug 'tjdevries/colorbuddy.nvim'
    Plug 'marko-cerovac/material.nvim', {'branch': 'pure-lua'}

    Plug 'bluz71/vim-moonfly-colors'

    Plug 'folke/tokyonight.nvim'
call plug#end()

