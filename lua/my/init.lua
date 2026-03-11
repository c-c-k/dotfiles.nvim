---@class my: my._submodules
local M = require("my.tbl")._lazy_loading_module("my", {})

M.setup = function(opts)
  -- TODO: Add global setup options for my utility scripts?
  if opts and not vim.tbl_isempty(opts) then --
    vim.print("Null plugin opts: ", opts)
  end
end
return M
