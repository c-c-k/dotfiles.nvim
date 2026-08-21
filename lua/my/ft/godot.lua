---@class MyFtGodot
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.filetypes = function()
  local autocmds = my.config.setup_filetype_autocmds
  local lsp = my.config.setup_lsp_configs
  local mason_ensure_installed = my.config.mason_ensure_installed
  local null_ls = my.config.null_ls_sources
  local specks = my.config.lzsetup_plugin_specs
  local ts_ensure_installed = my.config.ts_ensure_installed

  autocmds[#autocmds + 1] = M._autocmd_filetype_setup

  ts_ensure_installed["gdscript"] = true
  ts_ensure_installed["glsl"] = true
  ts_ensure_installed["godot_resource"] = true

  lsp[#lsp + 1] = { M._lspconfig_gdscript, true }

  mason_ensure_installed["gdtoolkit"] = true
  null_ls["gdformat"] = M._null_ls_gdformat
  null_ls["gdlint"] = M._null_ls_gdlint

  specks[#specks + 1] = M._spec_dap_integration
end

M._autocmd_filetype_setup = function()
  my.autocmd.add_autocmd {
    group = { "my.filetypes", false },
    event = "FileType",
    pattern = "gdscript,gdresource",
    desc = 'Set options, vars and mappings for the "gdscript,gdresource" filetypes',
    callback = function(ev)
      local buf_id = ev.buf
      local did_ftplugin = my.config.did_ftplugin_buf[buf_id]
      if did_ftplugin == "godot" then return end
      my.config.did_ftplugin_buf[buf_id] = "godot"

      vim.opt_local.expandtab = false
      vim.opt_local.textwidth = 0
      vim.opt_local.shiftwidth = 0
      vim.opt_local.softtabstop = 0
      vim.opt_local.tabstop = 4
    end,
  }
end

M._lspconfig_gdscript = function(enable)
  local config_name = "gdscript"
  local server_name = "gdscript"

  local server_settings = {
    -- gdscript settings placeholder
  }

  -- local old_config = vim.lsp.config[config_name]
  local new_config = { ---@type vim.lsp.Config
    name = config_name,
    settings = { [server_name] = server_settings },
  }

  my.lsp.lspconfig.apply_lsp_config(new_config, enable)
end

M._null_ls_gdlint = function(null_ls) --
  return null_ls.builtins.diagnostics.gdlint
end

M._null_ls_gdformat = function(null_ls) --
  return null_ls.builtins.formatting.gdformat
end

M._spec_dap_integration = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["nvim-dap"],
    opts = {
      adapters = {
        godot = {
          type = "server",
          host = "127.0.0.1",
          port = vim.env.GDScript_Debug_Port or 6006,
        },
      },
      configurations = {
        gdscript = {
          {
            type = "godot",
            request = "launch",
            name = "Launch scene",
            project = "${workspaceFolder}",
            launch_scene = true,
          },
        },
      },
    },
  }
  return spec
end

return M
