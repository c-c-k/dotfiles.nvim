-- =========
-- LEAP.NVIM
-- =========

-- repo url: <https://github.com/ggandor/leap.nvim>
-- nvim help: `:help leat.txt`

return {
  "ggandor/leap.nvim",
  dependencies = {
    "tpope/vim-repeat",
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local autocmds = {
          -- leap_cursor = { -- https://github.com/ggandor/leap.nvim/issues/70#issuecomment-1521177534
          --   {
          --     event = "User",
          --     pattern = "LeapEnter",
          --     callback = function()
          --       vim.cmd.hi("Cursor", "blend=100")
          --       vim.opt.guicursor:append { "a:Cursor/lCursor" }
          --     end,
          --   },
          --   {
          --     event = "User",
          --     pattern = "LeapLeave",
          --     callback = function()
          --       vim.cmd.hi("Cursor", "blend=0")
          --       vim.opt.guicursor:remove { "a:Cursor/lCursor" }
          --     end,
          --   },
          -- },
        }

        local astrocore = require "astrocore"
        local maps, map = require("cck.utils.config").get_astrocore_mapper()

        map({ "n", "x" }, "<LEADER>ss", "<Plug>(leap)", { desc = "Leap bi-directional" })
        map({ "n", "x" }, "<LEADER>sf", "<Plug>(leap-forward)", { desc = "Leap forward" })
        map({ "n", "x" }, "<LEADER>sb", "<Plug>(leap-backward)", { desc = "Leap backward" })
        map("n", "<LEADER>sw", "<Plug>(leap-from-window)", { desc = "Leap from window" })
        map("n", "<LEADER>sr", function() require("leap.remote").action() end, { desc = "Leap remote action" })

        opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
        opts.autocmds = astrocore.extend_tbl(opts.autocmds, autocmds)
      end,
    },
  },
  opts = {},
}
