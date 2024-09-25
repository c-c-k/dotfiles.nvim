-- ===========
-- NVIM-NOTIFY
-- ===========

-- repo url: <https://github.com/rcarriga/nvim-notify>
-- nvim help: `:help nvim-notify.txt`

return {
  "rcarriga/nvim-notify",
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local astrocore = require "astrocore"
      local astromaps = opts.mappings

      local maps, map = require("cck.utils.config").get_astrocore_mapper()

      map("n", "<LEADER>uD", { copy = { "n", "<Leader>uD", source = astromaps } }) -- desc = "Dismiss notifications"

      opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
    end,
  },
}
