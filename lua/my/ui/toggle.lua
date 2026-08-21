---@class MyUiToggle
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_snacks_toggle
end

M._spec_snacks_toggle = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["snacks-nvim"],
    opts = { ---@type snacks.Config
      toggle = {
        notify = M.notifications_is_enabled,
      },
    },
    dependencies = make_lzspec { source = plugins["which-key.nvim"], optional = false },
  }
  return spec
end

--- Check if buffer setting is enabled or missing.
---@param b_enabled boolean
---@return boolean
function M.is_enabled_buf_nil_is_true(b_enabled) --
  return b_enabled or b_enabled == nil
end

--- Check if buffer setting setting is enabled or fallback to the global setting.
---
--- NOTE: If a fallback to the global setting is not desired use `is_enabled_buf_nil_is_true` instead.
---
---@param b_enabled boolean?
---@param g_enabled boolean
---@return boolean
function M.is_enabled_buf_override_glob(b_enabled, g_enabled) --
  return b_enabled or (b_enabled == nil and g_enabled)
end

--- Check if both buffer and global setting is enabled.
---
--- NOTE: If the buffer value is `nil` only the global value is considered,
--- if this is not desired: perform an `and` check for the arguments passed to
--- the `b_enabled` and `g_enabled` parameters.
---
---@param b_enabled boolean?
---@param g_enabled boolean
---@return boolean
function M.is_enabled_buf_and_glob(b_enabled, g_enabled) --
  return g_enabled and (b_enabled or b_enabled == nil)
end
function M.notifications_is_enabled() --
  return my.config.toggle_notifications
end

function M.notifications_toggle(enable) --
  my.config.toggle_notifications = enable
end

-- NOTE: Actual toggles are in `my.setup.toggles`

return M
