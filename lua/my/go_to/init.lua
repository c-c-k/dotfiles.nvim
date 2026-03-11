local my = require "my"
---@class my.go_to
local M = {}

--- Edit a URI in current window.
---
---@param uri string
---@return string?
local function _do_edit(uri)
  local success, err = pcall(vim.cmd.find, uri)
  return success and nil or err
end

--- Open a URI with external program.
---
--- Copied from `nvim/share/nvim/runtime/lua/vim/_defaults.lua`.
---@param uri string
---@return string|nil
M.do_external_open = function(uri)
  local cmd, err = vim.ui.open(uri)
  local rv = cmd and cmd:wait(1000) or nil
  if cmd and rv and rv.code ~= 0 then
    err = string.format(
      "vim.ui.open: command %s (%d): %s",
      (rv.code == 124 and "timeout" or "failed"),
      rv.code,
      vim.inspect(cmd.cmd)
    )
  end
  return err
end

--- Open filepath/URI under cursor with system handler.
---
--- Can be overridden with `vim.b.my_goto_external`.
--- Copied from `nvim/share/nvim/runtime/lua/vim/_defaults.lua`.
---@param mode "v"|"n"
M.goto_external = function(mode)
  if vim.b.my_goto_external then
    vim.b.my_goto_external()
    return
  end

  local urls
  if mode == "v" then
    local lines = vim.fn.getregion(vim.fn.getpos ".", vim.fn.getpos "v", { type = vim.fn.mode() })
    urls = { table.concat(vim.iter(lines):map(vim.trim):totable()) }
  else
    urls = require("vim.ui")._get_urls()
  end

  for _, url in ipairs(urls) do
    local err = M.do_external_open(url)
    if err then
      my.notify.error(err)
    else
      return true
    end
  end
end

--- Edit filepath/URI under cursor in the current window.
---
--- Can be overridden with `vim.b.my_goto_file`.
---@param mode "v"|"n"
M.goto_file = function(mode)
  if vim.b.my_goto_file then
    vim.b.my_goto_file()
    return
  end

  local urls
  if mode == "v" then
    local lines = vim.fn.getregion(vim.fn.getpos ".", vim.fn.getpos "v", { type = vim.fn.mode() })
    urls = { table.concat(vim.iter(lines):map(vim.trim):totable()) }
  else
    urls = require("vim.ui")._get_urls()
  end

  for _, url in ipairs(urls) do
    local err = _do_edit(url)
    if err then
      my.notify.error(err)
    else
      return true
    end
  end
end

M.keymaps = {}

M.keymaps.n_goto_external = { ---@type my.keymap.keymap_spec
  desc = "goto external",
  rhs = function() return M.goto_external "n" end,
}
M.keymaps.n_goto_file = { ---@type my.keymap.keymap_spec
  desc = "goto file",
  rhs = function() return M.goto_file "n" end,
}
M.keymaps.v_goto_external = { ---@type my.keymap.keymap_spec
  desc = "goto external",
  rhs = function() return M.goto_external "v" end,
}
M.keymaps.v_goto_file = { ---@type my.keymap.keymap_spec
  desc = "goto file",
  rhs = function() return M.goto_file "v" end,
}

return M
