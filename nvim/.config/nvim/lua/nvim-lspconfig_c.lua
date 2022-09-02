local M = {}

-- Is there an lspconfig in the house?
local lspconfig_ok, _ = pcall(require, 'lspconfig')
if not lspconfig_ok then
	vim.notify('lspconfig not found.', 'error')
	return
end

local saga_ok, _ = pcall(require, 'lspsaga')
if not saga_ok then
	vim.notify('lspsaga not found.', 'error')
	return
end

require('lspsaga').init_lsp_saga()

----------CONNECT TO SERVERS------------
-- read more at :h vim.lsp.buf<TAB>
-- Need more servers?
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
----------------------------------------
Servers = { 'tsserver',
'sumneko_lua',
'emmet_ls',
-- 'cssls',
}
for index, lsp in ipairs(Servers) do
	require('lspconfig')[lsp].setup{}
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

function M.LspKeymaps()
	-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, {buffer=0})
	vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', { silent = true })
	vim.keymap.set('n', '<C-k>', '<cmd>Lspsaga preview_definition<CR>', { silent = true })
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer=0 })
	vim.keymap.set('n', '<leader>r', '<cmd>Lspsaga rename<CR>', { silent = true })
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer=0 })
	vim.keymap.set('n', '<leader>d', '<cmd>Lspsaga show_line_diagnostics<CR>', { silent = true } )
	vim.keymap.set('n','<leader>o', '<cmd>LSoutlineToggle<CR>',{ silent = true })
	vim.diagnostic.config({ virtual_text=false })
	capabilities=capabilities
end


-----------CSSLS-----------
require'lspconfig'.cssls.setup {
	on_attach = function ()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		M.LspKeymaps()
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.references, { buffer = 0 })
		print ('cssls attached!')
	end,
}

-----------SUMNEKO-LUA-----------
require ('lspconfig').sumneko_lua.setup {
	on_attach = function()
		M.LspKeymaps()
		print('sumneko_lua attached')
	end,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	}
}


--------------TSSERVER--------------
require('lspconfig').tsserver.setup{
	on_attach = function ()
		M.LspKeymaps()
		print('tsserver attached')
	end
}
--------------NVIM-CMP--------------
-- Setup nvim-cmp.
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
local cmp = require'cmp'
cmp.setup({
	snippet = {
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<Tab>'] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Insert,
		}),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }, -- vsnip, ultisnips, snippy, luasnip 
		{ name = 'nvim_lua' },
		{ name = 'path' },
		{ name = 'buffer', keyword_length=5 },
	}),
	experimental = {
		native_menu = false,
		ghost_text = true,
	}
})
