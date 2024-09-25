-- ==============
-- NVIM-COLORIZER
-- ==============

-- repo url: <https://github.com/NvChad/nvim-colorizer.lua>
-- nvim help: `:help colorizer`

return {
  "NvChad/nvim-colorizer.lua",
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
