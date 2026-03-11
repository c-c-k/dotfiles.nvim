local my = require "my"
---@class my.ft.manpage
local M = {}

M.a0_init = function()
  -- placeholder for extra manpage filetype configuration.
end

M.keymaps = {}

M.keymaps.manpages = { ---@type my.keymap.keymap_spec
  desc = "Open manpages",
  rhs = function() my.win.open_util_in_current_win { init = ":Man man", ft = "man", prompt_cmd = ":Man " } end,
}

return M
