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
		{ "echasnovski/mini.bufremove",
			lazy = false,
			-- stylua: ignore
			keys = {
				{ "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
				{ "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
			},
		},
		{ 'tpope/vim-surround',
			event = 'BufReadPre'
		},
		{ 'tpope/vim-commentary',
			event = 'BufReadPre'
		},
		{ 'tpope/vim-repeat',
			event = 'BufReadPre'
		},
		{ 'KabbAmine/vCoolor.vim',
			event = 'BufReadPre'
		},
		{ 'folke/zen-mode.nvim' },
		{ 'junegunn/vim-easy-align' },
		{ 'windwp/nvim-autopairs',
			config = function()
				require('nvim-autopairs').setup {
					disable_filetype = { 'TelescopePrompt' },
					disable_in_macro = false,  -- disable when recording or executing a macro
					disable_in_visualblock = false, -- disable when insert after visual block mode
					ignored_next_char = [=[[%w%%%'%[%"%.]]=],
					enable_moveright = true,
					enable_afterquote = true,  -- add bracket pairs after quote
					enable_check_bracket_line = true,  --- check bracket in same line
					enable_bracket_in_quote = true, --
					enable_abbr = false, -- trigger abbreviation
					break_undo = true, -- switch for basic rule break undo sequence
					check_ts = false,
					map_cr = true,
					map_bs = true,  -- map the <BS> key
					map_c_h = false,  -- Map the <C-h> key to delete a pair
					map_c_w = false, -- map <c-w> to delete a pair if possible
				}
			end
		},
		{ 'rcarriga/nvim-notify' },
		{ 'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate',
			lazy = false,
		},
		{ 'iamcco/markdown-preview.nvim',
			ft = 'markdown'
		},
		{ 'kyazdani42/nvim-web-devicons' },
		{ 'nvim-lualine/lualine.nvim',
			event = 'VimEnter',
			config = function()
				require('lualine').setup {
					options = {
						icons_enabled = true,
						-- see https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md for a full list of themes
						theme = 'auto',
						component_separators = { left = '', right = ''},
						section_separators = { left = '', right = ''},
						disabled_filetypes = {
							statusline = {},
							winbar = {},
						},
						ignore_focus = {},
						always_divide_middle = true,
						globalstatus = false,
						refresh = {
							statusline = 1000,
							tabline = 1000,
							winbar = 1000,
						}
					},
					sections = {
						lualine_a = {'mode'},
						lualine_b = {'branch', 'diff', 'diagnostics'},
						lualine_c = {'filename'},
						lualine_x = {'encoding', 'filetype'},
						lualine_y = {'progress'},
						lualine_z = {'location'}
					},
					inactive_sections = {
						lualine_a = {},
						lualine_b = {},
						lualine_c = {'filename'},
						lualine_x = {'location'},
						lualine_y = {},
						lualine_z = {}
					},
					tabline = {},
					winbar = {},
					inactive_winbar = {},
					extensions = {}
				}
			end
		},
		{ 'nvim-telescope/telescope.nvim',
			dependencies = {
				'nvim-lua/popup.nvim',
				'nvim-lua/plenary.nvim',
			},
			config = function ()
				require('telescope').setup {
					extensions = {
						media_files = {
							find_cmd = 'rg',
						},
						file_browser = {
							-- hijack_netrw = true,
						}
					},
					defaults = {
						file_ignore_patterns = {'%.git', '%.npm', '%node_modules'},
						-- layout_strategy = 'vertical',
						layout_config = {
							height = 125,
						}
					},
					pickers = {
						find_files = {
							hidden = true
							-- find_command = {'fzf'},
						},
					}
				}
				---- TELESCOPE MAPPINGS
				vim.api.nvim_set_keymap('n','<leader>bb',':Telescope buffers<cr>',{ noremap = true, silent = true })
				vim.api.nvim_set_keymap('n','<leader>ff',':Telescope find_files<cr>',{ noremap = true, silent = true })
				vim.api.nvim_set_keymap('n','<leader>fg',':Telescope live_grep<cr>',{ noremap = true, silent = true })
				vim.api.nvim_set_keymap('n','<leader>td',':Telescope diagnostics<cr>', { noremap = true, silent = true })
				vim.api.nvim_set_keymap('n','<leader>th',':Telescope help_tags<cr>', { noremap = true, silent = true })
				vim.api.nvim_set_keymap('n','<leader>tk',':Telescope keymaps<cr>', { noremap = true, silent = true })
			end
		},
		{ 'hrsh7th/nvim-cmp',
			dependencies = {
				'hrsh7th/cmp-nvim-lua',
				'hrsh7th/cmp-nvim-lsp',
				'hrsh7th/cmp-path',
				'hrsh7th/cmp-cmdline',
			}
		},
		{ 'hrsh7th/vim-vsnip',
			event = 'BufReadPre',
			dependencies = {
				'hrsh7th/cmp-vsnip',
				'hrsh7th/vim-vsnip-integ',
				'rafamadriz/friendly-snippets',
			}
		},
		{ 'glepnir/lspsaga.nvim',
			config = function()
				local saga = require('lspsaga')
				saga.init_lsp_saga({
						vim.keymap.set({'n','v'}, '<leader>ca', '<cmd>Lspsaga code_action<CR>', {silent=true})
					})
				ui = {
					-- currently only round theme
					theme = 'round',
					-- border type can be single,double,rounded,solid,shadow.
					border = 'solid',
					winblend = 0,
					expand = '',
					collapse = '',
					preview = ' ',
					code_action = '💡',
					diagnostic = '🐞',
					incoming = ' ',
					outgoing = ' ',
					colors = {
						--float window normal bakcground color
						normal_bg = '#1d1536',
						--title background color
						title_bg = '#afd700',
						red = '#e95678',
						magenta = '#b33076',
						orange = '#FF8700',
						yellow = '#f7bb3b',
						green = '#afd700',
						cyan = '#36d0e0',
						blue = '#61afef',
						purple = '#CBA6F7',
						white = '#d1d4cf',
						black = '#1c1c19',
					},
					kind = {},
				}

				lightbulb = {
					enable = false,
					enable_in_insert = false,
					sign = false,
					sign_priority = 40,
					virtual_text = true,
				}
			end
		},
		{ 'tzachar/cmp-tabnine',
			build = './install.sh',
			event = 'BufReadPre'
		},
		{ 'williamboman/mason.nvim',
			config = function ()
				require('mason').setup()
			end
		},
		{ 'williamboman/mason-lspconfig.nvim',
			event = 'BufReadPre',
			config = function()
				require("mason-lspconfig").setup({
						automatic_installation = true,
					})
			end
		},
		{ 'neovim/nvim-lspconfig',
			event = 'BufReadPre',
			dependencies = 'onsails/lspkind.nvim',
			config = function ()
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

				require('lspsaga').setup({})

				local configs = require('lspconfig/configs')
				----------CONNECT TO SERVERS------------
				-- read more at :h vim.lsp.buf<TAB>
				-- Need more servers?
				-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
				----------------------------------------
				Servers = { 'tsserver',
					'sumneko_lua',
					'emmet_ls',
					'cssls',
				}
				for index, lsp in ipairs(Servers) do
					require('lspconfig')[lsp].setup{}
				end

				local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
				capabilities.textDocument.completion.completionItem.snippetSupport = true

				function LspKeymaps()
					-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, {buffer=0})
					vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', { silent = true })
					vim.keymap.set('n', 'gd', '<cmd>Lspsaga peek_definition<CR>', { buffer = 0, silent = true })
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer=0 })
					vim.keymap.set('n', '<leader>r', '<cmd>Lspsaga rename<CR>', { silent = true })
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer=0 })
					vim.keymap.set('n', '<leader>d', '<cmd>Lspsaga show_line_diagnostics<CR>', { silent = true } )
					vim.keymap.set('n','<leader>o', '<cmd>LSoutlineToggle<CR>',{ silent = true })
					vim.diagnostic.config({ virtual_text=true })
					capabilities=capabilities
				end



				-----------EMMET-----------
				require('lspconfig').emmet_ls.setup {
					on_attach = function()
						print('emmet_ls attached')
					end,
					filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'jst'},
				}

				-----------CSSLS-----------
				require'lspconfig'.cssls.setup {
					on_attach = function ()
						capabilities.textDocument.completion.completionItem.snippetSupport = true
						LspKeymaps()
						vim.keymap.set('n', '<C-k>', vim.lsp.buf.references, { buffer = 0 })
						print ('cssls attached!')
					end,
				}

				-----------SUMNEKO-LUA-----------
				require ('lspconfig').sumneko_lua.setup {
					on_attach = function()
						LspKeymaps()
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
						LspKeymaps()
						print('tsserver attached')
					end
				}


				--------------TABNINE---------------
				local tabnine = require('cmp_tabnine.config')

				tabnine:setup({
						max_lines = 1000,
						max_num_results = 3,
						sort = true,
						run_on_every_keystroke = true,
						snippet_placeholder = '...',
						ignored_file_types = {
							-- default is not to ignore
							-- uncomment to ignore in lua:
							-- lua = true
						},
						show_prediction_strength = false
					})
				--------------NVIM-CMP--------------
				-- Setup nvim-cmp.
				vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
				local cmp = require'cmp'
				local lspkind = require('lspkind')
				cmp.setup({
						formatting = {
							format = lspkind.cmp_format ({
									mode = 'symbol',
									maxwidth = 50,
									ellipsis_char = '...'
								})
						},
						snippet = {
							expand = function(args)
								vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
								-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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
								{ name = 'nvim_lsp', keyword_length=1 },
								{ name = 'emmet_ls', keyword_length=1 },
								{ name = 'vsnip', keyword_length=3 }, -- vsnip, ultisnips, snippy, luasnip 
								{ name = 'cmp_tabnine', keyword_length=3 },
								{ name = 'nvim_lua', keyword_length=3 },
								{ name = 'path', keyword_length=3 },
								-- { name = 'buffer', keyword_length=3 },
							}),
						view = {
							entries = "native"
						},
						experimental = {
							ghost_text = false,
						}
					})
			end
		},
		{ 'ap/vim-css-color',
			ft = 'css'
		},
		{ 'marko-cerovac/material.nvim',
			priority = 9000,
			config = function()
				vim.g.material_style = 'palenight'
				vim.cmd('colorscheme material')
			end,
		},
		{ 'drewtempelmeyer/palenight.vim' },
		{ 'sheerun/vim-polyglot',
			event = 'BufReadPre'
		},
		{ 'norcalli/nvim-colorizer.lua' },
		{ 'echasnovski/mini.starter',
			-- version = false, -- wait till new 0.7.0 release to put it back on semver
			event = "VimEnter",
			opts = function()
				local logo = table.concat({
						"██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z",
						"██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z",
						"██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z",
						"██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z",
						"███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║",
						"╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝",
					}, "\n")
				local pad = string.rep(" ", 22)
				local new_section = function(name, action, section)
					return { name = name, action = action, section = pad .. section }
				end

				local starter = require("mini.starter")
				--stylua: ignore
				local config = {
					evaluate_single = true,
					header = logo,
					items = {
						new_section("Find file",    "Telescope find_files", "Telescope"),
						new_section("Recent files", "Telescope oldfiles",   "Telescope"),
						new_section("Grep text",    "Telescope live_grep",  "Telescope"),
						new_section("init.lua",     "e $MYVIMRC",           "Config"),
						new_section("Plugins",":edit /home/bens/.dotfiles/nvim/.config/nvim/lua/plugins_c.lua", "Config"),
						new_section("Lazy",         "Lazy",                 "Config"),
						new_section("New file",     "ene | startinsert",    "Built-in"),
						new_section("Quit",         "qa",                   "Built-in"),
					},
					content_hooks = {
						starter.gen_hook.adding_bullet(pad .. "░ ", false),
						starter.gen_hook.aligning("center", "center"),
					},
				}
				return config
			end,
			config = function(_, config)
				-- close Lazy and re-open when starter is ready
				if vim.o.filetype == "lazy" then
					vim.cmd.close()
					vim.api.nvim_create_autocmd("User", {
							pattern = "MiniStarterOpened",
							callback = function()
								require("lazy").show()
							end,
						})
				end

				local starter = require("mini.starter")
				starter.setup(config)

				vim.api.nvim_create_autocmd("User", {
						pattern = "LazyVimStarted",
						callback = function()
							local stats = require("lazy").stats()
							local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
							local pad_footer = string.rep(" ", 8)
							starter.config.footer = pad_footer .. "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
							pcall(starter.refresh)
						end,
					})
			end,
		},
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
