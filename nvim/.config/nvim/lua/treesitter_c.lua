-- need help?
-- :h nvim-treesitter-commands

local M = {}

require 'nvim-treesitter.configs'.setup{
	sync_install = true,
	auto_install = true,
	highlight = { enable = false },
	additional_vim_regex_highlighting = false,
	-- indent = { enable = true },
}

return M
