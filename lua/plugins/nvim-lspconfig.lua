-- ==============
-- NVIM-LSPCONFIG
-- ==============

-- repo url: <https://github.com/neovim/nvim-lspconfig>
-- nvim help: `:help lspconfig`

return {
  "neovim/nvim-lspconfig",
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      local astrocore = require "astrocore"
      local astromaps = opts.mappings

      local maps, map = require("cck.utils.config").get_astrocore_mapper()

      map("n", "<LEADER>li", { copy = { "n", "<Leader>li", source = astromaps } }) -- desc = "LSP information"

      opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
    end,
  },
}
