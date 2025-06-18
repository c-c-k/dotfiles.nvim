-- ===========
-- SNACKS NVIM
-- ===========

-- repo url: <https://github.com/folke/snacks.nvim>
-- nvim help: `:help snacks.nvim.txt`

---@type LazySpec
return {
  {
    "folke/snacks.nvim",
    ---@param opts snacks.Config
    opts = function(_, opts)
      opts["dashboard"] = nil
      local astrocore = require "astrocore"
      return astrocore.extend_tbl(opts, {
        -- PLACEHOLDER
      })
    end,
    specs = {
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local astrocore = require "astrocore"
          local astromaps = opts.mappings
          local maps, map = require("cck.utils.config").get_astrocore_mapper()

          -- Snacks.indent mappings
          map("n", "<LEADER>u|", { copy = { "n", "<Leader>u|", source = astromaps } }) -- desc = "Toggle indent guides"

          -- Snacks.notifier mappings
          map("n", "<LEADER>uD", { copy = { "n", "<Leader>uD", source = astromaps } }) -- desc = "Dismiss notifications"

          opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
        end,
      },
    },
  },
}
