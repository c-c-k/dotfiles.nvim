local my = require "my"
---@class my.ft.godot
local M = {}

M.a0_init = function()
  local setups = my.g.filetype_setup_autocmds
  setups[#setups + 1] = M.autocmds.filetype_setup

  local specks = my.g.lazy_filetype_specs
  specks[#specks + 1] = {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = M.opts.gdscript_setup,
  }
  specks[#specks + 1] = {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = M.opts.treesitter_integration,
  }

  specks[#specks + 1] = {
    "mfussenegger/nvim-dap",
    optional = true,
    config = M.opts.dap_setup,
  }
end

M.autocmds = {}
M.autocmds.filetype_setup = function()
  my.autocmd.add_autocmd {
    group = { "my.filetypes", false },
    event = "FileType",
    pattern = "gdscript,gdresource",
    desc = 'Set options, vars and mappings for the "gdscript,gdresource" filetypes',
    callback = function(args)
      if vim.b[args.buf].did_ftplugin_my_godot then return end
      vim.b[args.buf].did_ftplugin_my_godot = true

      vim.opt_local.expandtab = false
      vim.opt_local.textwidth = 0
      vim.opt_local.shiftwidth = 0
      vim.opt_local.softtabstop = 0
      vim.opt_local.tabstop = 4
    end,
  }
end

M.opts = {}
M.opts.dap_setup = function()
  local dap = require "dap"
  dap.adapters.godot = {
    type = "server",
    host = "127.0.0.1",
    port = vim.env.GDScript_Debug_Port or 6006,
  }
  dap.configurations.gdscript = {
    {
      type = "godot",
      request = "launch",
      name = "Launch scene",
      project = "${workspaceFolder}",
      launch_scene = true,
    },
  }
end
M.opts.gdscript_setup = function()
  local gdscript_server_settings = {
    -- gdscript settings placeholder
  }
  my.g.lsp_enable["gdscript"] = true
  local config = vim.lsp.config["gdscript"] ---@type vim.lsp.Config
  vim.lsp.config["gdscript"] = my.tbl.merge_dicts_into_first(config, {
    settings = { gdscript = gdscript_server_settings },
  } --[[@as vim.lsp.Config]])
end
M.opts.treesitter_integration = function(_, opts)
  if opts.ensure_installed ~= "all" then
    opts.ensure_installed =
      my.tbl.merge_lists_into_first(opts.ensure_installed, { "gdscript", "glsl", "godot_resource" })
  end
end

return M
