"https://www.notonlycode.org/neovim-lua-config/
"https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
"Plug('scrooloose/nerdtree', {on = {NERDTreeToggle', 'NERDTree'})\
set nowrap

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

	"ICONS AND BUFFERLINE
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'akinsho/bufferline.nvim'

	"TELESCOPE
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-lua/plenary.nvim'

	"LSP
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-nvim-lua'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	" Plug 'L3MON4D3/LuaSnip'
	" Plug 'saadparwaiz1/cmp_luasnip'
	Plug 'hrsh7th/vim-vsnip'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/vim-vsnip-integ'
	Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
	Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
	Plug 'onsails/lspkind.nvim' "Pictograms in completion menu.

	" Keep these three in order:
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'neovim/nvim-lspconfig'

	"COLORS
	Plug 'sainnhe/sonokai'
	Plug 'ap/vim-css-color'
	Plug 'kyazdani42/nvim-palenight.lua'
	Plug 'sheerun/vim-polyglot'
	Plug 'norcalli/nvim-colorizer.lua'
call plug#end()
