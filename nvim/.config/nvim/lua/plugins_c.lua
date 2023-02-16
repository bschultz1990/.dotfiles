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
		{ 'windwp/nvim-autopairs',
			init = function()
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
			end,
		},
		{ "akinsho/bufferline.nvim",
			version = "v3.*",
			depends = { "kyazdani42/nvim-web-devicons"},
			init = function ()
				vim.opt.termguicolors = true,
				require("bufferline").setup{}
			end,
		},
		{ "echasnovski/mini.bufremove",
			lazy = false,
			-- stylua: ignore
			keys = {
				{ "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
				{ "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
			},
		},
		{ 'tpope/vim-surround',
			event = 'VimEnter'
		},
		{ 'tpope/vim-commentary',
			event = 'VimEnter'
		},
		{ 'tpope/vim-repeat',
			event = 'VimEnter'
		},
		{ 'folke/zen-mode.nvim',
			event = "VimEnter",
		},
		{ 'folke/twilight.nvim',
			event = "VimEnter",
		},
		{ 'junegunn/vim-easy-align',
			event = "VimEnter",
		},
		{ 'rcarriga/nvim-notify' },
		{ 'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate',
			lazy = false,
			init = function ()
				require'nvim-treesitter.configs'.setup {
					ensure_installed = { "markdown", "html", "css", "javascript" },

					-- Automatically install missing parsers when entering buffer
					-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
					auto_install = false,
				}
			end},
			{ 'kyazdani42/nvim-web-devicons' },
			{ 'nvim-lualine/lualine.nvim',
				event = 'VimEnter',
				init = function()
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
					'nvim-telescope/telescope-file-browser.nvim'
				},
				config = function ()
					require('telescope').setup {
						extensions = {
							file_browser = {
								-- hijack_netrw = true,
							}
						},
						defaults = {
							file_ignore_patterns = {'%.git', '%.npm', '%node_modules'},
							layout_strategy = 'vertical',
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
					-- Load Extra Extensions
					require("telescope").load_extension "file_browser"

					---- TELESCOPE MAPPINGS
					vim.api.nvim_set_keymap('n','<leader>bb',':Telescope buffers<cr>',{ noremap = true, silent = true })
					vim.api.nvim_set_keymap('n','<leader>ff',':Telescope find_files<cr>',{ noremap = true, silent = true })
					vim.api.nvim_set_keymap('n','<leader>tg',':Telescope live_grep<cr>',{ noremap = true, silent = true })
					vim.api.nvim_set_keymap('n','<leader>td',':Telescope diagnostics<cr>', { noremap = true, silent = true })
					vim.api.nvim_set_keymap('n','<leader>th',':Telescope help_tags<cr>', { noremap = true, silent = true })
					vim.api.nvim_set_keymap('n','<leader>tk',':Telescope keymaps<cr>', { noremap = true, silent = true })
					vim.api.nvim_set_keymap('n','<leader>tb',':Telescope file_browser path=%:p:h select_buffer=true<cr>', { noremap = true, silent = true })
				end
			},
			--			TABNINE HERE
			{ 'ap/vim-css-color',
				-- ft = 'css'
			},
			{ 'marko-cerovac/material.nvim',
				priority = 9000,
				init = function()
					-- oceanic, deep ocean, palenight, darker, lighter
					vim.g.material_style = 'deep ocean'
				end,
			},
			{'ghifarit53/tokyonight-vim',
				init = function()
					vim.g.tokyonight_style = 'night'
					-- night, storm
				end
			},
			{'sainnhe/sonokai',
				init = function()
					vim.g.sonokai_style = "atlantis"
					-- atlantis, default, andromeda, shusia, maia, espresso
				end
			},
			{'shaunsingh/nord.nvim'},
			{'EdenEast/nightfox.nvim'},
			{ 'sheerun/vim-polyglot',
				event = 'VimEnter'
			},
			{ 'norcalli/nvim-colorizer.lua' },
			{ 'KabbAmine/vCoolor.vim',
				event = 'VimEnter'
			},
			{ 'echasnovski/mini.starter',
				version = false, -- wait till new 0.7.0 release to put it back on semver
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
							new_section("Plugins",":edit ~/.config/nvim/lua/plugins_c.lua", "Config"),
							new_section("Lazy",         "Lazy",                 "Config"),
							new_section("Sessions",     ":Explore ~/.config/nvim/sessions/",    "Bookmarks"),
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
				-- Start mini.starter with a key combo
				vim.api.nvim_set_keymap('n','<leader>st', ':lua MiniStarter.open()<cr>', { noremap = true, silent = true })
			},
			{ "catppuccin/nvim", name = "catppuccin" },
			{ "metakirby5/codi.vim",
				init = function()
					vim.api.nvim_set_keymap('n', '<F7>', ':Codi!<cr>', {noremap = true, silent = true})
					vim.api.nvim_set_keymap('n', '<F8>', ':Codi<cr>', {noremap = true, silent = true})
					vim.api.nvim_set_keymap('n', '<F9>', ':CodiExpand<cr>', {noremap = true, silent = true})
				end
			},
			{'codota/tabnine-nvim', build = './dl_binaries.sh',
				init = function ()
					require('tabnine').setup({
							disable_auto_comment=true,
							-- accept_keymap="<Tab>",
							dismiss_keymap = "<C-]>",
							debounce_ms = 800,
							suggestion_color = {gui = "#808080", cterm = 244},
							execlude_filetypes = {"TelescopePrompt"}
						})
				end,
			},
			-- Install servers using CocInstall and this link: https://github.com/neoclide/coc.nvim/wiki/Language-servers
			-- List servers with :CoCList extensions
			{ 'neoclide/coc.nvim', branch = 'master', build = 'yarn install --frozen-lockfile',
				init = function ()
					-- Servers. Add more to auto-install more. :)
					vim.g.coc_global_extensions = {
						'coc-json',
						'coc-css',
						'coc-sumneko-lua',
						'coc-html',
						'coc-snippets',
						'coc-tsserver', -- use these instructions if Yarn is >= 2.0: https://github.com/neoclide/coc-tsserver#install
						'coc-html-css-support',
						'coc-snippets'
					}
					-- DEFAULT CONFIG. CHANGE AS YOU LIKE
					-- Some servers have issues with backup files, see #649
					vim.opt.backup = false
					vim.opt.writebackup = false

					-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
					-- delays and poor user experience
					vim.opt.updatetime = 300

					-- Always show the signcolumn, otherwise it would shift the text each time
					-- diagnostics appeared/became resolved
					vim.opt.signcolumn = "yes"

					local keyset = vim.keymap.set
					-- Autocomplete
					function _G.check_back_space()
						local col = vim.fn.col('.') - 1
						return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
					end
					-- Use Tab for trigger completion with characters ahead and navigate
					-- NOTE: There's always a completion item selected by default, you may want to enable
					-- no select by setting `"suggest.noselect": true` in your configuration file
					-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
					-- other plugins before putting this into your config
					local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

					-- Make SHIFT+<CR> to accept selected completion item or notify coc.nvim to format
					-- <C-g>u breaks current undo, please make your own choice
					keyset("i", "<S-cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

					-- Use <c-j> to trigger snippets
					keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
					-- Use <c-space> to trigger completion
					keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

					-- Use `[g` and `]g` to navigate diagnostics
					-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
					keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
					keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

					-- GoTo code navigation
					keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
					keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
					keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
					keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


					-- Use K to show documentation in preview window
					function _G.show_docs()
						local cw = vim.fn.expand('<cword>')
						if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
							vim.api.nvim_command('h ' .. cw)
						elseif vim.api.nvim_eval('coc#rpc#ready()') then
							vim.fn.CocActionAsync('doHover')
						else
							vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
						end
					end
					keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


					-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
					vim.api.nvim_create_augroup("CocGroup", {})
					vim.api.nvim_create_autocmd("CursorHold", {
							group = "CocGroup",
							command = "silent call CocActionAsync('highlight')",
							desc = "Highlight symbol under cursor on CursorHold"
						})


					-- Symbol renaming
					keyset("n", "<leader>r", "<Plug>(coc-rename)", {silent = true})


					-- Formatting selected code
					keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
					keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


					-- Setup formatexpr specified filetype(s)
					vim.api.nvim_create_autocmd("FileType", {
							group = "CocGroup",
							pattern = "typescript,json",
							command = "setl formatexpr=CocAction('formatSelected')",
							desc = "Setup formatexpr specified filetype(s)."
						})

					-- Update signature help on jump placeholder
					vim.api.nvim_create_autocmd("User", {
							group = "CocGroup",
							pattern = "CocJumpPlaceholder",
							command = "call CocActionAsync('showSignatureHelp')",
							desc = "Update signature help on jump placeholder"
						})

					-- Apply codeAction to the selected region
					-- Example: `<leader>aap` for current paragraph
					local opts = {silent = true, nowait = true}
					keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
					keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

					-- Remap keys for apply code actions at the cursor position.
					keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
					-- Remap keys for apply code actions affect whole buffer.
					keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
					-- Remap keys for applying codeActions to the current buffer
					keyset("n", "<leader>ac", "<Plug>(coc-codeaction)", opts)
					-- Apply the most preferred quickfix action on the current line.
					keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

					-- Remap keys for apply refactor code actions.
					keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
					keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
					keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

					-- Run the Code Lens actions on the current line
					keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


					-- Map function and class text objects
					-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
					keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
					keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
					keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
					keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
					keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
					keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
					keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
					keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


					-- Remap <C-f> and <C-b> to scroll float windows/popups
					---@diagnostic disable-next-line: redefined-local
					local opts = {silent = true, nowait = true, expr = true}
					keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
					keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
					keyset("i", "<C-f>",
						'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
					keyset("i", "<C-b>",
						'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
					keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
					keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


					-- Use CTRL-S for selections ranges
					-- Requires 'textDocument/selectionRange' support of language server
					keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
					keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


					-- Add `:Format` command to format current buffer
					vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

					-- " Add `:Fold` command to fold current buffer
					vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

					-- Add `:OR` command for organize imports of the current buffer
					vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

					-- Add (Neo)Vim's native statusline support
					-- NOTE: Please see `:h coc-status` for integrations with external plugins that
					-- provide custom statusline: lightline.vim, vim-airline
					vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

					-- Mappings for CoCList
					-- code actions and coc stuff
					---@diagnostic disable-next-line: redefined-local
				end
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


	----------------------------------------------------------------
	-- Old config
	----------------------------------------------------------------
	-- { 'glepnir/lspsaga.nvim',
	-- 	init = function()
	-- 		local saga_ok, _ = pcall(require, 'lspsaga')
	-- 		if not saga_ok then
	-- 			vim.notify('lspsaga not found.', 'error')
	-- 			return
	-- 		end
	-- 		require('lspsaga').setup({
	-- 				lightbulb = {
	-- 					enable = false,
	-- 					enable_in_insert = false,
	-- 					sign = false,
	-- 					sign_priority = 40,
	-- 					virtual_text = false,
	-- 				},
	-- 				symbol_in_winbar = {
	-- 					enable = false,
	-- 					separator = " ",
	-- 					hide_keyword = true,
	-- 					show_file = false,
	-- 					folder_level = 2,
	-- 					respect_root = false,
	-- 					color_mode = false,
	-- 				},
	-- 			})

	-- 		function LspKeymaps()
	-- 			-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, {buffer=0})
	-- 			vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', { silent = true })
	-- 			vim.keymap.set('n', 'gd', '<cmd>Lspsaga peek_definition<CR>', { buffer = 0, silent = true })
	-- 			vim.keymap.set('n', '<leader>r', '<cmd>Lspsaga rename<CR>', { silent = true })
	-- 			vim.keymap.set('n', '<leader>d', '<cmd>Lspsaga show_line_diagnostics<CR>', { silent = true } )
	-- 			vim.keymap.set('n','<leader>o', '<cmd>LSoutlineToggle<CR>',{ silent = true })
	-- 			-- Show or hide diagnostic text
	-- 			vim.diagnostic.config({ virtual_text=false })
	-- 			-- capabilities=capabilities
	-- 		end
	-- 		LspKeymaps()
	-- 	end
	-- },
	-- { 'hrsh7th/nvim-cmp',
	-- 	dependencies = {
	-- 		'hrsh7th/cmp-nvim-lua',
	-- 		'hrsh7th/cmp-nvim-lsp',
	-- 		'hrsh7th/cmp-path',
	-- 		'hrsh7th/cmp-cmdline',
	-- 	}
	-- },
	-- { 'hrsh7th/vim-vsnip',
	-- event = 'VimEnter',
	-- dependencies = {
	-- 	'hrsh7th/cmp-vsnip',
	-- 	'hrsh7th/vim-vsnip-integ',
	-- 	'rafamadriz/friendly-snippets',
	-- }
	-- },
	-- { 'tzachar/cmp-tabnine',
	-- build = './install.sh',
	-- event = 'VimEnter'
	-- },
	-- { 'williamboman/mason.nvim',
	-- config = function ()
	-- 	require('mason').setup()
	-- end
	-- },
	-- { 'williamboman/mason-lspconfig.nvim',
	-- event = 'VimEnter',
	-- init = function()
	-- 	require("mason-lspconfig").setup({
	-- 		automatic_installation = true,
	-- 	})
	-- end
	-- 		},
	--{ 'neovim/nvim-lspconfig',
	--event = 'VimEnter',
	--dependencies = 'onsails/lspkind.nvim',
	--config = function ()
	--	-- Is there an lspconfig in the house?
	--	local lspconfig_ok, _ = pcall(require, 'lspconfig')
	--	if not lspconfig_ok then
	--		vim.notify('lspconfig not found.', 'error')
	--		return
	--	end



	--	local configs = require('lspconfig/configs')
	--	----------CONNECT TO SERVERS------------
	--	-- read more at :h vim.lsp.buf<TAB>
	--	-- Need more servers?
	--	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	--	----------------------------------------
	--	Servers = { 'tsserver',
	--	'sumneko_lua',
	--	'emmet_ls',
	--	'cssls',
	--}
	--for index, lsp in ipairs(Servers) do
	--	require('lspconfig')[lsp].setup{}
	--end

	--local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
	--capabilities.textDocument.completion.completionItem.snippetSupport = true

	---- function LspKeymaps()
	---- 	-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, {buffer=0})
	---- 	vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', { silent = true })
	---- 	vim.keymap.set('n', 'gd', '<cmd>Lspsaga peek_definition<CR>', { buffer = 0, silent = true })
	---- 	vim.keymap.set('n', '<leader>r', '<cmd>Lspsaga rename<CR>', { silent = true })
	---- 	vim.keymap.set('n', '<leader>d', '<cmd>Lspsaga show_line_diagnostics<CR>', { silent = true } )
	---- 	vim.keymap.set('n','<leader>o', '<cmd>LSoutlineToggle<CR>',{ silent = true })
	---- 	-- Show or hide diagnostic text
	---- 	vim.diagnostic.config({ virtual_text=false })
	---- 	capabilities=capabilities
	---- end


	-------------JSON-----------
	-------------EMMET-----------
	--require('lspconfig').emmet_ls.setup {
	--	on_attach = function()
	--		print('emmet_ls attached')
	--	end,
	--	filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'jst'},
	--}

	-------------CSSLS-----------
	--require'lspconfig'.cssls.setup {
	--	on_attach = function ()
	--		capabilities.textDocument.completion.completionItem.snippetSupport = true
	--		LspKeymaps()
	--		vim.keymap.set('n', '<C-k>', vim.lsp.buf.references, { buffer = 0 })
	--		print ('cssls attached!')
	--	end,
	--}

	-------------SUMNEKO-LUA-----------
	--require ('lspconfig').sumneko_lua.setup {
	--	on_attach = function()
	--		LspKeymaps()
	--		print('sumneko_lua attached')
	--	end,
	--	settings = {
	--		Lua = {
	--			runtime = {
	--				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
	--				version = 'LuaJIT',
	--			},
	--			diagnostics = {
	--				-- Get the language server to recognize the `vim` global
	--				globals = { 'vim' },
	--			},
	--			workspace = {
	--				library = vim.api.nvim_get_runtime_file('', true),
	--				checkThirdParty = false,
	--			},
	--			telemetry = { enable = false },
	--		},
	--	}
	--}


	----------------TSSERVER--------------
	--require('lspconfig').tsserver.setup{
	--	on_attach = function ()
	--		LspKeymaps()
	--		print('tsserver attached')
	--	end
	--}


	----------------TABNINE---------------
	--local tabnine = require('cmp_tabnine.config')

	--tabnine:setup({
	--	max_lines = 1000,
	--	max_num_results = 3,
	--	sort = true,
	--	run_on_every_keystroke = true,
	--	snippet_placeholder = '...',
	--	ignored_file_types = {
	--		-- default is not to ignore
	--		-- uncomment to ignore in lua:
	--		-- lua = true
	--	},
	--	show_prediction_strength = false
	--})
	----------------NVIM-CMP--------------
	---- Setup nvim-cmp.
	--vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
	--local cmp = require'cmp'
	--local lspkind = require('lspkind')
	--cmp.setup({
	--	formatting = {
	--		format = lspkind.cmp_format ({
	--			mode = 'symbol',
	--			maxwidth = 50,
	--			ellipsis_char = '...'
	--		})
	--	},
	--	snippet = {
	--		expand = function(args)
	--			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
	--			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
	--			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
	--			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
	--		end,
	--	},
	--	window = {
	--		completion = cmp.config.window.bordered(),
	--		document
	--	},
	--	mapping = cmp.mapping.preset.insert({
	--		['<C-b>'] = cmp.mapping.scroll_docs(-4),
	--		['<C-f>'] = cmp.mapping.scroll_docs(4),
	--		['<C-Space>'] = cmp.mapping.complete(),
	--		['<C-e>'] = cmp.mapping.abort(),
	--		['<Tab>'] = cmp.mapping.confirm({
	--			select = true,
	--			behavior = cmp.ConfirmBehavior.Insert,
	--		}),
	--	}),
	--	sources = cmp.config.sources({
	--		{ name = 'nvim_lsp', keyword_length=1 },
	--		{ name = 'emmet_ls', keyword_length=1 },
	--		{ name = 'vsnip', keyword_length=3 }, -- vsnip, ultisnips, snippy, luasnip 
	--		{ name = 'cmp_tabnine', keyword_length=3 },
	--		{ name = 'nvim_lua', keyword_length=3 },
	--		{ name = 'path', keyword_length=3 },
	--		-- { name = 'buffer', keyword_length=3 },
	--	}),
	--	view = {
	--		entries = "native"
	--	},
	--	experimental = {
	--		ghost_text = false,
	--	}
	--})
	--end
	--},

