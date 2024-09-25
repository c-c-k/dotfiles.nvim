-- ================
-- INDENT-BLANKLINE
-- ================

-- repo url: <https://github.com/lukas-reineke/indent-blankline.nvim>
-- nvim help: `:help indent-blankline.txt`

return {
  "lukas-reineke/indent-blankline.nvim",
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local astrocore = require "astrocore"
      local astromaps = opts.mappings

      local maps, map = require("cck.utils.config").get_astrocore_mapper()

      map("n", "<LEADER>u|", { copy = { "n", "<Leader>u|", source = astromaps } }) -- desc = "Toggle indent guides"

      opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
    end,
  },
}
