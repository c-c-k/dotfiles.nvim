---@class MyFtGo
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.filetypes = function()
  local autocmds = my.config.setup_filetype_autocmds
  local lsp = my.config.setup_lsp_configs
  -- local mason_ensure_installed = my.config.mason_ensure_installed
  local specks = my.config.lzsetup_plugin_specs
  local ts_ensure_installed = my.config.ts_ensure_installed

  autocmds[#autocmds + 1] = M._autocmd_filetype_setup

  ts_ensure_installed["go"] = true
  ts_ensure_installed["gomod"] = true
  ts_ensure_installed["gosum"] = true
  ts_ensure_installed["gowork"] = true

  -- mason_ensure_installed["gopls"] = true
  lsp[#lsp + 1] = { M._lspconfig_gopls, true }

  -- mason_ensure_installed["delve"] = true
  specks[#specks + 1] = M._spec_dap_go

  -- mason_ensure_installed["gomodifytags"] = true
  -- mason_ensure_installed["gotests"] = true
  -- mason_ensure_installed["iferr"] = true
  -- mason_ensure_installed["impl"] = true
  -- mason_ensure_installed["goimports"] = true
  specks[#specks + 1] = M._spec_gopher

  specks[#specks + 1] = M._spec_mini_icons_integration
end

M._autocmd_filetype_setup = function()
  my.autocmd.add_autocmd {
    group = { "my.filetypes", false },
    event = "FileType",
    pattern = "go,gomod,gowork",
    desc = 'Set options, vars and mappings for the "go,gomod,gowork" filetypes',
    callback = function(ev)
      local buf_id = ev.buf
      local did_ftplugin = my.config.did_ftplugin_buf[buf_id]
      if did_ftplugin == "go" then return end
      my.config.did_ftplugin_buf[buf_id] = "go"

      vim.opt_local.expandtab = false
      vim.opt_local.textwidth = 0
      vim.opt_local.shiftwidth = 0
      vim.opt_local.softtabstop = 0
      vim.opt_local.tabstop = 2
    end,
  }
end

M._lspconfig_gopls = function(enable)
  local config_name = "gopls"
  local server_name = "gopls"

  local server_settings = {
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

  -- local old_config = vim.lsp.config[config_name]
  local new_config = { ---@type vim.lsp.Config
    name = config_name,
    settings = { [server_name] = server_settings },
  }

  my.lsp.lspconfig.apply_lsp_config(new_config, enable)
end

M._spec_dap_go = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["nvim-dap-go"],
    lazy = true,
    ft = "go",
    config = function(_, opts)
      -- local delve = require("mason-registry").get_package "delve"
      -- if not delve:is_installed() then

      if not require("mason-registry").is_installed "delve" then
        local msg = "`delve` missing, go DAP integration disabled"
        my.notify.warn(msg, { title = "LSP setup" })
        return
      end

      require("dap-go").setup(opts)
    end,
    dependencies = { make_lzspec { source = plugins["nvim-dap"], optional = false } },
  }
  return spec
end

M._spec_gopher = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["gopher.nvim"],
    lazy = true,
    ft = "go",
    build = function()
      if not require("lazy.core.config").spec.plugins["mason.nvim"] then
        vim.print "Installing go dependencies..."
        vim.cmd.GoInstallDeps()
      end
    end,
    config = true,
    dependencies = {
      make_lzspec { source = plugins["plenary.nvim"], optional = false },
      make_lzspec { source = plugins["nvim-treesitter"], optional = false },
      make_lzspec(plugins["nvim-lspconfig"]),
    },
  }
  return spec
end

M._spec_mini_icons_integration = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["mini.icons"],
    opts = {
      file = {
        [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
      },
    },
  }
  return spec
end

return M
