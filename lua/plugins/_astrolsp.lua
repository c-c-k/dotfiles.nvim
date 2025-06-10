-- ==================================================
-- ASTRONVIM ASTROLSP (FEATURES, CAPABILITIES, ETC..)
-- ==================================================

-- repo url: <https://github.com/AstroNvim/astrolsp>
-- nvim help: `:help astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      -- PLACEHOLDER
    } --[[@as AstroLSPConfig]])
  end,
}
