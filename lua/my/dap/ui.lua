local my = require "my"
---@class my.dap.ui
local M = {}

M.opts = {}

M.opts.core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_dap_ui__)
end

M.keymaps = {}

M.keymaps.debugger_hover = { ---@type my.keymap.keymap_spec
  desc = "Debugger Hover",
  rhs = function() require("dap.ui.widgets").hover() end,
}
M.keymaps.evaluate_input_n_ = { ---@type my.keymap.keymap_spec
  desc = "Evaluate Input",
  rhs = function()
    vim.ui.input({ prompt = "Expression: " }, function(expr)
      if expr then require("dapui").eval(expr, { enter = true }) end
    end)
  end,
}
M.keymaps.evaluate_input_x_ = { ---@type my.keymap.keymap_spec
  desc = "Evaluate Input",
  rhs = function() require("dapui").eval() end,
}
M.keymaps.toggle_debugger_ui = { ---@type my.keymap.keymap_spec
  desc = "Toggle Debugger UI",
  rhs = function() require("dapui").toggle() end,
}

return M
