local my = require "my"
---@class my.ft.lua
local M = {}

M.a0_init = function()
  local setups = my.g.filetype_setup_autocmds
  setups[#setups + 1] = M.autocmds.filetype_setup

  local specks = my.g.lazy_filetype_specs
  specks[#specks + 1] = {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = M.opts.lua_ls_setup,
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
  specks[#specks + 1] = {
    "folke/lazydev.nvim",
    optional = true,
    dependencies = { "neovim/nvim-lspconfig", optional = true },
    opts = M.opts.lazydev_general,
  }
  specks[#specks + 1] = {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "nvim-neotest/neotest-plenary", optional = true },
    opts = M.opts.neotest_plenary_neotest_integration,
  }
  specks[#specks + 1] = {
    "danymat/neogen",
    optional = true,
    opts = M.opts.neogen_integration,
  }
end

M.autocmds = {}
M.autocmds.filetype_setup = function()
  my.autocmd.add_autocmd {
    group = { "my.filetypes", false },
    event = "FileType",
    pattern = "lua",
    desc = 'Set options, vars and mappings for the "lua" filetype',
    callback = function(args)
      if vim.b[args.buf].did_ftplugin_my_lua then return end
      vim.b[args.buf].did_ftplugin_my_lua = true

      vim.opt_local.textwidth = 0
      vim.opt_local.shiftwidth = 2
      vim.opt_local.softtabstop = 2
    end,
  }
end

M.opts = {}
M.opts.lua_ls_setup = function()
  local lua_ls_server_settings = {
    hint = {
      enable = true,
      arrayIndex = "Disable",
    },
  }
  my.g.lsp_enable["lua_ls"] = true
  local config = vim.lsp.config["lua_ls"] ---@type vim.lsp.Config
  vim.lsp.config["lua_ls"] = my.tbl.merge_dicts_into_first(config, {
    settings = { Lua = lua_ls_server_settings },
  } --[[@as vim.lsp.Config]])
end
M.opts.lazydev_general = function(_, opts)
  opts.library = my.tbl.merge_dicts_into_first(opts.library, {
    "lazy.nvim",
    { path = "luvit-meta/library", words = { "vim%.uv" } },
  })
end
M.opts.mason_tool_installer_integration = function(_, opts)
  opts.ensure_installed = my.tbl.merge_lists_into_first(opts.ensure_installed, {
    "lua-language-server",
    "stylua",
    "selene",
  })
end
M.opts.neogen_integration = function(_, opts)
  opts.languages = my.tbl.merge_dicts_into_last(opts.languages, {
    -- lua = { template = { annotation_convention = "ldoc" } },
    lua = { template = { annotation_convention = "emmylua" } },
  })
end
M.opts.neotest_plenary_neotest_integration = function(_, opts)
  local adapter = require "neotest-plenary" {
    -- adapter opts placeholder
  }
  table.insert(opts.adapters, adapter)
end
M.opts.treesitter_integration = function(_, opts)
  if opts.ensure_installed ~= "all" then
    opts.ensure_installed = my.tbl.merge_lists_into_first(opts.ensure_installed, { "lua", "luap" })
  end
end

return M
