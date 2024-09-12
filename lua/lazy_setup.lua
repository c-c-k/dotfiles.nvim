require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    -- Remove version tracking to elect for nighly AstroNvim
    version = "^4",
    import = "astronvim.plugins",
    -- AstroNvim options must be set here with the `import` key
    opts = {
      -- This ensures the leader key is configured before Lazy is set up
      --  * `vim.g.mapleader` is set to two spaces while a single space
      --    is used for `vim.g.usermapleader` (see init.lua for rationale).
      mapleader = "  ",
      -- This ensures the localleader key is configured before Lazy is set up
      maplocalleader = ",",
      -- Set to false to disable icons (if no Nerd Font is available)
      icons_enabled = true,
      -- Default will pin plugins when tracking `version` of AstroNvim, set to
      -- true/false to override
      pin_plugins = nil,
      -- Enable/disable notification about running `:Lazy update` twice to
      -- update pinned plugins
      update_notifications = true,
    },
  },
  { import = "community" },
  { import = "plugins" },
} --[[@as LazySpec]], {
  -- Configure any other `lazy.nvim` configuration options here
  install = { colorscheme = { "astrotheme", "habamax" } },
  ui = { backdrop = 100 },
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
} --[[@as LazyConfig]])
