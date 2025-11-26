local M = {}

---@alias my.path.cd_scope
---| '"Active"' # As per the `chdir()` function.
---| '"Global"' # Global editor scope.
---| '"Tab"' # Tab scope.
---| '"Local"' # Window Local scope.
---| '"Window"' # Window Local scope.

--- Get root for given path or current buffer.
---@param path string?
---@return string?
local function _get_root(path)
  ---@type string?
  local root

  if path then
    local detectors = require("astrocore").config.rooter.detector
    root = vim.fs.root(path or 0, detectors or {})
  else
    local roots = require("astrocore.rooter").detect(0, false)
    root = #roots > 0 and roots[1].paths[1] or nil
  end

  if not root then
    local _msg = ("Buffer does not have root dir: %s"):format(vim.api.nvim_buf_get_name(0))
    vim.api.nvim_echo({ { _msg } }, true, { err = true })
  end

  return root
end

--- Change editor PWD for given scope to path.
---@param scope my.path.cd_scope
---@param path string
---@return string?
local function _do_cd(scope, path)
  ---@type string
  local scope_name = ""
  ---@type boolean
  local success = false
  ---@type string?
  local result = ""

  if vim.fn.has "win32" > 0 then path = path:gsub("\\", "/") end

  local do_toggle_win = vim.wo.winfixbuf and vim.b.my_do_toggle_win
  if do_toggle_win then do_toggle_win() end

  if scope == "Active" then
    scope_name = "Active"
    success, result = pcall(vim.fn.chdir, path)
  elseif scope == "Global" then
    scope_name = "Global"
    success, result = pcall(vim.api.nvim_set_current_dir, path)
  elseif scope == "Tab" then
    scope_name = "Tab"
    success, result = pcall(vim.cmd.tchdir, path)
  elseif scope == "Window" or scope == "Local" then
    scope_name = "Window Local"
    success, result = pcall(vim.cmd.lchdir, path)
  else
    success = false
    result = ("Unable to parse scope: %s"):format(scope)
  end

  if do_toggle_win then do_toggle_win() end

  if success then
    local _msg = ("Changed %s PWD to: %s"):format(scope_name, path)
    vim.api.nvim_echo({ { _msg } }, false, {})
    return path
  end
  local _msg = ("Failed to Change %s PWD to: %s"):format(scope_name, path)
  vim.api.nvim_echo({ { _msg } }, true, { err = true })
  vim.api.nvim_echo({ { result } }, true, { err = true })
  return nil
end

--- Set the current directory of the given scope.
---
--- If no path is provided, use current buffer name as path.
--- If path is a file, set PWD to parent directory.
--- If `root` is true, set to root directory instead.
---@param scope my.path.cd_scope Scope to change PWD for.
---@param cd_root boolean? If `true` set PWD to the root dir.
---@param path string? The path to set the PWD to/relative to.
---@return string # the previous PWD.
function M.cd(scope, cd_root, path)
  local prev_pwd = vim.fn.getcwd()
  path = path or (vim.b.my_get_buf_dir_path and vim.b.my_get_buf_dir_path())
  path = path and vim.trim(path)

  if cd_root then
    path = _get_root(path)
  else
    path = path or vim.api.nvim_buf_get_name(0)
    if vim.fn.isdirectory(path) ~= 1 then
      local success, parent = pcall(vim.fs.dirname, path)
      if success then path = parent end
    end
  end

  if path and vim.fn.isdirectory(path) ~= 1 then
    local _msg = ("Invalid path: %s"):format(path)
    vim.api.nvim_echo({ { _msg } }, true, { err = true })
    path = nil
  end

  if path then path = _do_cd(scope, path) end

  if not path or path == prev_pwd or path == "" then
    local _msg = ("PWD left at %s"):format(prev_pwd)
    vim.api.nvim_echo({ { _msg } }, false, {})
  end

  return prev_pwd
end

return M
