---@class MySyntaxRegex
local M = {}
M.init = { no_init = true, recurse = false } ---@type MyModuleInit

local my = require "my"

function M.syntax_hl_is_enabled_buf() --
  return vim.bo.syntax ~= "off"
end

--- Toggle buffer regex syntax highlighting.
---@param enable boolean # if false turns highlighting off.
---@param bufnr? integer
function M.syntax_hl_toggle_buf(enable, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if enable then
    vim.bo.syntax = my.config.syntax_prev_buf[bufnr] or "on"
    my.config.syntax_prev_buf[bufnr] = nil
  else
    my.config.syntax_prev_buf[bufnr] = vim.bo.syntax ~= "off" and vim.bo.syntax or nil
    vim.bo.syntax = "off"
  end
end

return M
