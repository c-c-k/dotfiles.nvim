local my = require "my"

---@type LazyPluginSpec
local spec_neogen = {
  "danymat/neogen",
  cmd = "Neogen",
  opts = {
    snippet_engine = "luasnip",
    languages = {},
  },
}

---@type LazyPluginSpec
local spec_neogen__astrocore = {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local maps, map = my.keymap.get_astrocore_mapper()

    map("n", "<LEADER>idd", "<CMD>Neogen any<CR>", { desc = "Insert any docs/annotations" })
    map("n", "<LEADER>idc", "<CMD>Neogen class<CR>", { desc = "Insert class docs/annotations" })
    map("n", "<LEADER>idf", "<CMD>Neogen func<CR>", { desc = "Insert func docs/annotations" })
    map("n", "<LEADER>idt", "<CMD>Neogen type<CR>", { desc = "Insert type docs/annotations" })
    map("n", "<LEADER>idF", "<CMD>Neogen file<CR>", { desc = "Insert file docs/annotations" })

    opts.mappings = my.tbl.merge("dDFn", opts.mappings, maps)
  end,
}

spec_neogen.specs = {
  spec_neogen__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_neogen,
}
