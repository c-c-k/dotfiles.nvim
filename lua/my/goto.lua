local M = {}

--- Open a URI with external program.
---
--- Copied from `nvim/share/nvim/runtime/lua/vim/_defaults.lua`.
---@param uri string
---@return string|nil
function M.do_external_open(uri)
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
function M.goto_external(mode)
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
    if err then vim.notify(err, vim.log.levels.ERROR) end
  end
end

--- Edit a URI in current window.
---
---@param uri string
---@return string?
function M.do_edit(uri)
  local success, err = pcall(vim.cmd.find, uri)
  return success and nil or err
end

--- Edit filepath/URI under cursor in the current window.
---
--- Can be overridden with `vim.b.my_goto_file`.
---@param mode "v"|"n"
function M.goto_file(mode)
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
    local err = M.do_edit(url)
    if err then
      vim.notify(err, vim.log.levels.ERROR)
    else
      return
    end
  end
end

return M
