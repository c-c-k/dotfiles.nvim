---@class MyDapView
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_dap_view
end

M._spec_dap_view = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["nvim-dap-view"],
    config = function(_, opts)
      local dap, dap_view = require "dap", require "dap-view"

      require("dap-view").setup(opts)

      dap.listeners.after.event_initialized.dapview_config = function() dap_view.open() end
      -- dap.listeners.before.event_terminated.dapview_config = function() dap_view.close() end
      -- dap.listeners.before.event_exited.dapview_config = function() dap_view.close() end

      my.keymap.queue_km_group_load(my.config.keymaps.g_dap_view)
    end,
    dependencies = { make_lzspec { source = plugins["nvim-dap"], optional = false } },
  }
  return spec
end

M.keymaps = {}

M.keymaps.add_expression = { ---@type MyKeymapKeymapSpec
  desc = "Add expression",
  rhs = function() require("dap-view").add_expr() end,
}
M.keymaps.toggle_debugger_view = { ---@type MyKeymapKeymapSpec
  desc = "Toggle Debugger view",
  rhs = function() require("dap-view").toggle() end,
}

return M
