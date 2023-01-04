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
      -- search_dirs = {'D:/'}
    },
  }
}


---- TELESCOPE MAPPINGS
vim.api.nvim_set_keymap('n','<leader>ff',':Telescope find_files<cr>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<leader>fg',':Telescope live_grep<cr>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<leader>bb',':Telescope buffers<cr>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<leader>h',':Telescope help_tags<cr>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<leader>km', ':Telescope keymaps<cr>', { noremap = true, silent = true })

return M
