---@class MyCmpLuasnip
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_luasnip
end

M._spec_luasnip = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["LuaSnip"],
    lazy = false,
    build = "make install_jsregexp",
    opts = {
      link_children = true,
      link_roots = true,
      keep_roots = true,
      delete_check_events = "TextChanged",
      region_check_events = "CursorMoved",
    },
    config = function(_, opts)
      require("luasnip").config.setup(opts)

      local luasnip_loaders = my.config.luasnip_loaders
      for _, loader in ipairs(luasnip_loaders) do
        loader()
      end
    end,
  }
  return spec
end

return M
