---@class MyUiIcons
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_mini_icons
end

M._spec_mini_icons = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["mini.icons"],
    opts = {
      style = my.config.icons_enabled and "glyph" or "ascii",
    },
    config = function(_, opts)
      local mini_icons = require "mini.icons"
      local mock_nvim_web_devicons = opts.mock_nvim_web_devicons
      opts.mock_nvim_web_devicons = nil

      mini_icons.setup(opts)

      if mock_nvim_web_devicons then mini_icons.mock_nvim_web_devicons() end
    end,
  }
  return spec
end

return M
