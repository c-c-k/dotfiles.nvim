---@class MyCmpAutopairs
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_autopairs
end

M._spec_autopairs = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["nvim-autopairs"],
    lazy = false,
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      my.keymap.queue_km_group_load(my.config.keymaps.g_aupairs_)
    end,
  }
  return spec
end

function M.autopairs_is_enabled_global() --
  return not require("nvim-autopairs").state.disabled
end

---@param enable boolean
function M.autopairs_toggle_global(enable) --
  if enable then
    require("nvim-autopairs").enable()
  else
    require("nvim-autopairs").disable()
  end
end

return M
