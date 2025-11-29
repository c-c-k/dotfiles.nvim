local M = {}

function M.close_buf()
  if vim.b.my_close_buf then
    vim.b.my_close_buf()
    return
  end
  local success, snacks = pcall(require, "snacks")
  if success then
    snacks.bufdelete { wipe = true }
    return
  end
  vim.api.nvim_buf_delete(0, {})
end

return M
