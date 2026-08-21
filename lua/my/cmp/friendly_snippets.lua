---@class MyCmpFriendlySnippets
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_friendly_snippets
end

M._spec_friendly_snippets = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["friendly-snippets"],
    lazy = true,
    opts = function(plugin, opts) --
      return my.tbl.merge("dDkL", opts, {
        paths = plugin.dir,
        exclude = { --
          "lua", -- adds noise over builtin LuaLS snippets
        },
      })
    end,
    config = function(_, opts) --
      table.insert(my.config.luasnip_loaders, function() require("luasnip.loaders.from_vscode").lazy_load(opts) end)
    end,
    specs = make_lzspec {
      source = plugins["LuaSnip"],
      optional = false,
      dependencies = make_lzspec(plugins["friendly-snippets"]),
    },
  }
  return spec
end

return M
