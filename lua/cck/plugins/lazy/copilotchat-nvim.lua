-- ============
-- Copilot Chat
-- ============

-- repo url: <https://github.com/CopilotC-Nvim/CopilotChat.nvim>
-- nvim help: `:help copilotchat`

return {
  'CopilotC-Nvim/CopilotChat.nvim',
  -- == PLUGIN DISABLED ==
  -- This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one.
  -- It is temporarily disabled until it passed manual inspection to check that it has been converted correctly.
  enabled = false,
  opts = {
    -- alignment placeholder
  },
  config = function(_, opts)      
    require("CopilotChat").setup {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    }
  end,
}
