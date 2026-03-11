local my = require "my"
---@class my.buf
local M = {}

function M.close_buf()
  if my.b[0].close_buf then
    my.b[0].close_buf()
    return
  end
  local success, snacks = pcall(require, "snacks")
  if success then
    snacks.bufdelete { wipe = false }
  else
    vim.api.nvim_buf_delete(0, {})
  end
end

---TODO: description
---@param filter_func fun(): boolean
---@return integer[]
function M.filter_bufs(filter_func) --
  return vim.iter(vim.api.nvim_list_bufs()):filter(filter_func):totable()
end

---TODO: description
---@return integer[]
function M.get_normal_bufs() --
  return M.filter_bufs(M.is_normal)
end

function M.get_normal_or_term_bufs() --
  return M.filter_bufs(M.is_normal_or_term)
end

function M.get_term_bufs() --
  return M.filter_bufs(M.is_term)
end

function M.is_listed(bufnr)
  if not bufnr then bufnr = 0 end
  return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end

function M.is_normal(bufnr)
  if not bufnr then bufnr = 0 end
  return M.is_listed(bufnr) and vim.bo[bufnr].buftype == ""
end

function M.is_normal_or_term(bufnr)
  if not bufnr then bufnr = 0 end
  local buftype = vim.bo[bufnr].buftype
  return M.is_listed(bufnr) and (buftype == "" or buftype == "terminal")
end

function M.is_term(bufnr)
  if not bufnr then bufnr = 0 end
  return M.is_listed(bufnr) and vim.bo[bufnr].buftype == "terminal"
end

M.keymaps = {}

M.keymaps.close_buf = { ---@type my.keymap.keymap_spec
  desc = "Close buffer",
  rhs = M.close_buf,
}
M.keymaps.enew = { ---@type my.keymap.keymap_spec
  desc = "enew buffer",
  rhs = "<CMD>enew<CR>",
}
M.keymaps.restore_line = { ---@type my.keymap.keymap_spec
  desc = "Restore line",
  rhs = "U",
}
M.keymaps.unundo = { ---@type my.keymap.keymap_spec
  desc = "Unundo",
  rhs = "<C-R>",
}

return M
