-- ============
-- COLORSCHEMES
-- ============

-- NVIM-BASE16
-- repo url: <https://github.com/RRethy/base16-nvim>
-- nvim help: `:help base16`

-- SOLARIZED-OSAKA
-- repo url: <https://github.com/craftzdog/solarized-osaka.nvim>
-- nvim help: `:help solarized-osaka.nvim.txt`

---@type LazyPluginSpec
local spec_astroui = {
  "AstroNvim/astroui",
  opts = { colorscheme = "solarized-osaka" },
}

---@type LazyPluginSpec
local spec_base16_nvim = {
  "RRethy/base16-nvim",
  lazy = true,
}

---@type LazyPluginSpec
local spec_solarized_osaka_nvim = {
  "craftzdog/solarized-osaka.nvim",
  lazy = true,
  opts = {
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    dim_inactive = true,
  },
}

---@type LazyPluginSpec[]
return {
  spec_astroui,
  spec_base16_nvim,
  spec_solarized_osaka_nvim,
}
