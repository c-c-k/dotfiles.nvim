local my = require "my"

local M = my.tbl.merge( --
  "dDFn",
  require "my.codecompanion.system_prompts.gemini",
  require "my.codecompanion.system_prompts.copilot"
)

return M
