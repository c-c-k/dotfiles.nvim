-- =================
-- ASTRONVIM ASTROUI
-- (STATUS)
-- =================

-- repo url: <https://github.com/AstroNvim/astroui>
-- nvim help: `:help astroui`

---@type LazySpec
return {
  "AstroNvim/astroui",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      status = {
        -- PLACEHOLDER
      },
    } --[[@as AstroUIConfig]])
  end,
}
