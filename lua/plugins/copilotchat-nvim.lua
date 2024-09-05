-- ============
-- Copilot Chat
-- ============

-- repo url: <https://github.com/CopilotC-Nvim/CopilotChat.nvim>
-- nvim help: `:help copilotchat`

return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'canary',
  config = function(_, opts)      
    require("CopilotChat").setup {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    }
  end,
}
