---@class MyFtLua
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.filetypes = function()
  local autocmds = my.config.setup_filetype_autocmds
  local lsp = my.config.setup_lsp_configs
  -- local mason_ensure_installed = my.config.mason_ensure_installed
  local null_ls = my.config.null_ls_sources
  -- local specs = my.config.lzsetup_plugin_specs
  local ts_ensure_installed = my.config.ts_ensure_installed

  autocmds[#autocmds + 1] = M._autocmd_filetype_setup

  ts_ensure_installed["lua"] = true
  ts_ensure_installed["luadoc"] = true -- Lua annotations
  ts_ensure_installed["luap"] = true -- Lua patterns (i.e. Lua regex)

  -- mason_ensure_installed["lua-language-server"] = true
  lsp[#lsp + 1] = { M._lspconfig_lua_ls, true }

  -- mason_ensure_installed["selene"] = true
  null_ls["selene"] = M._null_ls_selene

  -- mason_ensure_installed["stylua"] = true
  null_ls["stylua"] = M._null_ls_stylua
end

M._autocmd_filetype_setup = function()
  my.autocmd.add_autocmd {
    group = { "my.filetypes", false },
    event = "FileType",
    pattern = "lua",
    desc = 'Set options, vars and mappings for the "lua" filetype',
    callback = function(ev)
      local buf_id = ev.buf
      local did_ftplugin = my.config.did_ftplugin_buf[buf_id]
      if did_ftplugin == "lua" then return end
      my.config.did_ftplugin_buf[buf_id] = "lua"

      vim.opt_local.textwidth = 0
      vim.opt_local.shiftwidth = 2
      vim.opt_local.softtabstop = 2
    end,
  }
end

M._lspconfig_lua_ls = function(enable)
  local config_name = "lua_ls"
  local server_name = "Lua"

  local server_settings = {
    format = {
      enable = false, -- Disable in favor of stylua
    },
    hint = {
      enable = true,
      arrayIndex = "Disable",
    },
    runtime = {
      version = "LuaJIT",
    },
  }

  ---@type vim.lsp.Config
  local old_config = vim.lsp.config[config_name]
  local new_config = { ---@type vim.lsp.Config
    name = config_name,
    settings = { [server_name] = server_settings },
    root_dir = my.lsp.lspconfig.root_dir_gen_fallback_func(old_config),
  }

  my.lsp.lspconfig.apply_lsp_config(new_config, enable)
end

M._null_ls_selene = function(null_ls) --
  return null_ls.builtins.diagnostics.selene
end

M._null_ls_stylua = function(null_ls) --
  return null_ls.builtins.formatting.stylua
end

return M
