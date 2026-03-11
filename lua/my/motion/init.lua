---@class my.motion: my.motion._submodules
local M = {}

M.keymaps = {}

M.keymaps.down_in_wrap = { ---@type my.keymap.keymap_spec
  desc = "Down (in wrap)",
  rhs = "gj",
}
M.keymaps.go_to_start_of_buffer = { ---@type my.keymap.keymap_spec
  desc = "go to start of buffer",
  rhs = "gg0",
}
M.keymaps.goto_mark_char = { ---@type my.keymap.keymap_spec
  desc = "Go to mark (char)",
  rhs = "`",
}
M.keymaps.goto_mark_row = { ---@type my.keymap.keymap_spec
  desc = "Go to mark (row)",
  rhs = "'",
}
M.keymaps.head_line_i_ = { ---@type my.keymap.keymap_spec
  desc = "Head Line",
  rhs = "<C-O>H",
}
M.keymaps.head_line_n_ = { ---@type my.keymap.keymap_spec
  desc = "Head Line",
  rhs = "H",
}
M.keymaps.last_line_i_ = { ---@type my.keymap.keymap_spec
  desc = "Last Line",
  rhs = "<C-O>L",
}
M.keymaps.last_line_n_ = { ---@type my.keymap.keymap_spec
  desc = "Last Line",
  rhs = "L",
}
M.keymaps.left = { ---@type my.keymap.keymap_spec
  desc = "Left",
  rhs = "h",
}
M.keymaps.right = { ---@type my.keymap.keymap_spec
  desc = "Right",
  rhs = "l",
}
M.keymaps.text_object_all_buffer_o_ = { ---@type my.keymap.keymap_spec
  desc = "All buffer",
  rhs = ":normal val<CR>",
}
M.keymaps.text_object_all_buffer_x_ = { ---@type my.keymap.keymap_spec
  desc = "All buffer",
  rhs = "gg0oG$",
}
M.keymaps.text_object_inner_line_o_ = { ---@type my.keymap.keymap_spec
  desc = "inner line",
  rhs = ":normal vil<CR>",
}
M.keymaps.text_object_inner_line_x_ = { ---@type my.keymap.keymap_spec
  desc = "inner line",
  rhs = "^og_",
}
M.keymaps.up_in_wrap = { ---@type my.keymap.keymap_spec
  desc = "Up (in wrap)",
  rhs = "gk",
}

return M
