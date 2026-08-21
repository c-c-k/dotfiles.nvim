local my = require "my"

local ACTIVE_PLUGIN = true
local ACTIVE_PLUGIN_COND = true
local INACTIVE_PLUGIN = true
local INACTIVE_PLUGIN_COND = false
local DISABLED_PLUGIN = false
local DISABLED_PLUGIN_COND = false

---@class MySetupPluginsManifest
local plugins_manifest = {
  ["aerial.nvim"] = {
    -- nvim help: `:help aerial`
    url = "https://github.com/stevearc/aerial.nvim",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["blink.cmp"] = {
    -- nvim help: `:help blink`
    url = "https://github.com/saghen/blink.cmp",
    version = "1.*",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["crates.nvim"] = {
    -- nvim help: `:help crates.nvim`
    url = "https://github.com/Saecki/crates.nvim",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["friendly-snippets"] = {
    -- nvim help: ``
    url = "https://github.com/rafamadriz/friendly-snippets",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["gitsigns.nvim"] = {
    -- nvim help: `:help gitsigns`
    url = "https://github.com/lewis6991/gitsigns.nvim",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["gopher.nvim"] = {
    -- nvim help: `:help gopher.nvim`
    url = "https://github.com/olexsmir/gopher.nvim",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["lualine.nvim"] = {
    -- nvim help: `:help lualine.txt`
    url = "https://github.com/nvim-lualine/lualine.nvim",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["leap.nvim"] = {
    -- nvim help: `:help leat.txt`
    url = "https://codeberg.org/andyg/leap.nvim",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["LuaSnip"] = {
    -- nvim help: `:help luasnip.txt`
    url = "https://github.com/L3MON4D3/LuaSnip",
    version = "v2.*",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["mason.nvim"] = {
    -- nvim help: `:help mason.nvim`
    url = "https://github.com/williamboman/mason.nvim",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["mini.files"] = {
    -- nvim help: `:help mini.files`
    url = "https://github.com/nvim-mini/mini.files",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["mini.icons"] = {
    -- nvim help: `:help mini.icons`
    url = "https://github.com/nvim-mini/mini.icons",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["none-ls"] = {
    -- nvim help: `:help null-ls.txt`
    url = "https://github.com/nvimtools/none-ls.nvim",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["nvim-autopairs"] = {
    -- nvim help: `:help nvim-autopairs.txt`
    url = "https://github.com/windwp/nvim-autopairs",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["nvim-dap"] = {
    -- nvim help: `:help dap.txt`
    url = "https://github.com/mfussenegger/nvim-dap",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["nvim-dap-go"] = {
    -- nvim help: `:help dap-go`
    url = "https://github.com/leoluz/nvim-dap-go",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["nvim-dap-python"] = {
    -- nvim help: `:help dap-python`
    url = "https://github.com/mfussenegger/nvim-dap-python",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["nvim-dap-ui"] = {
    -- nvim help: `:help nvim-dap-ui`
    url = "https://github.com/rcarriga/nvim-dap-ui",
    enabled = INACTIVE_PLUGIN,
    cond = INACTIVE_PLUGIN_COND,
  },

  ["nvim-dap-view"] = {
    -- nvim help: `:help nvim-dap-view`
    url = "https://github.com/igorlfs/nvim-dap-view",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["nvim-lspconfig"] = {
    -- nvim help: `:help lspconfig`
    url = "https://github.com/neovim/nvim-lspconfig",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["nvim-lsp-file-operations"] = {
    -- nvim help: `:help nvim-lsp-file-operations`
    url = "https://github.com/antosha417/nvim-lsp-file-operations",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["nvim-surround"] = {
    -- nvim help: `:help nvim-surround.txt`
    url = "https://github.com/kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["nvim-treesitter"] = {
    -- nvim help: `:help nvim-treesitter`
    url = "https://github.com/nvim-treesitter/nvim-treesitter",
    branch = "main",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["nvim-treesitter-textobjects"] = {
    -- nvim help: `:help nvim-treesitter-textobjects`
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["oil.nvim"] = {
    -- nvim help: `:help oil.nvim`
    url = "https://github.com/stevearc/oil.nvim",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["plenary.nvim"] = {
    -- nvim help: `:help plenary-test`
    url = "https://github.com/nvim-lua/plenary.nvim",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["promise-async"] = {
    -- nvim help: ``
    url = "https://github.com/kevinhwang91/promise-async",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["resession.nvim"] = {
    -- nvim help: `:help resession.nvim`
    url = "https://github.com/stevearc/resession.nvim.git",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["rustaceanvim"] = {
    -- nvim help: `:help rustaceanvim.contents`
    url = "https://github.com/mrcjkb/rustaceanvim",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["snacks-nvim"] = {
    -- nvim help: `:help snacks.nvim.txt`
    url = "https://github.com/folke/snacks.nvim",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
    opts = { ---@type snacks.Config
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      dashboard = { enabled = false },
      debug = { enabled = true },
      indent = { enabled = true },
      notifier = { enabled = true },
      picker = { enabled = true },
      toggle = { enabled = true },
    },
  },

  ["solarized-osaka.nvim"] = {
    -- nvim help: `:help solarized-osaka.nvim.txt`
    url = "https://github.com/craftzdog/solarized-osaka.nvim",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["tabular"] = {
    -- nvim help: `:help tabular`
    url = "https://github.com/godlygeek/tabular",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["nvim-ufo"] = {
    -- nvim help: `:help ufo`
    url = "https://github.com/kevinhwang91/nvim-ufo",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["venv-selector.nvim"] = {
    -- nvim help: `:help venv-selector.nvim-recent-news`
    url = "https://github.com/linux-cultist/venv-selector.nvim",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["vim-fugitive"] = {
    -- nvim help: `:help fugitive`
    url = "https://github.com/tpope/vim-fugitive",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["vim-illuminate"] = {
    -- nvim help: `:help illuminate.txt`
    url = "https://github.com/RRethy/vim-illuminate",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["vim-repeat"] = {
    -- nvim help: ``
    url = "https://github.com/tpope/vim-repeat",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },

  ["which-key.nvim"] = {
    -- nvim help: `:help vim-rest-console`
    url = "https://github.com/folke/which-key.nvim",
    enabled = ACTIVE_PLUGIN,
    cond = ACTIVE_PLUGIN_COND,
  },
}

my.config.lzplugins_manifest = plugins_manifest

local specs = my.tbl.values(plugins_manifest)

my.config.lzsetup_plugin_specs = specs
