local my = require "my"
---@class my.cmp.autopairs
local M = {}

M.opts = {}

M.opts.core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_aupairs_)
end

function M.autopairs_is_enabled_global() --
  return not require("autopairs").state.disabled
end

---@param enable boolean
function M.autopairs_toggle_global(enable) --
  if enable then
    require("autopairs").enable()
  else
    require("autopairs").disable()
  end
end

return M
