local my = require "my"
---@class my.ui.toggle
local M = {}

-- NOTE: Actual toggles are in `my.config.toggles`

M.opts = {}
M.opts.snacks_toggle_config = function()
  return { ---@type snacks.toggle.Config
    notify = M.notifications_is_enabled,
  }
end

function M.notifications_is_enabled() --
  return my.g.toggle_notifications
end

function M.notifications_toggle(state) --
  my.g.toggle_notifications = state
end

M.toggle_priority_var = my.vars.set_priority_var_scope_override

return M
