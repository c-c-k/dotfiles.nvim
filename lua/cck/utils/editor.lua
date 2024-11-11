local M = {}

--- Set the current directory of the given scope to the given path
---
--- If the given path is a file the current directory will be set to it's parent directory
--- If an invalid string is passed as a path an error message will be printed but an error will not be raised
---@param path string? the path to set the pwd to
---@param scope "a" | "g" | "w" | "t" change the global/window/tab scope, "a" changes the currently active scope as per `vim.fn.chdir()`
---@return
---| false # in case of an invalid path
---| nil # in case path is the same as the current PWD
---| string prev_pwd the previous pwd
function M.schdir(path, scope)
  ---@type string | 'false' | nil
  if not path then
    vim.api.nvim_err_writeln(("Invalid path: %s"):format(path))
    return false
  end

  local prev_pwd = vim.fn.getcwd()
  local success = true

  path = vim.trim(path)

  if vim.fn.isdirectory(path) ~= 1 then
    local parent
    success, parent = pcall(vim.fs.dirname, path)
    if success then path = parent end
  end

  if success then
    if vim.fn.has "win32" > 0 then path = path:gsub("\\", "/") end

    if prev_pwd ~= path then
      if scope == "a" then
        success, _ = pcall(vim.fn.chdir, path)
      elseif scope == "g" then
        success, _ = pcall(vim.api.nvim_set_current_dir, path)
      elseif scope == "w" then
        success, _ = pcall(vim.cmd.lchdir, path)
      elseif scope == "t" then
        success, _ = pcall(vim.cmd.tchdir, path)
      else
        vim.api.nvim_err_writeln(("Unable to parse scope: %s"):format(scope))
      end
    else
      prev_pwd = nil
    end
  end

  if success then
    return prev_pwd
  else
    vim.api.nvim_err_writeln(("Invalid path: %s"):format(path))
    return false
  end
end

--- Set the current directory of the given scope to the parent directory of the current buffer
---
--- If the current buffer name is not a valid path an error message will be printed but an error will not be raised
---@param scope "a" | "g" | "w" | "t" change the global/window/tab scope, "a" changes the currently active scope as per `vim.fn.chdir()`
---@return
---| false # in case the current buffer name is not a valid path
---| nil # in case the buffer dir is the same as the current PWD
---| string prev_pwd the previous pwd
function M.schdir_buf_dir(scope)
  local path = vim.api.nvim_buf_get_name(0)
  return M.schdir(path, scope)
end

--- Set the current directory of the given scope to the root directory of the current buffer
---
--- The root directory is determined by astrocore.rooter.detect()
--- If the current buffer does not have a root directory an error message will be printed but an error will not be raised
---@param scope "a" | "g" | "w" | "t" change the global/window/tab scope, "a" changes the currently active scope as per `vim.fn.chdir()`
---@return
---| false # in case the current buffer does not have a root directory.
---| nil # in case the buffer root dir is the same as the current PWD
---| string prev_pwd the previous pwd
function M.schdir_buf_root(scope)
  local root = require("astrocore.rooter").detect()[1].paths[1]

  if root then
    return M.schdir(root, scope)
  else
    vim.api.nvim_err_writeln(("Buffer does not have root dir: %s"):format(vim.api.nvim_buf_get_name(0)))
    return false
  end
end

return M
