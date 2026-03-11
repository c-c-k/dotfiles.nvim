---@class my.autocmd
local M = {}

--- Wrapper around `nvim_create_autocmd`.
---
--- Places the `event` parameter inside `opts`.
--- Inlines group creation:
---   If `opts.group` is a string a group with that name is created and cleared.
---   If `opts.group` is a table it's first element is treated as the group name and it's second as the group clear flag.
---@param opts my.autocmd.add_autocmd.opts
---@return integer
function M.add_autocmd(opts) --
  local event = opts.event
  opts.event = nil
  local group = opts.group
  if type(group) == "string" then
    opts.group = vim.api.nvim_create_augroup(group, {})
  elseif type(group) == "table" then
    opts.group = vim.api.nvim_create_augroup(group[1], { clear = group[2] })
  end
  return vim.api.nvim_create_autocmd(event, opts)
end

--- Wrapper around `nvim_del_autocmd`.
---
--- Deletes multiple autocommands at once.
---@param autocmd_ids integer|integer[]
function M.del_autocmds(autocmd_ids) --
  if type(autocmd_ids) ~= "table" then autocmd_ids = { autocmd_ids } end
  for _, autocmd_id in ipairs(autocmd_ids) do
    vim.api.nvim_del_autocmd(autocmd_id)
  end
end

--- Wrapper around `nvim_create_augroup`.
---
--- Enforces explicit clear group setting.
---
---@param name string
---@param clear boolean
---@return integer
function M.get_augroup(name, clear) --
  vim.validate("clear", clear, "boolean", false)
  return vim.api.nvim_create_augroup(name, { clear = clear })
end

return M
