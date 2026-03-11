local my = require "my"
---@class my.config: my.config._submodules
local M = {}

function M.setup_core_autocmds() --
  local core_setup_autocmds = my.g.core_setup_autocmds
  my.g.core_setup_autocmds = nil
  for _, core_setup_func in ipairs(core_setup_autocmds) do
    vim.validate("core_setup_func", core_setup_func, "callable")
    core_setup_func()
  end
end

return M
