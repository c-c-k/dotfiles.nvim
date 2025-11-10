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

-- ---@type LazyPluginSpec
-- M[#M+1] = {
-- -- # 0 (Template for Lazy Plugin Manifest Spec)
-- -- repo url: <>
-- -- nvim help: `:help `
--   "",
--   dir = "",
--   url = "",
--   name = "",
--   dev = false,
--   enabled = ACTIVE_ENABLED,
--   cond = ACTIVE_COND,
--   priority = 50,
--   main = "",
--   build = function(plugin) end,
--   lazy = true,
--   event = "VeryLazy",
--   branch = "",
--   tag = "",
--   commit = "",
--   version = "",
--   pin = false,
--   submodules = true,
-- }

M[#M + 1] = {
  -- # Aerial-nvim
  -- repo url: <https://github.com/stevearc/aerial.nvim>
  -- nvim help: `:help aerial`
  "stevearc/aerial.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
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
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  priority = 10000,
}

M[#M + 1] = {
  -- # Astrolsp
  -- repo url: <https://github.com/AstroNvim/astrolsp>
  -- nvim help: `:help astrolsp`
  "AstroNvim/astrolsp",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Astronvim
  -- repo url: <https://github.com/AstroNvim/AstroNvim>
  -- nvim help: `:help astronvim-preview`
  "AstroNvim/AstroNvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
  version = "^5", -- Remove version tracking to elect for nightly AstroNvim
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
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Base16-nvim
  -- repo url: <https://github.com/RRethy/base16-nvim>
  -- nvim help: `:help base16`
  "RRethy/base16-nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
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
}

M[#M + 1] = {
  -- # Codecompanion.nvim
  -- repo url: <https://github.com/olimorris/codecompanion.nvim>
  -- nvim help: `:help codecompanion.txt`
  "olimorris/codecompanion.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Copilot.vim
  -- repo url: <https://github.com/github/copilot.vim>
  -- nvim help: `:help copilot`
  "github/copilot.vim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Crates.nvim
  -- repo url: <https://github.com/Saecki/crates.nvim>
  -- nvim help: `:help crates.nvim`
  "Saecki/crates.nvim",
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
}

M[#M + 1] = {
  -- # Gopher.nvim
  -- repo url: <https://github.com/olexsmir/gopher.nvim>
  -- nvim help: `:help gopher.nvim`
  "olexsmir/gopher.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  build = function()
    if not require("lazy.core.config").spec.plugins["mason.nvim"] then
      vim.print "Installing go dependencies..."
      vim.cmd.GoInstallDeps()
    end
  end,
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
}

M[#M + 1] = {
  -- # Leap.nvim
  -- repo url: <https://github.com/ggandor/leap.nvim>
  -- nvim help: `:help leat.txt`
  "ggandor/leap.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Luasnip
  -- repo url: <https://github.com/L3MON4D3/LuaSnip>
  -- nvim help: `:help luasnip.txt`
  "L3MON4D3/LuaSnip",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Markdown-nvim
  -- repo url: <https://github.com/tadmccorkle/markdown.nvim>
  -- nvim help: `:help markdown.nvim`
  "tadmccorkle/markdown.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  -- event = "VeryLazy",
}

M[#M + 1] = {
  -- # Mason-tool-installer.nvim
  -- repo url: <https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim>
  -- nvim help: `:help mason-tool-installer.nvim-mason-tool-installer`
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Mason.nvim
  -- repo url: <https://github.com/williamboman/mason.nvim>
  -- nvim help: `:help mason.nvim`
  "williamboman/mason.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Mini.files
  -- repo url: <https://github.com/nvim-mini/mini.files>
  -- nvim help: `:help mini.files`
  "nvim-mini/mini.files",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Mini.icons
  -- repo url: <https://github.com/nvim-mini/mini.icons>
  -- nvim help: `:help mini.icons`
  "nvim-mini/mini.icons",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Mkdnflow.nvim
  -- repo url: <https://github.com/jakewvincent/mkdnflow.nvim>
  -- nvim help: `:help Mkdnflow-help`
  "jakewvincent/mkdnflow.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Neogen
  -- repo url: <https://github.com/danymat/neogen>
  -- nvim help: `:help neogen`
  "danymat/neogen",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
}

M[#M + 1] = {
  -- # Neomux
  -- repo url: <https://github.com/nikvdp/neomux>
  -- nvim help: `:help neomux`
  "nikvdp/neomux",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Neotest
  -- repo url: <https://github.com/nvim-neotest/neotest>
  -- nvim help: `:help neotest.txt`
  "nvim-neotest/neotest",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Neotest-golang
  -- repo url: <https://github.com/fredrikaverpil/neotest-golang>
  -- nvim help: `:help neotest-golang-neotest-golang`
  "fredrikaverpil/neotest-golang",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # None-ls
  -- repo url: <https://github.com/nvimtools/none-ls.nvim>
  -- nvim help: `:help null-ls.txt`
  "nvimtools/none-ls.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Null-plugin-cck
  -- repo url: N/A
  -- nvim help: N/A
  dir = vim.fn.stdpath "config",
  name = "cck",
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
}

M[#M + 1] = {
  -- # Nvim-dap
  -- repo url: <https://github.com/mfussenegger/nvim-dap>
  -- nvim help: `:help dap.txt`
  "mfussenegger/nvim-dap",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
}

M[#M + 1] = {
  -- # Nvim-dap-go
  -- repo url: <https://github.com/leoluz/nvim-dap-go>
  -- nvim help: `:help dap-go`
  "leoluz/nvim-dap-go",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
}

M[#M + 1] = {
  -- # Nvim-dap-python
  -- repo url: <https://github.com/mfussenegger/nvim-dap-python>
  -- nvim help: `:help dap-python`
  "mfussenegger/nvim-dap-python",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
}

M[#M + 1] = {
  -- # Nvim-dap-ui
  -- repo url: <https://github.com/rcarriga/nvim-dap-ui>
  -- nvim help: `:help nvim-dap-ui`
  "rcarriga/nvim-dap-ui",
  enabled = INACTIVE_PLUGIN,
  cond = INACTIVE_PLUGIN_COND,
  lazy = true,
}

M[#M + 1] = {
  -- # Nvim-dap-view
  -- repo url: <https://github.com/igorlfs/nvim-dap-view>
  -- nvim help: `:help nvim-dap-view`
  "igorlfs/nvim-dap-view",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
}

M[#M + 1] = {
  -- # Nvim-highlight-colors
  -- repo url: <https://github.com/brenoprata10/nvim-highlight-colors>
  -- nvim help: `:help nvim-highlight-colors`
  "brenoprata10/nvim-highlight-colors",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
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
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  event = "VeryLazy",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
}

M[#M + 1] = {
  -- # Nvim-treesitter
  -- repo url: <https://github.com/nvim-treesitter/nvim-treesitter>
  -- nvim help: `:help nvim-treesitter`
  "nvim-treesitter/nvim-treesitter",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Oil.nvim
  -- repo url: <https://github.com/stevearc/oil.nvim>
  -- nvim help: `:help oil.nvim`
  "stevearc/oil.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
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
  -- # Resession.nvim
  -- repo url: <https://github.com/stevearc/resession.nvim.git>
  -- nvim help: `:help resession.nvim`
  "stevearc/resession.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Rustaceanvim
  -- repo url: <https://github.com/mrcjkb/rustaceanvim>
  -- nvim help: `:help rustaceanvim.contents`
  "mrcjkb/rustaceanvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
  version = vim.fn.has "nvim-0.11" == 1 and "^6" or "^5",
}

M[#M + 1] = {
  -- # Snacks nvim
  -- repo url: <https://github.com/folke/snacks.nvim>
  -- nvim help: `:help snacks.nvim.txt`
  "folke/snacks.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Solarized-osaka
  -- repo url: <https://github.com/craftzdog/solarized-osaka.nvim>
  -- nvim help: `:help solarized-osaka.nvim.txt`
  "craftzdog/solarized-osaka.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
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
  -- # Venv-selector.nvim
  -- repo url: <https://github.com/linux-cultist/venv-selector.nvim>
  -- nvim help: `:help venv-selector.nvim-recent-news`
  "linux-cultist/venv-selector.nvim",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = true,
}

M[#M + 1] = {
  -- # Vim-fugitive
  -- repo url: <https://github.com/tpope/vim-fugitive>
  -- nvim help: `:help fugitive`
  "tpope/vim-fugitive",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

M[#M + 1] = {
  -- # Vim-illuminate
  -- repo url: <https://github.com/RRethy/vim-illuminate>
  -- nvim help: `:help illuminate.txt`
  "RRethy/vim-illuminate",
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
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
  enabled = ACTIVE_PLUGIN,
  cond = ACTIVE_PLUGIN_COND,
  lazy = false,
}

return M
