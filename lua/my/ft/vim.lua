---@class MyFtVim
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.filetypes = function()
  -- local autocmds = my.config.setup_filetype_autocmds
  -- local lsp = my.config.setup_lsp_configs
  -- local mason_ensure_installed = my.config.mason_ensure_installed
  -- local specks = my.config.lzsetup_plugin_specs
  local ts_ensure_installed = my.config.ts_ensure_installed

  ts_ensure_installed["vim"] = true
  ts_ensure_installed["vimdoc"] = true
end

return M
