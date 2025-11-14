local M = vim.tbl_deep_extend(
  "error",
  {},
  require "my.codecompanion.adapters.gemini",
  require "my.codecompanion.adapters.copilot"
)

return M
