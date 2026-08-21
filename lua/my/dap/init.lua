---@class MyDap
---@field ui MyDapUi
---@field view MyDapView
local M = {}
M.init = { no_init = false, recurse = true } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_dap
end

M._spec_dap = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["nvim-dap"],
    lazy = true,
    config = function(_, opts)
      local dap = require "dap"

      my.tbl.merge("dDkL", dap.adapters, opts.adapters)
      my.tbl.merge("dDkL", dap.configurations, opts.configurations)

      my.keymap.queue_km_group_load(my.config.keymaps.g_dap_____)
    end,
  }
  return spec
end

M.keymaps = {}

M.keymaps.clear_breakpoints = { ---@type MyKeymapKeymapSpec
  desc = "Clear Breakpoints",
  rhs = function() require("dap").clear_breakpoints() end,
}
M.keymaps.close_session = { ---@type MyKeymapKeymapSpec
  desc = "Close Session",
  rhs = function() require("dap").close() end,
}
M.keymaps.conditional_breakpoint = { ---@type MyKeymapKeymapSpec
  desc = "Conditional Breakpoint (S-F9)",
  rhs = function()
    vim.ui.input({ prompt = "Condition: " }, function(condition)
      if condition then require("dap").set_breakpoint(condition) end
    end)
  end,
}
M.keymaps.pause = { ---@type MyKeymapKeymapSpec
  desc = "Pause (F6)",
  rhs = function() require("dap").pause() end,
}
M.keymaps.restart = { ---@type MyKeymapKeymapSpec
  desc = "Restart (C-F5)",
  rhs = function() require("dap").restart_frame() end,
}
M.keymaps.run_to_cursor = { ---@type MyKeymapKeymapSpec
  desc = "Run To Cursor",
  rhs = function() require("dap").run_to_cursor() end,
}
M.keymaps.start_or_continue = { ---@type MyKeymapKeymapSpec
  desc = "Start/Continue (F5)",
  rhs = function() require("dap").continue() end,
}
M.keymaps.step_into = { ---@type MyKeymapKeymapSpec
  desc = "Step Into (F11)",
  rhs = function() require("dap").step_into() end,
}
M.keymaps.step_out = { ---@type MyKeymapKeymapSpec
  desc = "Step Out (S-F11)",
  rhs = function() require("dap").step_out() end,
}
M.keymaps.step_over = { ---@type MyKeymapKeymapSpec
  desc = "Step Over (F10)",
  rhs = function() require("dap").step_over() end,
}
M.keymaps.terminate_session = { ---@type MyKeymapKeymapSpec
  desc = "Terminate Session (S-F5)",
  rhs = function() require("dap").step_over() end,
}
M.keymaps.toggle_breakpoint = { ---@type MyKeymapKeymapSpec
  desc = "Toggle Breakpoint (F9)",
  rhs = function() require("dap").toggle_breakpoint() end,
}
M.keymaps.toggle_repl = { ---@type MyKeymapKeymapSpec
  desc = "Toggle REPL",
  rhs = function() require("dap").repl.toggle() end,
}

return M
