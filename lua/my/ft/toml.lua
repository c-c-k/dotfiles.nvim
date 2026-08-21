---@class MyFtToml
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.filetypes = function()
  -- local autocmds = my.config.setup_filetype_autocmds
  local lsp = my.config.setup_lsp_configs
  local mason_ensure_installed = my.config.mason_ensure_installed
  -- local specks = my.config.lzsetup_plugin_specs
  local ts_ensure_installed = my.config.ts_ensure_installed

  ts_ensure_installed["toml"] = true

  mason_ensure_installed["taplo"] = true
  lsp[#lsp + 1] = { M._lspconfig_taplo, true }
end

M._lspconfig_taplo = function(enable)
  local config_name = "taplo"
  local server_name = "taplo"

  -- MEMO: At this time taplo does not support configuration via LSP
  local server_settings = nil

  -- local old_config = vim.lsp.config[config_name]
  local new_config = { ---@type vim.lsp.Config
    name = config_name,
    settings = { [server_name] = server_settings },
  }

  my.lsp.lspconfig.apply_lsp_config(new_config, enable)
end

return M
