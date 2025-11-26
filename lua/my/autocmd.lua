local M = {}

---@class my.core.keyset.get_augroup: vim.api.keyset.create_augroup
---@field name string

---@class my.core.keyset.add_autocmd: vim.api.keyset.create_autocmd
---@field event string | string[]

--- Wrapper around `nvim_create_augroup`.
---
--- Places the `name` parameter inside `opts`.
---@see `:help nvim_create_augroup`
---@param opts my.core.keyset.get_augroup
---@return integer
function M.get_augroup(opts) --
  local name = opts.name
  opts.name = nil
  return vim.api.nvim_create_augroup(name, opts)
end

--- Wrapper around `nvim_create_autocmd`.
---
--- Places the `event` parameter inside `opts`.
---@see `:help nvim_create_autocmd`
---@param opts my.core.keyset.add_autocmd
---@return integer
function M.add_autocmd(opts) --
  local event = opts.event
  opts.event = nil
  return vim.api.nvim_create_autocmd(event, opts)
end

return M
