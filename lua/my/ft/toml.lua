local my = require "my"
---@class my.ft.toml
local M = {}

M.a0_init = function()
  local specks = my.g.lazy_filetype_specs
  specks[#specks + 1] = {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = M.opts.treesitter_integration,
  }
  specks[#specks + 1] = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = M.opts.mason_tool_installer_integration,
  }
end

M.opts = {}

M.opts.treesitter_integration = function(_, opts)
  if opts.ensure_installed ~= "all" then
    opts.ensure_installed = my.tbl.merge_lists_into_first(opts.ensure_installed, { "toml" })
  end
end

M.opts.mason_tool_installer_integration = function(_, opts) --
  opts.ensure_installed = my.tbl.merge_lists_into_first(opts.ensure_installed, { "taplo" })
end

return M
