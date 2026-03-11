local my = require "my"
local null_spec = my.config.lazy_nvim.null_spec
---@type LazyPluginSpec[]
local M = {}

local ACTIVE_PLUGIN = true
local ACTIVE_PLUGIN_COND = true
local INACTIVE_PLUGIN = true
local INACTIVE_PLUGIN_COND = false
local DISABLED_PLUGIN = false
local DISABLED_PLUGIN_COND = false
local INSPIRATION_PLUGIN = true
local INSPIRATION_PLUGIN_COND = false

-- # My Zettelkasten/PKMS/PKB/Second Brain/Notebook
M[#M + 1] = null_spec { opts = my.pkms.opts.general }

M[#M + 1] = {
  -- # Aerial-nvim
  -- repo url: <https://github.com/stevearc/aerial.nvim>
  -- nvim help: `:help aerial`
  "stevearc/aerial.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  specs = { null_spec { opts = my.ui.aerial.opts.core_integration } },
}

M[#M + 1] = {
  -- # Astrocommunity
  -- repo url: <https://github.com/AstroNvim/astrocommunity>
  -- nvim help: `:help astrocommunity-setup`
  "AstroNvim/astrocommunity",
  enabled = INSPIRATION_PLUGIN,
  cond = INSPIRATION_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Astrocore
  -- repo url: <https://github.com/AstroNvim/astrocore>
  -- nvim help: `:help astrocore`
  "AstroNvim/astrocore",
  enabled = INSPIRATION_PLUGIN,
  cond = INSPIRATION_PLUGIN_COND,
  lazy = false,
  priority = 10000,
}

M[#M + 1] = {
  -- # Astrolsp
  -- repo url: <https://github.com/AstroNvim/astrolsp>
  -- nvim help: `:help astrolsp`
  "AstroNvim/astrolsp",
  enabled = INSPIRATION_PLUGIN,
  cond = INSPIRATION_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Astronvim
  -- repo url: <https://github.com/AstroNvim/AstroNvim>
  -- nvim help: `:help astronvim-preview`
  "AstroNvim/AstroNvim",
  enabled = INSPIRATION_PLUGIN,
  cond = INSPIRATION_PLUGIN_COND,
  lazy = false,
  -- version = "^5", -- Remove version tracking to elect for nightly AstroNvim
}

M[#M + 1] = {
  -- # Astrotheme
  -- repo url: <https://github.com/AstroNvim/astrotheme>
  -- nvim help: `:help astrotheme`
  "AstroNvim/astrotheme",
  enabled = DISABLED_PLUGIN,
  cond = DISABLED_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Astroui
  -- repo url: <https://github.com/AstroNvim/astroui>
  -- nvim help: `:help astroui`
  "AstroNvim/astroui",
  enabled = INSPIRATION_PLUGIN,
  cond = INSPIRATION_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Base16-nvim
  -- repo url: <https://github.com/RRethy/base16-nvim>
  -- nvim help: `:help base16`
  "RRethy/base16-nvim",
  enabled = INACTIVE_PLUGIN,
  cond = INACTIVE_PLUGIN_COND,
  lazy = true,
}

M[#M + 1] = {
  -- # Blink.cmp
  -- repo url: <https://github.com/saghen/blink.cmp>
  -- nvim help: `:help blink`
  "saghen/blink.cmp",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  opts = my.cmp.blink.opts.general,
  specs = { null_spec { opts = my.cmp.blink.opts.core_integration } },
}

M[#M + 1] = {
  -- # Codecompanion.nvim
  -- repo url: <https://github.com/olimorris/codecompanion.nvim>
  -- nvim help: `:help codecompanion.txt`
  "olimorris/codecompanion.nvim",
  enabled = INACTIVE_PLUGIN,
  cond = INACTIVE_PLUGIN_COND,
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
  },
  opts = my.ai.coco.opts.general,
  specs = { null_spec { opts = my.ai.coco.opts.core_integration } },
}

M[#M + 1] = {
  -- # Copilot.vim
  -- repo url: <https://github.com/github/copilot.vim>
  -- nvim help: `:help copilot`
  "github/copilot.vim",
  enabled = INACTIVE_PLUGIN,
  cond = INACTIVE_PLUGIN_COND,
  lazy = false,
  config = my.ai.copilot_vim.opts.config,
}

M[#M + 1] = {
  -- # Crates.nvim
  -- repo url: <https://github.com/Saecki/crates.nvim>
  -- nvim help: `:help crates.nvim`
  "Saecki/crates.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  event = { "BufRead Cargo.toml" },
}

M[#M + 1] = {
  -- # friendly-Snippets
  -- repo url: <https://github.com/rafamadriz/friendly-snippets>
  -- nvim help: ``
  "rafamadriz/friendly-snippets",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
}

M[#M + 1] = {
  -- # Gitsigns.nvim
  -- repo url: <https://github.com/lewis6991/gitsigns.nvim>
  -- nvim help: `:help gitsigns`
  "lewis6991/gitsigns.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  opts = my.git.gitsigns.opts.general,
}

M[#M + 1] = {
  -- # Gopher.nvim
  -- repo url: <https://github.com/olexsmir/gopher.nvim>
  -- nvim help: `:help gopher.nvim`
  "olexsmir/gopher.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  ft = "go",
  build = my.ft.go.opts.gopher_build,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}

M[#M + 1] = {
  -- # Heirline
  -- repo url: <https://github.com/rebelot/heirline.nvim>
  -- nvim help: `:help heirline-about`
  "rebelot/heirline.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Lazydev
  -- repo url: <https://github.com/folke/lazydev.nvim>
  -- nvim help: `:help lazydev.nvim.txt`
  "folke/lazydev.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  cmd = "LazyDev",
}

M[#M + 1] = {
  -- # LazyVim Distro
  -- repo url: <https://github.com/LazyVim/LazyVim>
  -- nvim help: `:help LazyVim.txt`
  "LazyVim/LazyVim",
  enabled = INSPIRATION_PLUGIN,
  cond = INSPIRATION_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Lualine
  -- repo url: <https://github.com/nvim-lualine/lualine.nvim>
  -- nvim help: `:help lualine.txt`
  "nvim-lualine/lualine.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  opts = my.ui.lualine.opts.general,
  dependencies = { "nvim-mini/mini.icons", opts = my.ui.lualine.opts.mini_icons_integration },
}

M[#M + 1] = {
  -- # Leap.nvim
  -- repo url: <https://github.com/ggandor/leap.nvim>
  -- nvim help: `:help leat.txt`
  "ggandor/leap.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  dependencies = {
    "tpope/vim-repeat",
  },
  opts = my.motion.leap.opts.general,
  specs = { null_spec { opts = my.motion.leap.opts.core_integration } },
}

M[#M + 1] = {
  -- # Luasnip
  -- repo url: <https://github.com/L3MON4D3/LuaSnip>
  -- nvim help: `:help luasnip.txt`
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  build = "make install_jsregexp",
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = my.cmp.luasnip.opts.general,
  config = my.cmp.luasnip.opts.config,
}

M[#M + 1] = {
  -- # Luait-Meta
  -- repo url: <https://github.com/Bilal2453/luvit-meta>
  -- nvim help: ``
  "Bilal2453/luvit-meta",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
}

M[#M + 1] = {
  -- # Markdown-nvim
  -- repo url: <https://github.com/tadmccorkle/markdown.nvim>
  -- nvim help: `:help markdown.nvim`
  "tadmccorkle/markdown.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  ft = "markdown",
  -- event = "VeryLazy",
}

M[#M + 1] = {
  -- # Mason.nvim
  -- repo url: <https://github.com/williamboman/mason.nvim>
  -- nvim help: `:help mason.nvim`
  "williamboman/mason.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  config = true,
}

M[#M + 1] = {
  -- # Mason-tool-installer.nvim
  -- repo url: <https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim>
  -- nvim help: `:help mason-tool-installer.nvim-mason-tool-installer`
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  opts = my.lsp.opts.mason_tool_installer_general,
}

M[#M + 1] = {
  -- # Mini.files
  -- repo url: <https://github.com/nvim-mini/mini.files>
  -- nvim help: `:help mini.files`
  "nvim-mini/mini.files",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  opts = my.fs.minifiles.opts.general,
  specs = { null_spec { opts = my.fs.minifiles.opts.core_integration } },
}

M[#M + 1] = {
  -- # Mini.icons
  -- repo url: <https://github.com/nvim-mini/mini.icons>
  -- nvim help: `:help mini.icons`
  "nvim-mini/mini.icons",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  opts = my.ui.icons.opts.mini_icons_general,
  config = my.ui.icons.opts.mini_icons_config,
}

M[#M + 1] = {
  -- # Mkdnflow.nvim
  -- repo url: <https://github.com/jakewvincent/mkdnflow.nvim>
  -- nvim help: `:help Mkdnflow-help`
  "jakewvincent/mkdnflow.nvim",
  enabled = INSPIRATION_PLUGIN,
  cond = INSPIRATION_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Neotest
  -- repo url: <https://github.com/nvim-neotest/neotest>
  -- nvim help: `:help neotest.txt`
  "nvim-neotest/neotest",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = my.testing.neotest.opts.general,
  specs = { null_spec { opts = my.testing.neotest.opts.core_integration } },
}

M[#M + 1] = {
  -- # Neotest-golang
  -- repo url: <https://github.com/fredrikaverpil/neotest-golang>
  -- nvim help: `:help neotest-golang-neotest-golang`
  "fredrikaverpil/neotest-golang",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
}

M[#M + 1] = {
  -- # Neotest-plenary
  -- repo url: <https://github.com/nvim-neotest/neotest-plenary>
  -- nvim help: `:help neotest-plenary-neotest-plenary`
  "nvim-neotest/neotest-plenary",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
}

M[#M + 1] = {
  -- # Neotest-python
  -- repo url: <https://github.com/nvim-neotest/neotest-python>
  -- nvim help: `:help neotest-python-neotest-python`
  "nvim-neotest/neotest-python",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
}

M[#M + 1] = {
  -- # None-ls
  -- repo url: <https://github.com/nvimtools/none-ls.nvim>
  -- nvim help: `:help null-ls.txt`
  "nvimtools/none-ls.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  specs = { null_spec { opts = my.lsp.null_ls.opts.core_integration } },
}

M[#M + 1] = {
  -- # Null-plugin
  -- repo url: N/A
  -- nvim help: N/A
  dir = vim.fn.stdpath "config",
  name = "my",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Nvim-autopairs
  -- repo url: <https://github.com/windwp/nvim-autopairs>
  -- nvim help: `:help nvim-autopairs.txt`
  "windwp/nvim-autopairs",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  specs = { null_spec { opts = my.cmp.autopairs.opts.core_integration } },
}

M[#M + 1] = {
  -- # Nvim-dap
  -- repo url: <https://github.com/mfussenegger/nvim-dap>
  -- nvim help: `:help dap.txt`
  "mfussenegger/nvim-dap",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  config = my.config.lazy_nvim.no_setup,
  specs = { null_spec { opts = my.dap.opts.core_integration } },
}

M[#M + 1] = {
  -- # Nvim-dap-go
  -- repo url: <https://github.com/leoluz/nvim-dap-go>
  -- nvim help: `:help dap-go`
  "leoluz/nvim-dap-go",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  ft = "go",
  dependencies = { "mfussenegger/nvim-dap" },
}

M[#M + 1] = {
  -- # Nvim-dap-python
  -- repo url: <https://github.com/mfussenegger/nvim-dap-python>
  -- nvim help: `:help dap-python`
  "mfussenegger/nvim-dap-python",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  ft = "python",
  dependencies = { "mfussenegger/nvim-dap" },
  -- opts and/or config in filetypes and/or projects
}

M[#M + 1] = {
  -- # Nvim-dap-ui
  -- repo url: <https://github.com/rcarriga/nvim-dap-ui>
  -- nvim help: `:help nvim-dap-ui`
  "rcarriga/nvim-dap-ui",
  enabled = INACTIVE_PLUGIN,
  cond = INACTIVE_PLUGIN_COND,
  lazy = true,
  dependencies = { "mfussenegger/nvim-dap" },
  specs = { null_spec { opts = my.dap.ui.opts.core_integration } },
}

M[#M + 1] = {
  -- # Nvim-dap-view
  -- repo url: <https://github.com/igorlfs/nvim-dap-view>
  -- nvim help: `:help nvim-dap-view`
  "igorlfs/nvim-dap-view",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  specs = {
    null_spec { opts = my.dap.view.opts.core_integration },
    { "mfussenegger/nvim-dap", opts = my.dap.view.opts.dap_integration },
  },
}

M[#M + 1] = {
  -- # Nvim-highlight-colors
  -- repo url: <https://github.com/brenoprata10/nvim-highlight-colors>
  -- nvim help: `:help nvim-highlight-colors`
  "brenoprata10/nvim-highlight-colors",
  enabled = DISABLED_PLUGIN,
  cond = DISABLED_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Nvim-lspconfig
  -- repo url: <https://github.com/neovim/nvim-lspconfig>
  -- nvim help: `:help lspconfig`
  "neovim/nvim-lspconfig",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  config = my.config.lazy_nvim.no_setup,
  specs = { null_spec { opts = my.lsp.lspconfig.opts.core_integration } },
}

M[#M + 1] = {
  -- # nvim-lsp-file-operations
  -- repo url: <https://github.com/antosha417/nvim-lsp-file-operations>
  -- nvim help: ``
  "antosha417/nvim-lsp-file-operations",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Uncomment whichever supported plugin(s) you use
    -- "nvim-tree/nvim-tree.lua",
    -- "nvim-neo-tree/neo-tree.nvim",
    -- "simonmclean/triptych.nvim"
  },
  config = my.lsp.lsp_file_ops.opts.config,
  specs = { "neovim/nvim-lspconfig", opts = my.lsp.lsp_file_ops.opts.lspconfig_extend_default_capabilities },
}

M[#M + 1] = {
  -- # Nvim-nio
  -- repo url: <https://github.com/nvim-neotest/nvim-nio>
  -- nvim help: `:help nvim-nio`
  "nvim-neotest/nvim-nio",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Nvim-surround
  -- repo url: <https://github.com/kylechui/nvim-surround>
  -- nvim help: `:help nvim-surround.txt`
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  event = "VeryLazy",
  opts = my.cmp.surround.opts.general,
  specs = { null_spec { opts = my.cmp.surround.opts.core_integration } },
}

M[#M + 1] = {
  -- # Nvim-treesitter
  -- repo url: <https://github.com/nvim-treesitter/nvim-treesitter>
  -- nvim help: `:help nvim-treesitter`
  "nvim-treesitter/nvim-treesitter",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  opts = my.syntax.ts.opts.general,
  specs = { null_spec { opts = my.syntax.ts.opts.core_integration } },
}

M[#M + 1] = {
  -- # Oil.nvim
  -- repo url: <https://github.com/stevearc/oil.nvim>
  -- nvim help: `:help oil.nvim`
  "stevearc/oil.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  dependencies = {
    "nvim-mini/mini.icons",
    -- "nvim-tree/nvim-web-devicons" -- use if prefer nvim-web-devicons
  },
  opts = my.fs.oil.opts.general,
  specs = { null_spec { opts = my.fs.oil.opts.core_integration } },
}

M[#M + 1] = {
  -- # Plenary.nvim
  -- repo url: <https://github.com/nvim-lua/plenary.nvim>
  -- nvim help: `:help plenary-test`
  "nvim-lua/plenary.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Promise-async
  -- repo url: <https://github.com/kevinhwang91/promise-async>
  -- nvim help: ``
  "kevinhwang91/promise-async",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Rainbow-delimiters-nvim
  -- repo url: <https://github.com/HiPhish/rainbow-delimiters.nvim>
  -- nvim help: `:help rainbow-delimiters`
  "HiPhish/rainbow-delimiters.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Resession.nvim
  -- repo url: <https://github.com/stevearc/resession.nvim.git>
  -- nvim help: `:help resession.nvim`
  "stevearc/resession.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  opts = my.ws.resession.opts.general,
  specs = { null_spec { opts = my.ws.resession.opts.core_integration } },
}

M[#M + 1] = {
  -- # Rustaceanvim
  -- repo url: <https://github.com/mrcjkb/rustaceanvim>
  -- nvim help: `:help rustaceanvim.contents`
  "mrcjkb/rustaceanvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Snacks nvim
  -- repo url: <https://github.com/folke/snacks.nvim>
  -- nvim help: `:help snacks.nvim.txt`
  "folke/snacks.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  dependencies = { "folke/which-key.nvim" },
  opts = { ---@type snacks.Config
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = { enabled = false },
    debug = { enabled = true },
    indent = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    toggle = my.ui.toggle.opts.snacks_toggle_config(),
  },
  specs = {
    null_spec { opts = my.syntax.indent.opts.snacks_indent_core_integration },
    null_spec { opts = my.ui.toggle.opts.snacks_notifier_core_integration },
    null_spec { opts = my.ui.picker.snacks.opts.snacks_picker_core_integration },
  },
}

M[#M + 1] = {
  -- # Solarized-osaka
  -- repo url: <https://github.com/craftzdog/solarized-osaka.nvim>
  -- nvim help: `:help solarized-osaka.nvim.txt`
  "craftzdog/solarized-osaka.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  opts = my.ui.colorscheme.opts.solarized_osaka_general,
}

M[#M + 1] = {
  -- # Tabular
  -- repo url: <https://github.com/godlygeek/tabular>
  -- nvim help: `:help tabular`
  "godlygeek/tabular",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Nvim-ufo
  -- repo url: <https://github.com/kevinhwang91/nvim-ufo>
  -- nvim help: `:help ufo`
  "kevinhwang91/nvim-ufo",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  opts = my.win.ufo.opts.general,
  specs = { null_spec { opts = my.win.ufo.opts.core_integration } },
}

M[#M + 1] = {
  -- # Venv-selector.nvim
  -- repo url: <https://github.com/linux-cultist/venv-selector.nvim>
  -- nvim help: `:help venv-selector.nvim-recent-news`
  "linux-cultist/venv-selector.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  cmd = "VenvSelect",
}

M[#M + 1] = {
  -- # Vim-fugitive
  -- repo url: <https://github.com/tpope/vim-fugitive>
  -- nvim help: `:help fugitive`
  "tpope/vim-fugitive",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  specs = { null_spec { opts = my.git.fugitive.opts.core_integration } },
}

M[#M + 1] = {
  -- # Vim-illuminate
  -- repo url: <https://github.com/RRethy/vim-illuminate>
  -- nvim help: `:help illuminate.txt`
  "RRethy/vim-illuminate",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  specs = { null_spec { opts = my.syntax.illuminate.opts.core_integration } },
}

M[#M + 1] = {
  -- # Vim-repeat
  -- repo url: <https://github.com/tpope/vim-repeat>
  -- nvim help: ``
  "tpope/vim-repeat",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Vim-rest-console
  -- repo url: <https://github.com/diepm/vim-rest-console>
  -- nvim help: `:help vim-rest-console`
  "diepm/vim-rest-console",
  enabled = DISABLED_PLUGIN,
  cond = DISABLED_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Which-key.nvim
  -- repo url: <https://github.com/folke/which-key.nvim>
  -- nvim help: `:help vim-rest-console`
  "folke/which-key.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  opts = my.keymap.opts.which_key_general,
  dependencies = { "nvim-mini/mini.icons" },
}
if true then return M end

return M
