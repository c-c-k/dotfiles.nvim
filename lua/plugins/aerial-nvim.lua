-- ===========
-- AERIAL-NVIM
-- ===========

-- repo url: <https://github.com/stevearc/aerial.nvim>
-- nvim help: `:help aerial`

return {
  "stevearc/aerial.nvim",
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local astrocore = require "astrocore"
      local astromaps = opts.mappings

      local maps, map = require("cck.utils.config").get_astrocore_mapper()

      map("n", "<LEADER>ls", { copy = { "n", "<Leader>lS", source = astromaps } }) -- desc = "Symbols outline"

      opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
    end,
  },
}
