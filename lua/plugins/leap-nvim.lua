---@type LazyPluginSpec
local spec_leap_nvim = {
  "ggandor/leap.nvim",
  dependencies = {
    "tpope/vim-repeat",
  },
  opts = {
    safe_labels = "",
    labels = [==[sfnjklhodweimbuyvrgtaqpcxz;'/[]SFNJKLHODWEIMBUYVRGTAQPCXZ:"?{}]==],
    keys = {
      next_target = "<enter>",
      prev_target = "<backspace>",
      next_group = "<space>",
      prev_group = "<backspace>",
    },
  },
}

---@type LazyPluginSpec
local spec_leap_nvim__astrocore = {
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
    local maps, map = require("cck.core.keymaps").get_astrocore_mapper()

    map({ "n", "x", "o" }, "<LEADER>ss", "<Plug>(leap)", { desc = "Leap bi-directional" })
    map({ "n", "x", "o" }, "<LEADER>sf", "<Plug>(leap-forward)", { desc = "Leap forward" })
    map({ "n", "x", "o" }, "<LEADER>sF", "<Plug>(leap-forward-till)", { desc = "Leap forward" })
    map({ "n", "x", "o" }, "<LEADER>sb", "<Plug>(leap-backward)", { desc = "Leap backward" })
    map({ "n", "x", "o" }, "<LEADER>sB", "<Plug>(leap-backward-till)", { desc = "Leap backward" })
    map("n", "<LEADER>sw", "<Plug>(leap-from-window)", { desc = "Leap from window" })
    map("n", "<LEADER>sS", "<Plug>(leap-anywhere)", { desc = "Leap from window" })
    map("n", "<LEADER>sr", function() require("leap.remote").action() end, { desc = "Leap remote action" })

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
    opts.autocmds = astrocore.extend_tbl(opts.autocmds, autocmds)
  end,
}

spec_leap_nvim.specs = {
  spec_leap_nvim__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_leap_nvim,
}
