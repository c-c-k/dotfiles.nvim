local my = require "my"
---@class my.ft.go
local M = {}

M.a0_init = function()
  local setups = my.g.filetype_setup_autocmds
  setups[#setups + 1] = M.autocmds.filetype_setup

  local specks = my.g.lazy_filetype_specs
  specks[#specks + 1] = {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = M.opts.gopls_setup,
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
    "leoluz/nvim-dap-go",
    optional = true,
    config = M.opts.dap_go_setup,
  }
  specks[#specks + 1] = {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "fredrikaverpil/neotest-golang", optional = true },
    opts = M.opts.neotest_go_neotest_integration,
  }
  specks[#specks + 1] = {
    "olexsmir/gopher.nvim",
    optional = true,
    config = true,
    dependencies = { "neovim/nvim-lspconfig", optional = true },
  }
  specks[#specks + 1] = {
    "nvim-mini/mini.icons",
    optional = true,
    opts = M.opts.mini_icons_integration,
  }
end

M.autocmds = {}
M.autocmds.filetype_setup = function()
  my.autocmd.add_autocmd {
    group = { "my.filetypes", false },
    event = "FileType",
    pattern = "go,gomod,gowork",
    desc = 'Set options, vars and mappings for the "go,gomod,gowork" filetypes',
    callback = function(args)
      if vim.b[args.buf].did_ftplugin_my_go then return end
      vim.b[args.buf].did_ftplugin_my_go = true

      vim.opt_local.expandtab = false
      vim.opt_local.textwidth = 0
      vim.opt_local.shiftwidth = 0
      vim.opt_local.softtabstop = 0
      vim.opt_local.tabstop = 2
    end,
  }
end

M.opts = {}
M.opts.dap_go_setup = function()
  local delve = require("mason-registry").get_package "delve"
  if not delve:is_installed() then
    local msg = "`delve` missing, go DAP integration disabled"
    my.notify.warn(msg, { title = "LSP setup" })
  end
end
M.opts.gopher_build = function()
  if not require("lazy.core.config").spec.plugins["mason.nvim"] then
    vim.print "Installing go dependencies..."
    vim.cmd.GoInstallDeps()
  end
end
M.opts.gopls_setup = function()
  local gopls_server_settings = {
    analyses = {
      ST1003 = true,
      fieldalignment = false,
      fillreturns = true,
      nilness = true,
      nonewvars = true,
      shadow = true,
      undeclaredname = true,
      unreachable = true,
      unusedparams = true,
      unusedwrite = true,
      useany = true,
    },
    codelenses = {
      generate = true, -- show the `go generate` lens.
      regenerate_cgo = true,
      test = true,
      tidy = true,
      upgrade_dependency = true,
      vendor = true,
    },
    hints = {
      assignVariableTypes = true,
      compositeLiteralFields = true,
      compositeLiteralTypes = true,
      constantValues = true,
      functionTypeParameters = true,
      parameterNames = true,
      rangeVariableTypes = true,
    },
    buildFlags = { "-tags", "integration" },
    completeUnimported = true,
    diagnosticsDelay = "500ms",
    gofumpt = true,
    matcher = "Fuzzy",
    semanticTokens = true,
    staticcheck = true,
    symbolMatcher = "fuzzy",
    usePlaceholders = true,
  }
  my.g.lsp_enable["gopls"] = true
  local config = vim.lsp.config["gopls"] ---@type vim.lsp.Config
  vim.lsp.config["gopls"] = my.tbl.merge_dicts_into_first(config, {
    settings = { gopls = gopls_server_settings },
  } --[[@as vim.lsp.Config]])
end
M.opts.mason_tool_installer_integration = function(_, opts)
  opts.ensure_installed = my.tbl.merge_lists_into_first(
    opts.ensure_installed,
    { "delve", "gopls", "gomodifytags", "gotests", "iferr", "impl", "goimports" }
  )
end
M.opts.mini_icons_integration = function(_, opts)
  return my.tbl.merge_dicts_into_first(opts, {
    file = {
      [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
    },
    filetype = {
      gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
    },
  })
end
M.opts.neotest_go_neotest_integration = function(_, opts) --
  local adapter = require "neotest-golang" {
    -- adapter opts placeholder
  }
  table.insert(opts.adapters, adapter)
end
M.opts.treesitter_integration = function(_, opts)
  if opts.ensure_installed ~= "all" then
    opts.ensure_installed = my.tbl.merge_lists_into_first(opts.ensure_installed, { "go", "gomod", "gosum", "gowork" })
  end
end

return M
