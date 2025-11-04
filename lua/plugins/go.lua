local lsp_settings_gopls = {
  gopls = {
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
  },
}

---@type LazyPluginSpec
local spec_astrolsp = {
  "AstroNvim/astrolsp",
  optional = true,
  ---@type AstroLSPOpts
  opts = {
    ---@diagnostic disable-next-line: missing-fields
    config = {
      gopls = {
        settings = lsp_settings_gopls,
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
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "go", "gomod", "gosum", "gowork" })
    end
  end,
}

---@type LazyPluginSpec
local spec_mason_tool_installer_nvim = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  optional = true,
  opts = function(_, opts)
    opts.ensure_installed = require("astrocore").list_insert_unique(
      opts.ensure_installed,
      { "delve", "gopls", "gomodifytags", "gotests", "iferr", "impl", "goimports" }
    )
  end,
}

---@type LazyPluginSpec
local spec_nvim_dap = {
  "leoluz/nvim-dap",
}

---@type LazyPluginSpec
local spec_nvim_dap__nvim_dap_go = {
  "leoluz/nvim-dap-go",
  ft = "go",
  dependencies = {
    "mfussenegger/nvim-dap",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  opts = {},
}

---@type LazyPluginSpec
local spec_nvim_dap_go__mason_tool_installer = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = function(_, opts)
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "delve" })
  end,
}

---@type LazyPluginSpec
local spec_neotest = {
  "nvim-neotest/neotest",
  optional = true,
  dependencies = { "fredrikaverpil/neotest-golang" },
  opts = function(_, opts)
    if not opts.adapters then opts.adapters = {} end
    table.insert(opts.adapters, require "neotest-golang"(require("astrocore").plugin_opts "neotest-golang"))
  end,
}

---@type LazyPluginSpec
local spec_mini_icons = {
  "nvim-mini/mini.icons",
  optional = true,
  opts = {
    file = {
      [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
    },
    filetype = {
      gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
    },
  },
}

---@type LazyPluginSpec
local spec_gopher_nvim = {
  "olexsmir/gopher.nvim",
  ft = "go",
  build = function()
    if not require("lazy.core.config").spec.plugins["mason.nvim"] then
      vim.print "Installing go dependencies..."
      vim.cmd.GoInstallDeps()
    end
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "williamboman/mason.nvim", -- by default use Mason for go dependencies
  },
  opts = {},
}

spec_nvim_dap.specs = {
  spec_nvim_dap__nvim_dap_go,
}
spec_nvim_dap__nvim_dap_go.specs = {
  spec_nvim_dap_go__mason_tool_installer,
}

---@type LazyPluginSpec[]
return {
  spec_astrolsp,
  spec_nvim_treesitter,
  spec_mason_tool_installer_nvim,
  spec_nvim_dap,
  spec_neotest,
  spec_mini_icons,
  spec_gopher_nvim,
}
