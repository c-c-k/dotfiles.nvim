return {
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = {
      config = {
        lua_ls = { settings = { Lua = { hint = { enable = true, arrayIndex = "Disable" } } } },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "lua", "luap" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "lua_ls" })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "stylua", "selene" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "lua-language-server", "stylua", "selene" })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        lua = { "selene" },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "nvim-neotest/neotest-plenary", config = function() end },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-plenary"(require("astrocore").plugin_opts "neotest-plenary"))
    end,
  },
  {
    "danymat/neogen",
    optional = true,
    opts = function(_, opts)
      opts.languages = require("astrocore").extend_tbl(opts.languages or {}, {
        -- lua = { template = { annotation_convention = "ldoc" } },
        lua = { template = { annotation_convention = "emmylua" } },
      })
    end,
  },
}
