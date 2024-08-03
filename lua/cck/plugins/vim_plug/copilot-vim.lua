-- ===========================================================================
-- Copilot Vim
-- ===========================================================================
-- see: <https://github.com/github/copilot.vim>
-- see: `:help copilot`

vim.g.copilot_filetypes = {
    -- "*": false, -- Disable Copilot for all filetypes
}
-- vim.g.copilot_node_command = "copilot-node",
-- vim.g.copilot_proxy = "https://...",
-- vim.g.copilot_proxy_strict_ssl = false,
-- vim.g.copilot_workspace_folders = {},

-- Disable copilot by default because it is distracting when it suddenly starts
-- giving unexpected suggestions (also might be a bit of a security/privacy
-- concern if accidentally remains active in a buffer with sensitive
-- information).
vim.g.copilot_enabled = false

