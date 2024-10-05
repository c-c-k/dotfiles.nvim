-- =============
-- NVIM-SURROUND
-- =============

-- repo url: <https://github.com/kylechui/nvim-surround>
-- nvim help: `:help nvim-surround.txt`

return {
  "kylechui/nvim-surround",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local astrocore = require "astrocore"
        local maps, map = require("cck.utils.config").get_astrocore_mapper()

        map("i", "<C-S>s", "<Plug>(nvim-surround-insert)", { desc = "Surround (insert)" })
        map("i", "<C-S>l", "<Plug>(nvim-surround-insert-line)", { desc = "Surround (insert-line)" })
        map("n", "<LEADER>sa", "<Plug>(nvim-surround-normal)", { desc = "Surround (motion)" })
        map("n", "<LEADER>sA", "<Plug>(nvim-surround-normal-line)", { desc = "Surround (motion-line-above,below)" })
        map("n", "<LEADER>sl", "<Plug>(nvim-surround-normal-cur)", { desc = "Surround (cur-line-start,end)" })
        map("n", "<LEADER>sL", "<Plug>(nvim-surround-normal-cur-line)", { desc = "Surround (cur-line-above,below)" })
        map("x", "<LEADER>sa", "<Plug>(nvim-surround-visual)", { desc = "Surround (visual)" })
        map("x", "<LEADER>sl", "<Plug>(nvim-surround-visual-line)", { desc = "Surround (visual-line)" })
        map({ "n", "x" }, "<LEADER>sd", "<Plug>(nvim-surround-delete)", { desc = "Surround (delete)" })
        map({ "n", "x" }, "<LEADER>sc", "<Plug>(nvim-surround-change)", { desc = "Surround (change)" })
        map({ "n", "x" }, "<LEADER>sC", "<Plug>(nvim-surround-change-line)", { desc = "Surround (change-line)" })

        opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
      end,
    },
  },
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  opts = {
    keymaps = {
      insert = false, -- "<C-g>s"
      insert_line = false, -- "<C-g>S"
      normal = false, -- "ys"
      normal_cur = false, -- "yss"
      normal_line = false, -- "yS"
      normal_cur_line = false, -- "ySS"
      visual = false, -- "S"
      visual_line = false, -- "gS"
      delete = false, -- "ds"
      change = false, -- "cs"
      change_line = false, -- "cS"
    },
  },
}
