---@class MyFsPath
local M = {}
M.init = { no_init = true, recurse = false } ---@type MyModuleInit

--- Expand and resolve a path to it's real and absolute form.
---@param path string
---@return string?
function M.real_abs(path) --
  return vim.uv.fs_realpath(vim.fs.normalize(path))
end

return M
