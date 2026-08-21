---@class MyMotion
---@field leap MyMotionLeap
local M = {}
M.init = { no_init = true, recurse = true } ---@type MyModuleInit

M.keymaps = {}

M.keymaps.down_in_wrap = { ---@type MyKeymapKeymapSpec
  desc = "Down (in wrap)",
  rhs = "gj",
}
M.keymaps.go_to_start_of_buffer = { ---@type MyKeymapKeymapSpec
  desc = "go to start of buffer",
  rhs = "gg0",
}
M.keymaps.goto_mark_char = { ---@type MyKeymapKeymapSpec
  desc = "Go to mark (char)",
  rhs = "`",
}
M.keymaps.goto_mark_row = { ---@type MyKeymapKeymapSpec
  desc = "Go to mark (row)",
  rhs = "'",
}
M.keymaps.head_line_i_ = { ---@type MyKeymapKeymapSpec
  desc = "Head Line",
  rhs = "<C-O>H",
}
M.keymaps.head_line_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Head Line",
  rhs = "H",
}
M.keymaps.last_line_i_ = { ---@type MyKeymapKeymapSpec
  desc = "Last Line",
  rhs = "<C-O>L",
}
M.keymaps.last_line_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Last Line",
  rhs = "L",
}
M.keymaps.left = { ---@type MyKeymapKeymapSpec
  desc = "Left",
  rhs = "h",
}
M.keymaps.right = { ---@type MyKeymapKeymapSpec
  desc = "Right",
  rhs = "l",
}
M.keymaps.text_object_all_buffer_o_ = { ---@type MyKeymapKeymapSpec
  desc = "All buffer",
  rhs = ":normal val<CR>",
}
M.keymaps.text_object_all_buffer_x_ = { ---@type MyKeymapKeymapSpec
  desc = "All buffer",
  rhs = "gg0oG$",
}
M.keymaps.text_object_inner_line_o_ = { ---@type MyKeymapKeymapSpec
  desc = "inner line",
  rhs = ":normal vil<CR>",
}
M.keymaps.text_object_inner_line_x_ = { ---@type MyKeymapKeymapSpec
  desc = "inner line",
  rhs = "^og_",
}
M.keymaps.up_in_wrap = { ---@type MyKeymapKeymapSpec
  desc = "Up (in wrap)",
  rhs = "gk",
}

return M
