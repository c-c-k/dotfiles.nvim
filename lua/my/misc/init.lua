---@class my.misc
local M = {}

M.keymaps = {}

M.keymaps.key_prog_i_ = { ---@type my.keymap.keymap_spec
  desc = "Key Prog",
  rhs = "<ESC>K",
}
M.keymaps.key_prog_n_ = { ---@type my.keymap.keymap_spec
  desc = "Key Prog",
  rhs = "K",
}

return M
