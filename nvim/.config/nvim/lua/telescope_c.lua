-- local ok, _ = pcall(require'telescope')
-- if not ok then return end

local M = {}

require('telescope').setup {
  extensions = {
    file_browser = {
      -- hijack_netrw = true,
    }
  },
  defaults = {
    file_ignore_patterns = {'%.git', '%.npm', '%node_modules'}
  },
  pickers = {
    find_files = {
      hidden = true
      -- find_command = {'fzf'},
      -- search_dirs = {'D:/'}
    },
  }
}

require('telescope').load_extension 'file_browser'


---- TELESCOPE MAPPINGS
vim.api.nvim_set_keymap('n','<leader>ff',':Telescope find_files<cr>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<leader>fg',':Telescope live_grep<cr>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<leader>bb',':Telescope buffers<cr>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<leader>h',':Telescope help_tags<cr>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<leader>fb',':Telescope file_browser<cr>',{ noremap = true, silent = true })

return M
