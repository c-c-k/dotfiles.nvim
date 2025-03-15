local M = {}

M.copilot_gem_code_assistant = function()
  return require("codecompanion.adapters").extend("copilot", {
    name = "copilot_gem_code_assistant",
    schema = {
      model = {
        default = "gemini-2.0-flash-001",
      },
    },
  })
end

return M
