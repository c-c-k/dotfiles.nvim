local my = require "my"
local null_spec = my.config.lazy_nvim.null_spec
---@class my.ft.python
local M = {}

M.a0_init = function()
  local specks = my.g.lazy_filetype_specs
  specks[#specks + 1] = {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = M.opts.pylsp_setup,
  }
  specks[#specks + 1] = {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = M.opts.ruff_setup,
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
    "mfussenegger/nvim-dap-python",
    optional = true,
    config = M.opts.dap_python_setup,
  }
  specks[#specks + 1] = {
    "linux-cultist/venv-selector.nvim",
    optional = true,
    dependencies = { "neovim/nvim-lspconfig" },
    config = true,
    specs = { null_spec { opts = M.opts.venv_selector_core_integration } },
  }
  specks[#specks + 1] = {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "nvim-neotest/neotest-python", optional = true },
    opts = M.opts.neotest_python_neotest_integration,
  }
  specks[#specks + 1] = {
    "danymat/neogen",
    optional = true,
    opts = M.opts.neogen_integration,
  }
end

M.opts = {}
M.opts.dap_python_setup = function(_, opts)
  local debugpy = require("mason-registry").get_package "debugpy"
  if debugpy:is_installed() then
    local path = vim.fn.expand "$MASON/packages/debugpy/venv/bin/python"
    require("dap-python").setup(path, opts)
  else
    local msg = "`debugpy` missing, Python DAP integration disabled"
    my.notify.warn(msg, { title = "LSP setup" })
  end
end
M.opts.mason_tool_installer_integration = function(_, opts) --
  opts.ensure_installed = my.tbl.merge_lists_into_first(opts.ensure_installed, {
    "debugpy",
    "mypy",
    "python-lsp-server",
    "ruff",
  })
end
M.opts.neogen_integration = function(_, opts)
  opts.languages = my.tbl.merge_dicts_into_last(opts.languages, {
    -- python = { template = { annotation_convention = "google_docstrings" } },
    -- python = { template = { annotation_convention = "numpydoc" } },
    python = { template = { annotation_convention = "reST" } },
  })
end
M.opts.neotest_python_neotest_integration = function(_, opts) --
  local adapter = require "neotest-python" {
    -- adapter opts placeholder
  }
  table.insert(opts.adapters, adapter)
end
M.opts.pylsp_setup = function()
  local pylsp_server_settings = {
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
  my.g.lsp_enable["pylsp"] = true
  local config = vim.lsp.config["pylsp"] ---@type vim.lsp.Config
  vim.lsp.config["pylsp"] = my.tbl.merge_dicts_into_first(config, {
    settings = { pylsp = pylsp_server_settings },
  } --[[@as vim.lsp.Config]])
end
M.opts.ruff_setup = function()
  local ruff_server_settings = {
    -- ruff server settings placeholder
  }
  my.g.lsp_enable["ruff"] = true
  local config = vim.lsp.config["ruff"] ---@type vim.lsp.Config
  vim.lsp.config["ruff"] = my.tbl.merge_dicts_into_first(config, {
    on_attach = function(client, bufnr) --
      if config.on_attach then config.on_attach(client, bufnr) end
      client.server_capabilities.hoverProvider = false
    end,
    settings = { ruff = ruff_server_settings },
  } --[[@as vim.lsp.Config]])
end
M.opts.treesitter_integration = function(_, opts)
  if opts.ensure_installed ~= "all" then
    opts.ensure_installed = my.tbl.merge_lists_into_first(opts.ensure_installed, { "python" })
  end
end
M.opts.venv_selector_core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_venvslct)
end

M.keymaps = {}

M.keymaps.select_virtualenv = { ---@type my.keymap.keymap_spec
  desc = "Select VirtualEnv",
  rhs = "<CMD>VenvSelect<CR>",
}

return M
