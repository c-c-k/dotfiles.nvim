local M = {}

M.copilot_codecompanion = function()
  return require("codecompanion.adapters").extend("copilot", {
    name = "copilot_codecompanion",
  })
end

return M
