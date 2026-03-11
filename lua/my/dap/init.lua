local my = require "my"
---@class my.dap: my.dap._submodules
local M = {}

M.opts = {}

M.opts.core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_dap_____)
end

M.keymaps = {}

M.keymaps.clear_breakpoints = { ---@type my.keymap.keymap_spec
  desc = "Clear Breakpoints",
  rhs = function() require("dap").clear_breakpoints() end,
}
M.keymaps.close_session = { ---@type my.keymap.keymap_spec
  desc = "Close Session",
  rhs = function() require("dap").close() end,
}
M.keymaps.conditional_breakpoint = { ---@type my.keymap.keymap_spec
  desc = "Conditional Breakpoint (S-F9)",
  rhs = function()
    vim.ui.input({ prompt = "Condition: " }, function(condition)
      if condition then require("dap").set_breakpoint(condition) end
    end)
  end,
}
M.keymaps.pause = { ---@type my.keymap.keymap_spec
  desc = "Pause (F6)",
  rhs = function() require("dap").pause() end,
}
M.keymaps.restart = { ---@type my.keymap.keymap_spec
  desc = "Restart (C-F5)",
  rhs = function() require("dap").restart_frame() end,
}
M.keymaps.run_to_cursor = { ---@type my.keymap.keymap_spec
  desc = "Run To Cursor",
  rhs = function() require("dap").run_to_cursor() end,
}
M.keymaps.start_or_continue = { ---@type my.keymap.keymap_spec
  desc = "Start/Continue (F5)",
  rhs = function() require("dap").continue() end,
}
M.keymaps.step_into = { ---@type my.keymap.keymap_spec
  desc = "Step Into (F11)",
  rhs = function() require("dap").step_into() end,
}
M.keymaps.step_out = { ---@type my.keymap.keymap_spec
  desc = "Step Out (S-F11)",
  rhs = function() require("dap").step_out() end,
}
M.keymaps.step_over = { ---@type my.keymap.keymap_spec
  desc = "Step Over (F10)",
  rhs = function() require("dap").step_over() end,
}
M.keymaps.terminate_session = { ---@type my.keymap.keymap_spec
  desc = "Terminate Session (S-F5)",
  rhs = function() require("dap").step_over() end,
}
M.keymaps.toggle_breakpoint = { ---@type my.keymap.keymap_spec
  desc = "Toggle Breakpoint (F9)",
  rhs = function() require("dap").toggle_breakpoint() end,
}
M.keymaps.toggle_repl = { ---@type my.keymap.keymap_spec
  desc = "Toggle REPL",
  rhs = function() require("dap").repl.toggle() end,
}

return M
