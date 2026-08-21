---@class MyFtManpage
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.filetypes = function()
  -- placeholder for extra manpage filetype configuration.
end

M.keymaps = {}

M.keymaps.manpages = { ---@type MyKeymapKeymapSpec
  desc = "Open manpages",
  rhs = function() my.win.open_util_in_current_win { init = ":Man man", ft = "man", prompt_cmd = ":Man " } end,
}

return M
