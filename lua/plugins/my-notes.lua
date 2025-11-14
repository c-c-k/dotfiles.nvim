---@type LazyPluginSpec
local spec_astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local g = {}
    local maps, map = require("my.core.keymaps").get_astrocore_mapper()

    map("n", "<LEADER>n", { desc = "Notes" })
    map("n", "<LEADER>ne", ":MyEditNote ", { desc = "Edit note" })
    map("n", "<LEADER>nll", ":MyAddNoteRefLink ", { desc = "Add ref link (input)" })
    map("n", "<LEADER>nlc", "<CMD>MyAddClipboardRefLink<CR>", { desc = "Add ref link (clipboard)" })

    g.my_uri_resolvers = { "my.pkbm.resolve_uri_as_path" }
    g.my_notebook_prefix = "my-"

    g.my_notebooks = {
      {
        name = "pkb",
        path = "$NOTEBOOKS_PKB_ROOT",
        notes_path = "",
        filename_template = "${TITLE_CLEAN}",
        templates_path = "$NOTEBOOKS_TEMPLATES",
        default_template = "$NOTEBOOKS_TEMPLATES/basic_note.tpl",
      },
      {
        name = "test",
        path = "$NOTEBOOKS_TEST_NB_ROOT/my/nb1",
        notes_path = "notes",
        filename_template = "${TITLE_CLEAN}",
        templates_path = "$NOTEBOOKS_TEMPLATES",
        default_template = "$NOTEBOOKS_TEMPLATES/basic_note.tpl",
      },
      {
        name = "test2",
        path = "$NOTEBOOKS_TEST_NB_ROOT/my/nb2",
        notes_path = "other",
        filename_template = "%s-${TITLE_CLEAN}",
        templates_path = "$NOTEBOOKS_TEMPLATES",
        default_template = "$NOTEBOOKS_TEMPLATES/basic_note.tpl",
      },
    }

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
    opts.options.g = astrocore.extend_tbl(opts.options.g, g)
  end,
}

---@type LazyPluginSpec[]
return {
  spec_astrocore,
}
