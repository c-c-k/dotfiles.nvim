-- ==============
-- NVIM-AUTOPAIRS
-- ==============

-- repo url: <https://github.com/windwp/nvim-autopairs>
-- nvim help: `:help nvim-autopairs.txt`

return {
  "windwp/nvim-autopairs",
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local astrocore = require "astrocore"
      local astromaps = opts.mappings

      local maps, map = require("cck.utils.config").get_astrocore_mapper()

      map("n", "<LEADER>ua", { copy = { "n", "<Leader>ua", source = astromaps } }) -- desc = "Toggle autopairs"

      opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
    end,
  },
}
