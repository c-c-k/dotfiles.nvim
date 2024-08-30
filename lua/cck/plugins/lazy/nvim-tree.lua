-- =========
-- NVIM-TREE
-- =========

-- repo url: <https://github.com/nvim-tree/nvim-tree.lua>
-- nvim help: `:help nvim-tree`

return {
  'nvim-tree/nvim-tree.lua',
  -- == PLUGIN DISABLED ==
  -- MEMO: This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one and requires a manual inspection to check that it has been converted correctly.
  -- Nvim-tree is a potential alternative for mini.files, for the moment mini.files seems sufficient so nvim-tree is disabled.
  enabled = false,
  opts = {
    -- alignment placeholder
  },
  config = function(_, opts)      
    -- MEMO: When enabling/disabling nvim-tree also disable/enable netrw in globals.lua
    
    local function my_on_attach(bufnr)
      local api = require "nvim-tree.api"
    
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
    
      -- default mappings
      api.config.mappings.default_on_attach(bufnr)
    
      -- custom mappings
      vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
      vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
    end
    
    require("nvim-tree").setup({
      on_attach = my_on_attach,
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })
  end,
}
