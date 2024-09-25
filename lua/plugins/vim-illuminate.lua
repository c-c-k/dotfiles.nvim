-- ==============
-- VIM-ILLUMINATE
-- ==============

-- repo url: <https://github.com/RRethy/vim-illuminate>
-- nvim help: `:help illuminate.txt`

return {
  "RRethy/vim-illuminate",
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local astrocore = require "astrocore"
      local astromaps = opts.mappings

      local maps, map = require("cck.utils.config").get_astrocore_mapper()

      map("n", "<LEADER>ur", { copy = { "n", "<Leader>ur", source = astromaps } }) -- desc = "Toggle reference highlighting (buffer)"
      map("n", "<LEADER>uR", { copy = { "n", "<Leader>uR", source = astromaps } }) -- desc = "Toggle reference highlighting (global)"

      opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
    end,
  },
}
