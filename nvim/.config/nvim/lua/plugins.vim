"https://www.notonlycode.org/neovim-lua-config/
"https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
"Plug('scrooloose/nerdtree', {on = {NERDTreeToggle', 'NERDTree'})

call plug#begin()
	"DEV
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-repeat'
	Plug 'KabbAmine/vCoolor.vim'
	Plug 'folke/zen-mode.nvim'
	Plug 'folke/twilight.nvim'
	Plug 'junegunn/vim-easy-align'
	Plug 'bschultz1990/cheatsheet.nvim'
	Plug 'mhinz/vim-startify'
	Plug 'windwp/nvim-autopairs'
	Plug 'rcarriga/nvim-notify'
	Plug 'nvim-treesitter/nvim-treesitter'
	Plug 'iamcco/markdown-preview.nvim'
" cmd(mkdp#util#install())


	"ICONS AND BUFFERLINE
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'akinsho/bufferline.nvim'

	"TELESCOPE
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-lua/plenary.nvim'

	"LSP
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-nvim-lua'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-path'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'saadparwaiz1/cmp_luasnip'
	Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

	"COLORS
	Plug 'sainnhe/sonokai'
	Plug 'ap/vim-css-color'
	Plug 'projekt0n/github-nvim-theme'
	Plug 'RRethy/nvim-base16'
	Plug 'kyazdani42/nvim-palenight.lua'
	Plug 'sheerun/vim-polyglot'
call plug#end()
