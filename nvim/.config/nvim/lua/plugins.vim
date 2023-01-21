"https://www.notonlycode.org/neovim-lua-config/
"https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
set nowrap

call plug#begin()
	"DEV
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-repeat'
	Plug 'KabbAmine/vCoolor.vim'
	Plug 'folke/zen-mode.nvim'
	Plug 'unegunn/vim-easy-align'
	Plug 'mhinz/vim-startify'
	Plug 'windwp/nvim-autopairs'
	Plug 'rcarriga/nvim-notify'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
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
	Plug 'hrsh7th/vim-vsnip'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/vim-vsnip-integ'
	Plug 'rafamadriz/friendly-snippets'
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
	Plug 'marko-cerovac/material.nvim'
	Plug 'drewtempelmeyer/palenight.vim'
	Plug 'sheerun/vim-polyglot'
	Plug 'norcalli/nvim-colorizer.lua'
call plug#end()
