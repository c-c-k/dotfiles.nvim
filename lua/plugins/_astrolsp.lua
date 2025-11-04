-- ==================================================
-- ASTRONVIM ASTROLSP (FEATURES, CAPABILITIES, ETC..)
-- ==================================================

-- repo url: <https://github.com/AstroNvim/astrolsp>
-- nvim help: `:help astrolsp`

---@type LazyPluginSpec
local spec_astrolsp = {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      -- PLACEHOLDER
    } --[[@as AstroLSPOpts]])
  end,
}

---@type LazyPluginSpec[]
return {
  spec_astrolsp,
}
