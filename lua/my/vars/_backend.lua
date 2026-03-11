---@type table<my.vars4.scope_name, my.vars4._backend.scope>
local M = {}

M.b = {
  current_handle_getter = vim.api.nvim_get_current_buf,
  handles = {},
}

M.w = {
  current_handle_getter = vim.api.nvim_get_current_win,
  handles = {},
}

M.t = {
  current_handle_getter = vim.api.nvim_get_current_tabpage,
  handles = {},
}

M.g = {
  current_handle_getter = false,
  handles = { [0] = {} },
}

return M
