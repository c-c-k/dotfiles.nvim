-- =========
-- BLINK.CMP
-- =========

-- repo url: <https://github.com/saghen/blink.cmp>
-- nvim help: `:help blink`

return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then return cmp.accept() end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = {
          "snippet_backward",
          "fallback",
        },
      },
    },
  },
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local astrocore = require "astrocore"
      local astromaps = opts.mappings

      local maps, map = require("cck.utils.config").get_astrocore_mapper()

      map("n", "<LEADER>uc", { copy = { "n", "<Leader>uc", source = astromaps } }) -- desc = "Toggle autocompletion (buffer)"
      map("n", "<LEADER>uC", { copy = { "n", "<Leader>uC", source = astromaps } }) -- desc = "Toggle autocompletion (global)"

      opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
    end,
  },
}
