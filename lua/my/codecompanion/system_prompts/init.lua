local M = vim.tbl_deep_extend(
  "error",
  {},
  require "my.codecompanion.system_prompts.gemini",
  require "my.codecompanion.system_prompts.copilot"
)

return M
