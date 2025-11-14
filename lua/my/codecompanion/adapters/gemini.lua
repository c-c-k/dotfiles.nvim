-- local get_gemini_api_key = "cmd: secret-tool lookup API_KEY gemini"
local api_key
local get_gemini_api_key = function()
  -- Input via nvim inputsecret()
  -- if not api_key then api_key = vim.fn.inputsecret "Please perform KeepassXC autotype for Gemini API key:" end

  -- Input via KDialog
  if not api_key then
    local handle =
      io.popen [[kdialog --password "Please perform KeepassXC autotype for Gemini API key:" --title "nvim codecompanion gemini api_key"]]
    if handle then
      api_key = handle:read("*a"):gsub("\n", "")
      if api_key == "" then api_key = nil end
    end
  end

  return api_key
end

local gemini_template = function()
  return require("codecompanion.adapters").extend("gemini", {
    name = "gemini_template",
    env = {
      api_key = get_gemini_api_key,
    },
    schema = {
      model = {
        default = "gemini-2.5-pro-preview-03-25",
        -- choices = { "gemini-2.0-flash-thinking-exp-01-21" },
      },
    },
  })
end

local M = {}

-- M.gemini_codecompanion = function()
--   return require("codecompanion.adapters").extend(gemini_template, {
--     name = "gemini_codecompanion",
--   })
-- end
--
-- M.gemini_gem_code_assistant = function()
--   return require("codecompanion.adapters").extend(gemini_template, {
--     name = "gemini_gem_code_assistant",
--   })
-- end
--
-- M.gemini_general = function()
--   return require("codecompanion.adapters").extend(gemini_template, {
--     name = "gemini_general",
--   })
-- end

M.gemini = function()
  return require("codecompanion.adapters").extend(gemini_template, {
    name = "gemini",
  })
end

return M
