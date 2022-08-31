local ls = require 'luasnip'
local types = require 'luasnip.util.types'

-- User-defined snippets are in this path:
require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('data')..'/snippets' })

ls.config.set_config {
	history=true, -- Remember the last snippet.
	updateevents = 'TextChanged,TextChanged1', -- Update dynamic snippets as you type.
	vim.keymap.set({ 'i', 's' }, '<c-j>', function()
		if ls.expand_or_jumpable() then
			ls.expand_or_jump()
		end
	end, { silent = true })
}
