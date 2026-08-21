---@class MyBuf
local M = {}
M.init = { no_init = true, recurse = false } ---@type MyModuleInit

local my = require "my"

---@param buf_id BufId
function M.close_buf(buf_id)
  if not buf_id then buf_id = vim.api.nvim_get_current_buf() end

  local custom_close_buf_fun = my.config.close_buf[buf_id]
  if custom_close_buf_fun then
    custom_close_buf_fun(buf_id)
    return
  end

  local has_snacks, snacks = pcall(require, "snacks")
  if has_snacks then
    snacks.bufdelete { buf = buf_id }
  else
    vim.api.nvim_buf_delete(buf_id, {})
  end
end

---@param filter_func fun(buf_id: BufId): boolean
---@return integer[]
function M.filter_bufs(filter_func) --
  local filtered = {}
  for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
    if filter_func(buf_id) then filtered[#filtered + 1] = buf_id end
  end
  return filtered
end

--- Get buffers that are valid, listed and have empty `buftype`
---@return integer[]
function M.get_normal_bufs() --
  return M.filter_bufs(M.is_normal)
end

--- Get buffers that are valid, listed and have empty or terminal `buftype`
---@return integer[]
function M.get_normal_or_term_bufs() --
  return M.filter_bufs(M.is_normal_or_term)
end

--- Get buffers that are valid, listed and have terminal `buftype`
---@return integer[]
function M.get_term_bufs() --
  return M.filter_bufs(M.is_term)
end

--- Buffer is valid and listed
---@param buf_id integer
---@return boolean
function M.is_listed(buf_id)
  if not buf_id then buf_id = vim.api.nvim_get_current_buf() end
  return vim.api.nvim_buf_is_valid(buf_id) and vim.bo[buf_id].buflisted
end

--- Buffer is valid, listed and has empty `buftype`
---@param buf_id integer
function M.is_normal(buf_id)
  if not buf_id then buf_id = vim.api.nvim_get_current_buf() end
  return M.is_listed(buf_id) and vim.bo[buf_id].buftype == ""
end

--- Buffer is valid, listed and has empty or terminal `buftype`
function M.is_normal_or_term(buf_id)
  if not buf_id then buf_id = vim.api.nvim_get_current_buf() end
  local buftype = vim.bo[buf_id].buftype
  return M.is_listed(buf_id) and (buftype == "" or buftype == "terminal")
end

--- Buffer is valid, listed and has terminal `buftype`
function M.is_term(buf_id)
  if not buf_id then buf_id = vim.api.nvim_get_current_buf() end
  return M.is_listed(buf_id) and vim.bo[buf_id].buftype == "terminal"
end

M.keymaps = {}

M.keymaps.close_buf = { ---@type MyKeymapKeymapSpec
  desc = "Close buffer",
  rhs = M.close_buf,
}
M.keymaps.enew = { ---@type MyKeymapKeymapSpec
  desc = "enew buffer",
  rhs = "<CMD>enew<CR>",
}
M.keymaps.restore_line = { ---@type MyKeymapKeymapSpec
  desc = "Restore line",
  rhs = "U",
}
M.keymaps.unundo = { ---@type MyKeymapKeymapSpec
  desc = "Unundo",
  rhs = "<C-R>",
}

return M
