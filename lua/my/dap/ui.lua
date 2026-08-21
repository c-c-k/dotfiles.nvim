---@class MyDapUi
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_dap_ui
end

M._spec_dap_ui = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["nvim-dap-ui"],
    lazy = true,
    config = function(_, opts)
      require("dap-ui").setup(opts)

      my.keymap.queue_km_group_load(my.config.keymaps.g_dap_ui__)
    end,
    dependencies = { make_lzspec { source = plugins["nvim-dap"], optional = false } },
  }
  return spec
end

M.keymaps = {}

M.keymaps.debugger_hover = { ---@type MyKeymapKeymapSpec
  desc = "Debugger Hover",
  rhs = function() require("dap.ui.widgets").hover() end,
}
M.keymaps.evaluate_input_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Evaluate Input",
  rhs = function()
    vim.ui.input({ prompt = "Expression: " }, function(expr)
      if expr then require("dapui").eval(expr, { enter = true }) end
    end)
  end,
}
M.keymaps.evaluate_input_x_ = { ---@type MyKeymapKeymapSpec
  desc = "Evaluate Input",
  rhs = function() require("dapui").eval() end,
}
M.keymaps.toggle_debugger_ui = { ---@type MyKeymapKeymapSpec
  desc = "Toggle Debugger UI",
  rhs = function() require("dapui").toggle() end,
}

return M
