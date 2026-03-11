local my = require "my"
---@class my.ui.aerial
local M = {}

M.opts = {}

M.opts.core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_aerial__)
end

M.keymaps = {}

M.keymaps.symbols_outline = { ---@type my.keymap.keymap_spec
  desc = "Symbols outline",
  rhs = function() require("aerial").toggle() end,
}

return M
