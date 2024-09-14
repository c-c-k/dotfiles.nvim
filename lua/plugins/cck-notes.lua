-- =========
-- CCK-Notes
-- =========

-- repo url: <>
-- nvim help: ``

return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local g = {}
    local maps, map = require("cck.utils.config").get_astrocore_mapper()

    map("n", "<LEADER>n", { desc = "Notes" })
    map("n", "<LEADER>ne", ":CCKEditNote ", { desc = "Edit note" })
    map("n", "<LEADER>nll", ":CCKAddNoteRefLink ", { desc = "Add ref link (input)" })
    map("n", "<LEADER>nlc", "<CMD>CCKAddClipboardRefLink<CR>", { desc = "Add ref link (clipboard)" })

    g.cck_uri_resolvers = { "cck.pkbm.resolve_uri_as_path" }
    g.cck_notebook_prefix = "cck-"

    g.cck_notebooks = {
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
        path = "$NOTEBOOKS_TEST_NB_ROOT/cck/nb1",
        notes_path = "notes",
        filename_template = "${TITLE_CLEAN}",
        templates_path = "$NOTEBOOKS_TEMPLATES",
        default_template = "$NOTEBOOKS_TEMPLATES/basic_note.tpl",
      },
      {
        name = "test2",
        path = "$NOTEBOOKS_TEST_NB_ROOT/cck/nb2",
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
