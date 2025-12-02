local my = require "my"

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
      next_target = { "<TAB>", "<ENTER>" },
      prev_target = "<S-TAB>",
      next_group = "<SPACE>",
      prev_group = "BACKSPACE",
    },
  },
}

---@type LazyPluginSpec
local spec_leap_nvim__astrocore = {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local maps, map = my.keymap.get_astrocore_mapper()

    -- -- https://github.com/ggandor/leap.nvim/issues/70#issuecomment-1521177534
    -- local aug_my_leap_cursor_fix = mycore.get_augroup {
    --   name = "aug_my_leap_cursor_fix",
    --   clear = true,
    -- }
    -- mycore.add_autocmd {
    --   group = aug_my_leap_cursor_fix,
    --   event = "User",
    --   pattern = "LeapEnter",
    --   callback = function()
    --     vim.cmd.hi("Cursor", "blend=100")
    --     vim.opt.guicursor:append { "a:Cursor/lCursor" }
    --   end,
    -- }
    -- mycore.add_autocmd {
    --   group = aug_my_leap_cursor_fix,
    --   event = "User",
    --   pattern = "LeapLeave",
    --   callback = function()
    --     vim.cmd.hi("Cursor", "blend=0")
    --     vim.opt.guicursor:remove { "a:Cursor/lCursor" }
    --   end,
    -- }

    map({ "n", "x", "o" }, "<A-s>s", "<Plug>(leap)", { desc = "Leap in window" })
    map({ "n", "x", "o" }, "<A-s>f", "<Plug>(leap-forward)", { desc = "Leap forward" })
    map({ "n", "x", "o" }, "<A-s>t", "<Plug>(leap-forward-till)", { desc = "Leap forward till" })
    map({ "n", "x", "o" }, "<A-s>F", "<Plug>(leap-backward)", { desc = "Leap backward" })
    map({ "n", "x", "o" }, "<A-s>T", "<Plug>(leap-backward-till)", { desc = "Leap backward till" })
    map({ "t", "i" }, "<A-s>s", "<C-\\><C-N><Plug>(leap)", { copy = { "n", "<A-s>s" } })
    map({ "t", "i" }, "<A-s>f", "<C-\\><C-N><Plug>(leap-forward)", { copy = { "n", "<A-s>f" } })
    map({ "t", "i" }, "<A-s>t", "<C-\\><C-N><Plug>(leap-forward-till)", { copy = { "n", "<A-s>t" } })
    map({ "t", "i" }, "<A-s>F", "<C-\\><C-N><Plug>(leap-backward)", { copy = { "n", "<A-s>F" } })
    map({ "t", "i" }, "<A-s>T", "<C-\\><C-N><Plug>(leap-backward-till)", { copy = { "n", "<A-s>T" } })
    map({ "n", "x", "o", "t", "i" }, "<A-s>w", "<C-\\><C-N><Plug>(leap-from-window)", { desc = "Leap from window" })
    map({ "n", "x", "o", "t", "i" }, "<A-s>o", "<C-\\><C-N><Plug>(leap-anywhere)", { desc = "Leap omniwhere" })
    map({ "n", "x", "o", "t", "i" }, "<A-s>r", function()
      vim.api.nvim_input "<C-\\><C-N>"
      require("leap.remote").action()
    end, { desc = "Leap remote action" })

    opts.mappings = my.tbl.merge("dDFn", opts.mappings, maps)
  end,
}

spec_leap_nvim.specs = {
  spec_leap_nvim__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_leap_nvim,
}
