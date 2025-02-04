---@type LazyPluginSpec
local spec_nvim_surround = {
  "kylechui/nvim-surround",
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

---@type LazyPluginSpec
local spec_nvim_surround__astrocore = {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local maps, map = require("cck.core.keymaps").get_astrocore_mapper()

    map("i", "<A-s>s", "<Plug>(nvim-surround-insert)", { desc = "Surround (insert)" })
    map("i", "<A-s>l", "<Plug>(nvim-surround-insert-line)", { desc = "Surround (insert-line)" })
    map("n", "<A-s>a", "<Plug>(nvim-surround-normal)", { desc = "Surround (motion)" })
    map("n", "<A-s>A", "<Plug>(nvim-surround-normal-line)", { desc = "Surround (motion-line-above,below)" })
    map("n", "<A-s>l", "<Plug>(nvim-surround-normal-cur)", { desc = "Surround (cur-line-start,end)" })
    map("n", "<A-s>L", "<Plug>(nvim-surround-normal-cur-line)", { desc = "Surround (cur-line-above,below)" })
    map("x", "<A-s>a", "<Plug>(nvim-surround-visual)", { desc = "Surround (visual)" })
    map("x", "<A-s>l", "<Plug>(nvim-surround-visual-line)", { desc = "Surround (visual-line)" })
    map({ "n", "x" }, "<A-s>d", "<Plug>(nvim-surround-delete)", { desc = "Surround (delete)" })
    map({ "n", "x" }, "<A-s>c", "<Plug>(nvim-surround-change)", { desc = "Surround (change)" })
    map({ "n", "x" }, "<A-s>C", "<Plug>(nvim-surround-change-line)", { desc = "Surround (change-line)" })

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

spec_nvim_surround.specs = {
  spec_nvim_surround__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_nvim_surround,
}
