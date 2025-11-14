return {
  -- # Plugins Manifest
  require "plugins/manifest",

  -- # AstroNvim framework
  require "plugins/astronvim",
  require "plugins/community",

  -- # Core config
  require "plugins/_astrocore",
  require "plugins/_astrocore_autocmds",
  require "plugins/_astrocore_mappings",
  require "plugins/_astrolsp",
  require "plugins/_astrolsp_autocmds",
  require "plugins/_astrolsp_mappings",
  require "plugins/_astrotheme",
  require "plugins/_astroui",
  require "plugins/_astroui_status",
  require "plugins/core_config",

  -- # Snacks.Nvim
  require "plugins/snacks",

  -- # IPC, Terminal Integration
  require "plugins/neomux",

  -- # Treesitter
  require "plugins/nvim-treesitter",

  -- # Colorschemes
  require "plugins/colorschemes",

  -- # Project/Session/Workspace Management
  require "plugins/lazydev",
  require "plugins/resession-nvim",

  -- # File system & GIT
  require "plugins/gitsigns-nvim",
  require "plugins/mini-files",
  require "plugins/oil-nvim",
  require "plugins/vim-fugitive",

  -- # UI tweaks
  require "plugins/aerial-nvim",
  require "plugins/autopairs",
  require "plugins/heirline",
  require "plugins/leap-nvim",
  require "plugins/nvim-highlight-colors",
  require "plugins/nvim-surround",
  require "plugins/tabular",
  require "plugins/vim-illuminate",
  require "plugins/vim-repeat",

  -- # Completion & Pickers
  require "plugins/blink",
  require "plugins/luasnip",
  require "plugins/neogen",

  -- # IDE, LSP
  require "plugins/dap",
  require "plugins/neotest",
  require "plugins/none-ls",
  require "plugins/nvim-lspconfig",

  -- # AI
  require "plugins/codecompanion-nvim",
  require "plugins/copilot-vim",

  -- # Programming, Languages, Filetypes
  require "plugins/bash",
  require "plugins/go",
  require "plugins/godot",
  require "plugins/lua",
  require "plugins/markdown",
  require "plugins/python",
  require "plugins/rust",
  require "plugins/toml",
  require "plugins/vim-rest-console",

  -- # PKBM, Zettelkasten, Second Brain, Note taking
  require "plugins/my-notes",
  require "plugins/markdown-nvim",
  require "plugins/mkdnflow-nvim",
}
