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
}

---@type LazyPluginSpec
local spec_solarized_osaka_nvim = {
  "craftzdog/solarized-osaka.nvim",
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
