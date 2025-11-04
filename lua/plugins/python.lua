local lsp_settings_pylsp = {
  pylsp = {
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
  },
}

---@type LazyPluginSpec
local spec_astrolsp = {
  "AstroNvim/astrolsp",
  optional = true,
  ---@type AstroLSPOpts
  opts = {
    ---@diagnostic disable: missing-fields
    config = {
      ruff = {
        on_attach = function(client) client.server_capabilities.hoverProvider = false end,
      },
      pylsp = {
        settings = lsp_settings_pylsp,
      },
    },
  },
}

---@type LazyPluginSpec
local spec_nvim_treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = function(_, opts)
    if opts.ensure_installed ~= "all" then
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "python", "toml" })
    end
  end,
}

---@type LazyPluginSpec
local spec_mason_tool_installer_nvim = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  optional = true,
  opts = function(_, opts)
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "debugpy",
      "mypy",
      "python-lsp-server",
      "ruff",
    })
  end,
}

---@type LazyPluginSpec
local spec_nvim_dap = {
  "mfussenegger/nvim-dap",
}

---@type LazyPluginSpec
local spec_nvim_dap_python = {
  "mfussenegger/nvim-dap-python",
  dependencies = "mfussenegger/nvim-dap",
  ft = "python", -- NOTE: ft: lazy-load on filetype
  config = function(_, opts)
    local path = vim.fn.exepath "python"
    local debugpy = require("mason-registry").get_package "debugpy"
    if debugpy:is_installed() then
      path = vim.fn.expand "$MASON/packages/debugpy"
      if vim.fn.has "win32" == 1 then
        path = path .. "/venv/Scripts/python"
      else
        path = path .. "/venv/bin/python"
      end
    end
    require("dap-python").setup(path, opts)
  end,
}

---@type LazyPluginSpec
local spec_neotest = {
  "nvim-neotest/neotest",
  optional = true,
  opts = function(_, opts)
    local neotest_python_opts = require "neotest-python"(require("astrocore").plugin_opts "neotest-python")
    if neotest_python_opts ~= nil then
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, neotest_python_opts)
    end
  end,
}

---@type LazyPluginSpec
local spec_neotest__neotest_python = {
  "nvim-neotest/neotest-python",
  dependencies = { "nvim-neotest/neotest" },
  config = function() end,
}

---@type LazyPluginSpec
local spec_neogen = {
  "danymat/neogen",
  optional = true,
  opts = function(_, opts)
    opts.languages = require("astrocore").extend_tbl(opts.languages or {}, {
      -- python = { template = { annotation_convention = "google_docstrings" } },
      -- python = { template = { annotation_convention = "numpydoc" } },
      python = { template = { annotation_convention = "reST" } },
    })
  end,
}

---@type LazyPluginSpec
local spec_venv_selector_nvim = {
  "linux-cultist/venv-selector.nvim",
  enabled = vim.fn.executable "fd" == 1 or vim.fn.executable "fdfind" == 1 or vim.fn.executable "fd-find" == 1,
  cmd = "VenvSelect",
  opts = {},
}

---@type LazyPluginSpec
local spec_venv_selector_nvim__astrocore = {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      n = {
        ["<Leader>lv"] = { "<Cmd>VenvSelect<CR>", desc = "Select VirtualEnv" },
      },
    },
  },
}

spec_venv_selector_nvim.specs = {
  spec_venv_selector_nvim__astrocore,
}
spec_nvim_dap.specs = {
  spec_nvim_dap_python,
}
spec_neotest.specs = {
  spec_neotest__neotest_python,
}

---@type LazyPluginSpec[]
return {
  spec_astrolsp,
  spec_nvim_treesitter,
  spec_mason_tool_installer_nvim,
  spec_nvim_dap,
  spec_neotest,
  spec_neogen,
  spec_venv_selector_nvim,
}
