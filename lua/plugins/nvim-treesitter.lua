-- ===============
-- NVIM TREESITTER
-- ===============

-- repo url: <https://github.com/nvim-treesitter/nvim-treesitter>
-- nvim help: `:help nvim-treesitter`

return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-k>", -- normal mode
        node_incremental = "<C-k>", -- visual mode
        scope_incremental = "<C-l>", -- visual mode
        node_decremental = "<C-j>", -- visual mode
      },
    },
  },
}
