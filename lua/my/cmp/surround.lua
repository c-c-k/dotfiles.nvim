local my = require "my"
---@class my.cmp.surround
local M = {}

M.opts = {}
M.opts.general = function(_, opts) ---@cast opts MyNoOptsSpec
  return my.tbl.merge_dicts_into_last(opts, {
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
  } --[[@as MyNoOptsSpec]])
end
M.opts.core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_surround)
end

M.keymaps = {}

M.keymaps.add_around_line = { ---@type my.keymap.keymap_spec
  desc = "Surround (line)",
  rhs = "<Plug>(nvim-surround-normal-cur)",
}
M.keymaps.add_around_line_with_nl = { ---@type my.keymap.keymap_spec
  desc = "Surround (line Add NL)",
  rhs = "<Plug>(nvim-surround-normal-cur-line)",
}
M.keymaps.add_i_ = { ---@type my.keymap.keymap_spec
  desc = "Surround",
  rhs = "<Plug>(nvim-surround-insert)",
}
M.keymaps.add_n_ = { ---@type my.keymap.keymap_spec
  desc = "Surround",
  rhs = "<Plug>(nvim-surround-normal)",
}
M.keymaps.add_with_nl = { ---@type my.keymap.keymap_spec
  desc = "Surround (Add NL)",
  rhs = "<Plug>(nvim-surround-normal-line)",
}
M.keymaps.add_with_nl_i_ = { ---@type my.keymap.keymap_spec
  desc = "Surround (Add NL)",
  rhs = "<Plug>(nvim-surround-insert-line)",
}
M.keymaps.add_with_nl_x_ = { ---@type my.keymap.keymap_spec
  desc = "Surround (Add NL)",
  rhs = "<Plug>(nvim-surround-visual-line)",
}
M.keymaps.add_x_ = { ---@type my.keymap.keymap_spec
  desc = "Surround",
  rhs = "<Plug>(nvim-surround-visual)",
}
M.keymaps.change = { ---@type my.keymap.keymap_spec
  desc = "Surround (change)",
  rhs = "<Plug>(nvim-surround-change)",
}
M.keymaps.change_line = { ---@type my.keymap.keymap_spec
  desc = "Surround (change-line)",
  rhs = "<Plug>(nvim-surround-change-line)",
}
M.keymaps.delete = { ---@type my.keymap.keymap_spec
  desc = "Surround (delete)",
  rhs = "<Plug>(nvim-surround-delete)",
}

return M
