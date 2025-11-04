-- =======
-- LAZYDEV
-- =======

-- repo url: <https://github.com/folke/lazydev.nvim>
-- nvim help: `:help lazydev.nvim.txt`

---@type LazyPluginSpec
local spec_lazydev_nvim = {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  opts = function(_, opts)
    opts.library = require("astrocore").extend_tbl(opts.library or {}, {
      -- Examples:
      -- Library paths can be absolute
      -- "~/projects/my-awesome-lib",
      -- Or relative, which means they will be resolved from the plugin dir.
      -- "lazy.nvim",
      -- "luvit-meta/library",
      -- It can also be a table with trigger words / mods
      -- Only load luvit types when the `vim.uv` word is found
      -- { path = "luvit-meta/library", words = { "vim%.uv" } },
      -- -- always load the LazyVim library
      -- "LazyVim",
      -- -- Only load the lazyvim library when the `LazyVim` global is found
      -- { path = "LazyVim", words = { "LazyVim" } },
      -- -- Load the wezterm types when the `wezterm` module is required
      -- Needs `justinsgithub/wezterm-types` to be installed
      -- { path = "wezterm-types", mods = { "wezterm" } },
      -- -- Load the xmake types when opening file named `xmake.lua`
      -- Needs `LelouchHe/xmake-luals-addon` to be installed
      --   { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
    })
    -- opts.enabled = function(root_dir)
    --   -- Default:
    --   return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
    --   -- Example: disable when a .luarc.json file is found
    --   return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
    -- end
  end,
}

---@type LazyPluginSpec[]
return {
  spec_lazydev_nvim,
}
