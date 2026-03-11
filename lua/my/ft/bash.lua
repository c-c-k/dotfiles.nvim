local my = require "my"
---@class my.ft.bash
local M = {}

M.a0_init = function()
  local specks = my.g.lazy_filetype_specs
  specks[#specks + 1] = {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = M.opts.bashls_setup,
  }
  specks[#specks + 1] = {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = M.opts.treesitter_integration,
  }
  specks[#specks + 1] = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = M.opts.mason_tool_installer_integration,
  }
end

M.opts = {}
M.opts.bashls_setup = function()
  local bashls_server_settings = {
    -- bashls settings placeholder
  }
  my.g.lsp_enable["bashls"] = true
  local config = vim.lsp.config["bashls"] ---@type vim.lsp.Config
  vim.lsp.config["bashls"] = my.tbl.merge_dicts_into_first(config, {
    filetypes = { "sh", "bash", "zsh" },
    settings = { bashls = bashls_server_settings },
  } --[[@as vim.lsp.Config]])
end
M.opts.mason_tool_installer_integration = function(_, opts)
  opts.ensure_installed = my.tbl.merge_lists_into_first(
    opts.ensure_installed,
    { "bash-language-server", "shellcheck", "shfmt", "bash-debug-adapter" }
  )
end
M.opts.treesitter_integration = function(_, opts)
  if opts.ensure_installed ~= "all" then
    opts.ensure_installed = my.tbl.merge_lists_into_first(opts.ensure_installed, { "bash" })
  end
end

return M
