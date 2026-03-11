---@class my.ws: my.ws._submodules
local M = {}

M.keymaps = {}

M.keymaps.exit_with_confirm = { ---@type my.keymap.keymap_spec
  desc = "Exit with confirm",
  rhs = "<CMD>confirm qall<CR>",
}
M.keymaps.write_all = { ---@type my.keymap.keymap_spec
  desc = "Write all",
  rhs = "<CMD>confirm wall<CR>",
}

return M
