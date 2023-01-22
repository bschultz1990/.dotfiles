local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- KEYMAPS
vim.g.mapleader = ','

require("lazy").setup({
	{ 'tpope/vim-surround' },
	{ 'tpope/vim-commentary' },
	{ 'tpope/vim-repeat' },
	{ 'KabbAmine/vCoolor.vim' },
	{ 'folke/zen-mode.nvim' },
	{ 'junegunn/vim-easy-align' },
	{ 'windwp/nvim-autopairs' },
	{ 'rcarriga/nvim-notify' },
	{ 'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate' },
	{ 'iamcco/markdown-preview.nvim' },
	{ 'kyazdani42/nvim-web-devicons' },
	{ 'nvim-lualine/lualine.nvim' },
	{ 'nvim-telescope/telescope.nvim' },
	{ 'nvim-lua/plenary.nvim' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'hrsh7th/cmp-nvim-lua' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-cmdline' },
	{ 'hrsh7th/vim-vsnip' },
	{ 'hrsh7th/cmp-vsnip' },
	{ 'hrsh7th/vim-vsnip-integ' },
	{ 'rafamadriz/friendly-snippets' },
	{ 'glepnir/lspsaga.nvim' },
	{ 'tzachar/cmp-tabnine', build = './install.sh'  },
	{ 'onsails/lspkind.nvim' },
	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'neovim/nvim-lspconfig' },
	{ 'sainnhe/sonokai' },
	{ 'ap/vim-css-color' },
	{ 'marko-cerovac/material.nvim',
		priority = 9000,
		config = function()
			vim.g.material_style = 'palenight'
			vim.cmd('colorscheme material')
		end,
	},
	{ 'drewtempelmeyer/palenight.vim', },
	{ 'sheerun/vim-polyglot' },
	{ 'norcalli/nvim-colorizer.lua' },
})

-- MIGRATION FROM PACKER
-- setup => init
-- requires => dependencies
-- as => name
-- opt => lazy
-- run => build
-- lock => pin
-- disable=true => enabled = false
-- tag='*' => version="*"
-- after information_source not needed for most use-cases. Use dependencies otherwise.
-- wants information_source not needed for most use-cases. Use dependencies otherwise.
-- config don't support string type, use fun(LazyPlugin) instead.
-- module is auto-loaded. No need to specify
