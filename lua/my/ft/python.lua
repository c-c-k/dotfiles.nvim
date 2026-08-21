---@class MyFtPython
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.filetypes = function()
  -- local autocmds = my.config.setup_filetype_autocmds
  local lsp = my.config.setup_lsp_configs
  local mason_ensure_installed = my.config.mason_ensure_installed
  local null_ls = my.config.null_ls_sources
  local specks = my.config.lzsetup_plugin_specs
  local ts_ensure_installed = my.config.ts_ensure_installed

  ts_ensure_installed["python"] = true

  mason_ensure_installed["python-lsp-server"] = true
  lsp[#lsp + 1] = { M._lspconfig_pylsp, false }

  mason_ensure_installed["ruff"] = true
  lsp[#lsp + 1] = { M._lspconfig_ruff, true }

  mason_ensure_installed["mypy"] = true
  null_ls["mypy"] = M._null_ls_mypy

  mason_ensure_installed["debugpy"] = true
  specks[#specks + 1] = M._spec_dap_python_integration

  specks[#specks + 1] = M._spec_venv_selector
end

M._lspconfig_pylsp = function(enable)
  local config_name = "pylsp"
  local server_name = "pylsp"

  local server_settings = {
    plugins = {
      autopep8 = { enabled = false },
      flake8 = { enabled = false },
      mccabe = { enabled = false },
      -- preload = { enabled = false },
      pycodestyle = { enabled = false },
      pydocstyle = { enabled = false },
      pyflakes = { enabled = false },
      pylint = { enabled = false },
      rope_autoimport = { enabled = false },
      rope_completion = { enabled = false },
      yapf = { enabled = false },
    },
    signature = { formatter = "ruff" },
  }

  -- local old_config = vim.lsp.config[config_name]
  local new_config = { ---@type vim.lsp.Config
    name = config_name,
    settings = { [server_name] = server_settings },
  }

  my.lsp.lspconfig.apply_lsp_config(new_config, enable)
end

M._lspconfig_ruff = function(enable)
  local config_name = "ruff"
  local server_name = "ruff"

  local server_settings = {
    -- ruff server settings placeholder
  }

  local old_config = vim.lsp.config[config_name]
  local new_config = { ---@type vim.lsp.Config
    name = config_name,
    on_attach = function(client, buf_id) --
      if old_config.on_attach then old_config.on_attach(client, buf_id) end
      client.server_capabilities.hoverProvider = false
    end,
    settings = { [server_name] = server_settings },
  }

  my.lsp.lspconfig.apply_lsp_config(new_config, enable)
end

M._null_ls_mypy = function(null_ls) --
  return null_ls.builtins.diagnostics.mypy
end

M._spec_dap_python_integration = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["nvim-dap-python"],
    lazy = true,
    ft = "python",
    config = function(_, opts)
      -- local debugpy = require("mason-registry").get_package "debugpy"
      -- if debugpy:is_installed() then

      if not require("mason-registry").is_installed "debugpy" then
        local _msg = "`debugpy` missing, Python DAP integration disabled"
        my.notify.warn(_msg, { title = "LSP setup" })
        return
      end

      local path = vim.fn.expand "$MASON/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path, opts)
    end,
    dependencies = { make_lzspec { source = plugins["nvim-dap"], optional = false } },
  }
  return spec
end

M._spec_venv_selector = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["venv-selector.nvim"],
    lazy = true,
    cmd = "VenvSelect",
    config = function(_, opts)
      local venv_selector = require "venv-selector"
      venv_selector.setup(opts)
      my.keymap.queue_km_group_load(my.config.keymaps.g_venvslct)
    end,
    dependencies = { make_lzspec(plugins["nvim-lspconfig"]) },
  }
  return spec
end

M.keymaps = {}

M.keymaps.select_virtualenv = { ---@type MyKeymapKeymapSpec
  desc = "Select VirtualEnv",
  rhs = "<CMD>VenvSelect<CR>",
}

return M
