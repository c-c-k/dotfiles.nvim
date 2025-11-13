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
    dim_inactive = false,
    on_highlights = function(highlights, colors)
      -- Avoid dimming text in inactive windows, `dim_inactive` only affects the background
      highlights.NormalNC = { fg = colors.base0 } -- normal text in non-current windows
      -- Make cursor line a bit more visible
      highlights.CursorLine = { bg = colors.base02, sp = colors.base1 } -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    end,
  },
}

---@type LazyPluginSpec[]
return {
  spec_astroui,
  spec_base16_nvim,
  spec_solarized_osaka_nvim,
}
