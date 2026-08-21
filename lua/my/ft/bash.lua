---@class MyFtBash
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.filetypes = function()
  -- local autocmds = my.config.setup_filetype_autocmds
  local lsp = my.config.setup_lsp_configs
  local mason_ensure_installed = my.config.mason_ensure_installed
  local null_ls = my.config.null_ls_sources
  -- local specks = my.config.lzsetup_plugin_specs
  local ts_ensure_installed = my.config.ts_ensure_installed

  ts_ensure_installed["bash"] = true

  mason_ensure_installed["bash-language-server"] = true
  mason_ensure_installed["shellcheck"] = true
  lsp[#lsp + 1] = { M._lspconfig_bashls, true }

  mason_ensure_installed["shfmt"] = true
  null_ls["shfmt"] = M._null_ls_shfmt

  mason_ensure_installed["bash-debug-adapter"] = true
end

M._lspconfig_bashls = function(enable)
  local config_name = "bashls"
  local server_name = "bashls"

  local server_settings = {
    -- bashls settings placeholder
  }

  -- local old_config = vim.lsp.config[config_name]
  local new_config = { ---@type vim.lsp.Config
    name = config_name,
    filetypes = { "sh", "bash", "zsh" },
    settings = { [server_name] = server_settings },
  }

  my.lsp.lspconfig.apply_lsp_config(new_config, enable)
end

M._null_ls_shfmt = function(null_ls) --
  return null_ls.builtins.formatting.shfmt
end

return M
