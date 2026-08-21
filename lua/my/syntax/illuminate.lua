---@class MySyntaxIlluminate
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_vim_illuminate
end

M._spec_vim_illuminate = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["vim-illuminate"],
    config = function(_, opts)
      require("illuminate").configure(opts)

      my.keymap.queue_km_group_load(my.config.keymaps.g_illumint)
    end,
  }
  return spec
end

M.keymaps = {}

M.keymaps.next = { ---@type MyKeymapKeymapSpec
  desc = "next <cword>",
  rhs = function() require("illuminate").goto_next_reference(true) end,
}
M.keymaps.prev = { ---@type MyKeymapKeymapSpec
  desc = "prev <cword>",
  rhs = function() require("illuminate").goto_prev_reference(true) end,
}

return M
