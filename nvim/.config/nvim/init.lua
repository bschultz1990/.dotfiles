-- https://bryankegley.me/posts/nvim-getting-started/
-- GENERAL
vim.scriptencoding = 'utf8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.pumheight = 20
vim.opt.pumblend = 0
vim.opt.cursorline = true
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99
vim.opt.termguicolors = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.cmdheight = 1
vim.opt.shortmess = "F"
vim.opt.wrap.linebreak = true
vim.opt.linebreak = true
vim.opt.whichwrap = "<,>,h,l"
vim.opt.ignorecase = true
vim.opt.winblend = 10

-- TABSTOPS
vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- vim.opt.shiftround = true
vim.opt.softtabstop = 2

-- CLIPBOARD
vim.opt.clipboard:append {'unnamedplus', 'unnamed'}
-- vim.opt.foldenable = false
vim.g.python3_host_prog = true
vim.g.loaded_perl_provider = false

---- NETRW
vim.g.netrw_keepdir = 1
vim.g.netrw_localcopydircmd = 'cp -r'
vim.g.netrw_liststyle = 1

-- NEOVIDE
if (vim.g.neovide) then
	vim.g.neovide_cursor_animation_length = 0.03
	vim.g.neovide_scroll_animation_length = 0.3
	vim.opt.guifont = "FiraCode NF:h11"
	-- set guifont=*  <== lists all fonts
	vim.g.neovide_fullscreen = false
end

-- PLUGINS
-- https://www.notonlycode.org/neovim-lua-config/
-- https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
-- Plug('scrooloose/nerdtree', {on = {NERDTreeToggle', 'NERDTree'})
local Plug = vim.fn["plug#"]
vim.call("plug#begin", vim.fn.stdpath('data').."/plugins")

---- DEV
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'KabbAmine/vCoolor.vim'
Plug 'folke/zen-mode.nvim'
Plug 'folke/twilight.nvim'
Plug 'startup-nvim/startup.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'bschultz1990/cheatsheet.nvim'
Plug 'mhinz/vim-startify'
Plug 'windwp/nvim-autopairs'
Plug 'rcarriga/nvim-notify'
Plug 'nvim-treesitter/nvim-treesitter'
-- Plug 'psliwka/vim-smoothie'
-- Plug 'ThePrimeagen/vim-be-good'

---- LUALINE
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'

---- BUFFERLINE
Plug 'akinsho/bufferline.nvim'

---- TELESCOPE
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

---- NVIM-LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug ('glepnir/lspsaga.nvim', {branch='main'} )

---- COLOR
Plug 'sainnhe/sonokai'
Plug 'norcalli/nvim-colorizer.lua'
Plug ('projekt0n/github-nvim-theme')

---- CHEATSHEETS
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-cheat.sh'
vim.call("plug#end")

-- Colorschemes
-- default, atlantis, andromeda, shusia, maia, espresso
vim.g.sonokai_style = 'shusia'
vim.cmd("colorscheme sonokai")
-- vim.cmd('colorscheme github_dark_default') -- github_dimmed, github_dark_default, github_dark_colorblind, github_light, github_light_default, github_light_colorblind

-- KEYMAPS
vim.g.mapleader = ','

-- GENERAL
vim.api.nvim_set_keymap("n",'<F3>',':wa<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n",'<F5>',':luafile $MYVIMRC<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n","<F6>", ':PlugInstall<cr>', { noremap = true, silent = true }) -- Vim-Plug
vim.api.nvim_set_keymap("n","<F7>", ':PlugClean<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n","<F12>",":edit $MYVIMRC<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n","<leader>ex", ":Explore<cr>", { noremap = true, silent = true })

-- BUFFERS AND SPLITS
vim.api.nvim_set_keymap('n',"<leader>n", ":bn<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n',"<leader>vs",":vs<cr><C-w>w:Ex<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n',"<leader>sp",":sp<cr>:Ex<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n',"<leader>bd",":bp|bd#!<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n',"<leader>tt",":tabnew<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n',"<leader>tc",":tabclose<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n',"<leader>tn",":tabnext<cr>", { noremap = true, silent = true })

-- INSERT MODE GOODIES
vim.api.nvim_set_keymap('i',"<C-cr>","<CR><CR><Up><BS><CR>", { noremap = true, silent = true })

-- PLUGIN SPECIFIC
vim.api.nvim_set_keymap('n',"<leader>st",":Startify<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n',"<leader>zz",":ZenMode<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n',"<leader>td",":Telescope diagnostics<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('x',"ga","<Plug>(EasyAlign)", { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ch', ':Cheat<cr>', { noremap = false, silent = true } )

-- CUSTOM FUNCTIONS
vim.api.nvim_set_keymap('n', '<leader><Tab>', 'magg=G`a', { noremap = true, silent = true }) -- indent on command

-- EXTERNAL REQUIREMENTS
Plugins = {
	'vim-notify_c',
	'telescope_c',
	'nvim-lspconfig_c',
	'lspsaga_c',
	'bufferline_c',
	'nvim-autopairs_c',
	'lualine_c',
	'treesitter_c',
	'cheat_c',
	-- 'luasnip_c',
}

for _, pConfig in ipairs(Plugins) do
	require(pConfig)
end

require ('colorizer').setup()

-- SUCCESS! :)
print(' init.lua loaded! :)')
