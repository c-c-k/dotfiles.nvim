-- =======
-- NEOGEN
-- =======

-- repo url: <https://github.com/danymat/neogen>
-- nvim help: `:help neogen`

return {
  "danymat/neogen",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local astrocore = require "astrocore"
        local maps, map = require("cck.utils.config").get_astrocore_mapper()

        map("n", "<LEADER>idd", "<CMD>Neogen any<CR>", { desc = "Insert any docs/annotations" })
        map("n", "<LEADER>idc", "<CMD>Neogen class<CR>", { desc = "Insert class docs/annotations" })
        map("n", "<LEADER>idf", "<CMD>Neogen func<CR>", { desc = "Insert func docs/annotations" })
        map("n", "<LEADER>idt", "<CMD>Neogen type<CR>", { desc = "Insert type docs/annotations" })
        map("n", "<LEADER>idF", "<CMD>Neogen file<CR>", { desc = "Insert file docs/annotations" })

        opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
      end,
    },
  },
  cmd = "Neogen",
  opts = {
    snippet_engine = "luasnip",
    languages = {},
  },
}
