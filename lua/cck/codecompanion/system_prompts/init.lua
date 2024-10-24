local M = vim.tbl_deep_extend(
  "error",
  {},
  require "cck.codecompanion.system_prompts.gemini",
  require "cck.codecompanion.system_prompts.copilot"
)

return M
