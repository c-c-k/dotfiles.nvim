local my = require "my"
---@class my.dap.view
local M = {}

M.opts = {}

M.opts.core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_dap_view)
end

M.opts.dap_integration = function()
  local dap, dap_view = require "dap", require "dap-view"
  dap.listeners.after.event_initialized.dapview_config = function() dap_view.open() end
  -- dap.listeners.before.event_terminated.dapview_config = function() dap_view.close() end
  -- dap.listeners.before.event_exited.dapview_config = function() dap_view.close() end
end

M.keymaps = {}

M.keymaps.add_expression = { ---@type my.keymap.keymap_spec
  desc = "Add expression",
  rhs = function() require("dap-view").add_expr() end,
}
M.keymaps.toggle_debugger_view = { ---@type my.keymap.keymap_spec
  desc = "Toggle Debugger view",
  rhs = function() require("dap-view").toggle() end,
}

return M
