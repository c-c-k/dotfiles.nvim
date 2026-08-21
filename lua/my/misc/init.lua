---@class MyMisc
local M = {}
M.init = { no_init = true, recurse = false } ---@type MyModuleInit

M.keymaps = {}

M.keymaps.key_prog_i_ = { ---@type MyKeymapKeymapSpec
  desc = "Key Prog",
  rhs = "<ESC>K",
}
M.keymaps.key_prog_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Key Prog",
  rhs = "K",
}

return M
