local _gemini_api_key = "cmd: secret-tool lookup API_KEY gemini"

local gemini_template = function()
  return require("codecompanion.adapters").extend("gemini", {
    name = "gemini_template",
    env = {
      api_key = _gemini_api_key,
    },
    schema = {
      model = {
        default = "gemini-1.5-pro",
      },
    },
  })
end

local M = {}

M.gemini_codecompanion = function()
  return require("codecompanion.adapters").extend(gemini_template, {
    name = "gemini_codecompanion",
  })
end

M.gemini_gem_code_assistant = function()
  return require("codecompanion.adapters").extend(gemini_template, {
    name = "gemini_gem_code_assistant",
  })
end

M.gemini_general = function()
  return require("codecompanion.adapters").extend(gemini_template, {
    name = "gemini_general",
  })
end

return M
