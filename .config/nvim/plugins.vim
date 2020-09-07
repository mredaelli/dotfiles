call plug#begin('~/.local/share/nvim/plugged')

  Plug 'kana/vim-textobj-user', { 'for': ['markdown', 'pandoc', 'mail', 'python' ] }
  Plug 'wellle/targets.vim'
  Plug 'tpope/vim-unimpaired'

  Plug 'sheerun/vim-polyglot'

  Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }

  Plug 'ncm2/ncm2'
  Plug 'roxma/nvim-yarp'

  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim'
  Plug 'tpope/vim-git'
  Plug 'rhysd/git-messenger.vim'
  Plug 'sodapopcan/vim-twiggy'

  " Text
  Plug 'reedes/vim-pencil', { 'for': ['markdown', 'pandoc', 'mail' ] }
  Plug 'vim-scripts/UniCycle', { 'for': ['markdown', 'pandoc', 'mail' ] }
  Plug 'reedes/vim-textobj-quote', { 'for': ['markdown', 'pandoc', 'mail' ] }
  Plug 'reedes/vim-textobj-sentence', { 'for': ['markdown', 'pandoc', 'mail' ] }
  Plug 'dbmrq/vim-ditto', { 'for': ['markdown', 'pandoc', 'mail' ] }
  Plug 'reedes/vim-lexical', { 'for': ['markdown', 'pandoc', 'mail' ] }

  " Pandoc
  " Plug 'vim-pandoc/vim-pandoc', { 'for': ['markdown', 'pandoc'] }
  " Plug 'vim-pandoc/vim-pandoc-after', { 'for': ['markdown', 'pandoc'] }
  " Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown', 'pandoc'] }

 " Development
  Plug 'idanarye/vim-vebugger', {'for': ['python'] }
  " Plug 'wellle/context.vim'


  " Python
  if executable("python")
    " Plug 'numirias/semshi', { 'for': ['python'], 'do': ':UpdateRemotePlugins'}
    Plug 'kh3phr3n/python-syntax', { 'for': ['python'] }
    Plug 'bps/vim-textobj-python', { 'for': ['python'] }
    Plug 'tmhedberg/SimpylFold', { 'for': ['python'] }
  endif

  Plug 'nathangrigg/vim-beancount', { 'for': 'beancount' }

  Plug 'satabin/hocon-vim'

  Plug 'vimwiki/vimwiki'

  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  Plug 'qpkorr/vim-bufkill'

  Plug 'tpope/vim-commentary'

  Plug 'justinmk/vim-sneak'
  Plug 'danilamihailov/beacon.nvim'
  Plug 'justinmk/vim-dirvish'

  Plug 'itchyny/lightline.vim'

  Plug 'AndrewRadev/inline_edit.vim'

  " themes
  " Plug 'nanotech/jellybeans.vim'
   Plug 'joshdick/onedark.vim'
  " Plug 'tyrannicaltoucan/vim-deep-space'
call plug#end()
