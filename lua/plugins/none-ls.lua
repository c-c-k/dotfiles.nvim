-- =======
-- NONE-LS
-- =======

-- repo url: <https://github.com/nvimtools/none-ls.nvim>
-- nvim help: `:help null-ls.txt`

return {
  "nvimtools/none-ls.nvim",
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      local astrocore = require "astrocore"
      local astromaps = opts.mappings

      local maps, map = require("cck.utils.config").get_astrocore_mapper()

      map("n", "<LEADER>lI", { copy = { "n", "<Leader>lI", source = astromaps } }) -- desc = "Null-ls information"

      opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
    end,
  },
}
