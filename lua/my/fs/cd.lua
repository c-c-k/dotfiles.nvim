---@class MyFsCd
local M = {}
M.init = { no_init = true, recurse = false } ---@type MyModuleInit

local my = require "my"

---@alias MyPathCdScope
---| '"Active"' # As per the `chdir()` function.
---| '"Global"' # Global editor scope.
---| '"Tab"' # Tab scope.
---| '"Local"' # Window Local scope.
---| '"Window"' # Window Local scope.

local _get_root = my.fs.rooter.get_root

function M.auto_cd_root_is_enabled_global() --
  return my.config.auto_cd_root
end

---@param enable boolean
function M.auto_cd_root_toggle_global(enable) --
  my.config.auto_cd_root = enable
  error "TODO: Implement auto CD root or remove toggle"
  -- NOTE: also adjust or remove var from config
end

--- Change editor PWD for given scope to path.
---@param scope MyPathCdScope
---@param path string
---@return string?
local function _do_cd(scope, path)
  ---@type string
  local scope_name = ""
  ---@type boolean
  local success = false
  ---@type string?
  local result = ""

  local toggle_buf_fixed_win = my.win.get_buf_fixed_win_toggler()
  toggle_buf_fixed_win()

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

  toggle_buf_fixed_win()

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
---@param scope MyPathCdScope Scope to change PWD for.
---@param cd_root boolean? If `true` set PWD to the root dir.
---@param path string? The path to set the PWD to/relative to.
---@return string # the previous PWD.
M.cd = function(scope, cd_root, path)
  local prev_pwd = vim.fn.getcwd()
  local buf_id = vim.api.nvim_get_current_buf()
  local custom_buf_dir_func = my.config.get_dir_path_func_buf[buf_id]
  path = (
    path --
    or (custom_buf_dir_func and custom_buf_dir_func())
    or vim.api.nvim_buf_get_name(buf_id)
  )
  path = path and vim.trim(path)

  if cd_root then
    path = _get_root(path, buf_id)
  else
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

M.keymaps = {}

M.keymaps.active_cd = { ---@type MyKeymapKeymapSpec
  desc = "active cd",
  rhs = function() M.cd("Active", false) end,
}
M.keymaps.active_cd_root = { ---@type MyKeymapKeymapSpec
  desc = "active cd root",
  rhs = function() M.cd("Active", false) end,
}
M.keymaps.global_cd = { ---@type MyKeymapKeymapSpec
  desc = "global cd",
  rhs = function() M.cd("Global", false) end,
}
M.keymaps.global_cd_root = { ---@type MyKeymapKeymapSpec
  desc = "global cd root",
  rhs = function() M.cd("Global", false) end,
}
M.keymaps.tab_cd = { ---@type MyKeymapKeymapSpec
  desc = "tab cd",
  rhs = function() M.cd("Tab", false) end,
}
M.keymaps.tab_cd_root = { ---@type MyKeymapKeymapSpec
  desc = "tab cd root",
  rhs = function() M.cd("Tab", false) end,
}
M.keymaps.win_cd = { ---@type MyKeymapKeymapSpec
  desc = "win cd",
  rhs = function() M.cd("Window", false) end,
}
M.keymaps.win_cd_root = { ---@type MyKeymapKeymapSpec
  desc = "win cd root",
  rhs = function() M.cd("Window", false) end,
}

return M
