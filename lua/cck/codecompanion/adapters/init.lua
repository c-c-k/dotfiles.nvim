local M = vim.tbl_deep_extend(
  "error",
  {},
  require "cck.codecompanion.adapters.gemini",
  require "cck.codecompanion.adapters.copilot"
)

return M
