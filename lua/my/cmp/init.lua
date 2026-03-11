---@class my.cmp: my.cmp._submodules
local M = {}

M.keymaps = {}
M.keymaps.add_blank_line_above = { ---@type my.keymap.keymap_spec
  desc = "Add Blank line above",
  rhs = "O<ESC>0D",
}
M.keymaps.add_blank_line_below = { ---@type my.keymap.keymap_spec
  desc = "Add Blank line below",
  rhs = "o<ESC>0D",
}
M.keymaps.cmd_history_next = { ---@type my.keymap.keymap_spec
  desc = "cmd history next",
  rhs = "<DOWN>",
}
M.keymaps.cmd_history_prev = { ---@type my.keymap.keymap_spec
  desc = "cmd history prev",
  rhs = "<UP>",
}
M.keymaps.insert_digraph = { ---@type my.keymap.keymap_spec
  desc = "Insert digraph",
  rhs = "<C-K>",
}
M.keymaps.join_lines_i_ = { ---@type my.keymap.keymap_spec
  desc = "Join Lines",
  rhs = "<C-O>J",
}
M.keymaps.join_lines_n_ = { ---@type my.keymap.keymap_spec
  desc = "Join Lines",
  rhs = "J",
}

return M
