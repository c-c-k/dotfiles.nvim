---@class MySyntaxNvimTS
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_nvim_treesitter
end

M._spec_nvim_treesitter = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["nvim-treesitter"],
    build = ":TSUpdate",
    config = function(_, opts)
      local nvim_treesitter = require "nvim-treesitter"

      nvim_treesitter.setup(opts)

      my.config.ts_available = my.tbl.set_from_list(nvim_treesitter.get_available())

      if vim.fn.executable "tree-sitter" ~= 1 then
        local _msg = "`tree-sitter` executable missing, cannot install TreeSitter parsers"
        error(_msg)
      end

      nvim_treesitter.install(my.tbl.set_to_list(my.config.ts_ensure_installed))
      my.config.ts_ensure_installed = my.setup.utils.removed_after_use "my.config.ts_ensure_installed"
    end,
  }
  return spec
end

return M
