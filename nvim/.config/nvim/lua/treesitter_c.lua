-- need help?
-- :h nvim-treesitter-commands

local M = {}

require 'nvim-treesitter.configs'.setup{
	sync_install = true,
	auto_install = true,
	highlight = { enable = false },
	additional_vim_regex_highlighting = true,
	-- indent = { enable = true },
}

return M
