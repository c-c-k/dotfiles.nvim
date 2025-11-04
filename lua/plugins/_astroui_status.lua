-- =================
-- ASTRONVIM ASTROUI
-- (STATUS)
-- =================

-- repo url: <https://github.com/AstroNvim/astroui>
-- nvim help: `:help astroui`

---@type LazyPluginSpec
local spec_astroui = {
  "AstroNvim/astroui",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      status = {
        -- PLACEHOLDER
      },
    } --[[@as AstroUIOpts]])
  end,
}

---@type LazyPluginSpec[]
return {
  spec_astroui,
}
