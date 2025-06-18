-- ============
-- COLORSCHEMES
-- ============

-- NVIM-BASE16
-- repo url: <https://github.com/RRethy/base16-nvim>
-- nvim help: `:help base16`

-- SOLARIZED-OSAKA
-- repo url: <https://github.com/craftzdog/solarized-osaka.nvim>
-- nvim help: `:help solarized-osaka.nvim.txt`

return {
  { "AstroNvim/astroui", opts = { colorscheme = "solarized-osaka" } },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    opts = {
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      dim_inactive = true,
    },
  },
  { "RRethy/base16-nvim", lazy = true },
}
