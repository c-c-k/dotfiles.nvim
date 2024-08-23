" ---------------------------------------------------------------------------
" Load vim-plug Plugins
" ---------------------------------------------------------------------------

call plug#begin($NVIM_VIM_PLUG_ROOT)

" -- nvim only plugins -----------------

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-tree/nvim-web-devicons'
" Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
" Plug 'renerocksai/telekasten.nvim'
Plug 'jakewvincent/mkdnflow.nvim'
" Plug 'stevearc/gkeep.nvim'
" Plug 'epwalsh/obsidian.nvim'
 Plug 'RRethy/base16-nvim'
" Plug 'shaunsingh/solarized.nvim'
" Plug 'c-c-k/forks-nvim-solarized-lua', { 'branch': 'personal_customization', 'as': 'nvim-solarized-lua' }

" " -- nvim-cmp --------------------------

" Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-cmdline'
" Plug 'hrsh7th/nvim-cmp'

" " For vsnip users.
" " Plug 'hrsh6th/cmp-vsnip'
" " Plug 'hrsh7th/vim-vsnip'

" " For luasnip users.
" " Plug 'L3MON4D3/LuaSnip'
" " Plug 'saadparwaiz1/cmp_luasnip'

" " For ultisnips users.
" Plug 'honza/vim-snippets'
" Plug 'sirver/ultisnips'
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" " For snippy users.
" " Plug 'dcampos/nvim-snippy'
" " Plug 'dcampos/cmp-snippy'


" -- bvim & nvim plugins ---------------

" Plug 'altercation/vim-colors-solarized', { 'as': 'solarized' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', { 'as': 'fzf-vim' }
"Plug 'mileszs/ack.vim'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
" Plug 'preservim/vim-markdown'
" Plug 'alok/notational-fzf-vim'
" Plug 'fmoralesc/vim-pad'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'gu-fan/riv.vim', { 'as': 'riv-vim' }
" Plug 'jceb/vim-orgmode'
" Plug 'michal-h21/vim-zettel'
" Plug 'vimwiki/vimwiki'
" Plug 'xolox/vim-notes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
"Plug 'stevearc/oil.nvim'
"Plug 'scrooloose/nerdcommenter'
"Plug 'scrooloose/syntastic'
"Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'mattn/emmet-vim'
Plug 'dense-analysis/ale'
" Plug 'davidhalter/jedi-vim'
Plug 'ycm-core/youcompleteme'
Plug 'ycm-core/lsp-examples'
Plug 'github/copilot.vim'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }
Plug 'honza/vim-snippets'
Plug 'sirver/ultisnips'
Plug 'ervandew/supertab'
Plug 'diepm/vim-rest-console'
"Plug 'pangloss/vim-javascript'
Plug 'aklt/plantuml-syntax'

call plug#end()
