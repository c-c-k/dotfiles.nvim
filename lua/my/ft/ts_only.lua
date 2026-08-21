---@class MyFtTSOnly
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.filetypes = function()
  local ts_ensure_installed = my.config.ts_ensure_installed

  ts_ensure_installed["comment"] = true
  ts_ensure_installed["editorconfig"] = true
  ts_ensure_installed["http"] = true
  ts_ensure_installed["make"] = true
  ts_ensure_installed["regex"] = true
  ts_ensure_installed["ssh_config"] = true
end

return M
