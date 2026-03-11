local my = require "my"
---@class my.ai.coco.adapters
local M = my.tbl.merge_dicts_into_first( --
  {},
  require "my.codecompanion.adapters.gemini",
  require "my.codecompanion.adapters.copilot"
)

return M
