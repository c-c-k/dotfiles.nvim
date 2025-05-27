-- =====================
-- NVIM-HIGHLIGHT-COLORS
-- =====================

-- repo url: <https://github.com/brenoprata10/nvim-highlight-colors>
-- nvim help: `:help nvim-highlight-colors`

return {
  "brenoprata10/nvim-highlight-colors",
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local astrocore = require "astrocore"
      local astromaps = opts.mappings

      local maps, map = require("cck.utils.config").get_astrocore_mapper()

      map("n", "<LEADER>uz", { copy = { "n", "<Leader>uz", source = astromaps } }) -- desc = "Toggle color highlight"

      opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
    end,
  },
}
