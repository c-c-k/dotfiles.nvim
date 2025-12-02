local my = require "my"

local M = my.tbl.merge( --
  "dDFn",
  require "my.codecompanion.adapters.gemini",
  require "my.codecompanion.adapters.copilot"
)

return M
