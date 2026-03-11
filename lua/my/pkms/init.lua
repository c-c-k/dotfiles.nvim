local my = require "my"
---@class my.pkms
local M = {}

M.opts = {}

M.opts.general = function()
  print "hhheeere"
  vim.g.my_uri_resolvers = { "my.pkbm.resolve_uri_as_path" }
  vim.g.my_notebook_prefix = "my-"

  vim.g.my_notebooks = {
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

  my.keymap.queue_km_group_load(my.config.keymaps.g_notes___)
end

M.keymaps = {}

M.keymaps.add_ref_link_clipboard = { ---@type my.keymap.keymap_spec
  desc = "Add ref link (clipboard)",
  rhs = "<CMD>MyAddClipboardRefLink<CR>",
}
M.keymaps.add_ref_link_input = { ---@type my.keymap.keymap_spec
  desc = "Add ref link (input)",
  rhs = ":MyAddNoteRefLink ",
}
M.keymaps.edit_note = { ---@type my.keymap.keymap_spec
  desc = "Edit note",
  rhs = ":MyEditNote ",
}

return M
