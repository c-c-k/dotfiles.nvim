---@class MyFtMarkdown
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.filetypes = function()
  local autocmds = my.config.setup_filetype_autocmds
  local lsp = my.config.setup_lsp_configs
  local mason_ensure_installed = my.config.mason_ensure_installed
  local null_ls = my.config.null_ls_sources
  -- local specks = my.config.lzsetup_plugin_specs
  local ts_ensure_installed = my.config.ts_ensure_installed

  autocmds[#autocmds + 1] = M._autocmd_filetype_setup

  ts_ensure_installed["markdown"] = true
  ts_ensure_installed["markdown_inline"] = true

  mason_ensure_installed["marksman"] = true
  lsp[#lsp + 1] = { M._lspconfig_marksman, true }

  mason_ensure_installed["mdformat"] = true
  null_ls["mdformat"] = M._null_ls_mdformat
end

M._autocmd_filetype_setup = function()
  my.autocmd.add_autocmd {
    group = { "my.filetypes", false },
    event = "FileType",
    pattern = "markdown",
    desc = 'Set options, vars and mappings for the "markdown" filetype',
    callback = function(ev)
      local buf_id = ev.buf
      local did_ftplugin = my.config.did_ftplugin_buf[buf_id]
      -- Override NVIM defaults.
      -- Needs to be done before the `did_ftplugin` check due to lazy.nvim emitting
      -- filetype autocommands multiple times and NVIM executing the default filetype
      -- config each time, see:
      --  * https://github.com/folke/lazy.nvim/issues/1993
      vim.opt_local.formatoptions = "tcroqwn2l1j"

      if did_ftplugin == "markdown" then return end
      my.config.did_ftplugin_buf[buf_id] = "markdown"
    end,
  }
end

M._lspconfig_marksman = function(enable)
  local config_name = "marksman"
  local server_name = "marksman"

  local server_settings = {
    -- marksman settings placeholder
  }

  -- local old_config = vim.lsp.config[config_name]
  local new_config = { ---@type vim.lsp.Config
    name = config_name,
    settings = { [server_name] = server_settings },
  }

  my.lsp.lspconfig.apply_lsp_config(new_config, enable)
end

M._null_ls_mdformat = function(null_ls) --
  return null_ls.builtins.formatting.mdformat
end

return M
