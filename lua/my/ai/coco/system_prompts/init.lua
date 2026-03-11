local my = require "my"
---@class my.ai.coco.system_prompts
local M = my.tbl.merge_dicts_into_first( --
  {},
  require "my.codecompanion.system_prompts.gemini",
  require "my.codecompanion.system_prompts.copilot"
)

return M
