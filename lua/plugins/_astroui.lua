---@type LazyPluginSpec
local spec_astroui = {
  "AstroNvim/astroui",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      folding = {
        -- PLACEHOLDER
      },
      highlights = {
        -- PLACEHOLDER
      },
      icons = {
        -- PLACEHOLDER
      },
      text_icons = {
        -- PLACEHOLDER
      },
      lazygit = {
        -- PLACEHOLDER
      },
    } --[[@as AstroUIOpts]])
  end,
}

---@type LazyPluginSpec[]
return {
  spec_astroui,
}
