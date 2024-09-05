-- =========
-- CCK-Notes
-- =========

-- repo url: <>
-- nvim help: ``

return {
  -- This pseudo-plugin configuration file is meant for extra notebooks
  -- related configuration needed for the customization in `lua/cck` and
  -- `rplugin/.../cck/`.
  dir = '/dev/null',
  init = function()
    
    vim.keymap.set( "n", "<LEADER>ne", ":CCKEditNote ", { desc = "" } )
    vim.keymap.set( "n", "<LEADER>nll", ":CCKAddNoteRefLink ", { desc = "" } )
    vim.keymap.set( "n", "<LEADER>nlc", "<CMD>CCKAddClipboardRefLink<CR>", { desc = "" } )
    
    vim.g['cck_uri_resolvers'] = {
    'cck.pkbm.resolve_uri_as_path',
    }
    vim.g['cck_notebook_prefix'] = 'cck-'
    
    vim.g['cck_notebooks'] = {
    {
    name = 'pkb',
    path = '$NOTEBOOKS_PKB_ROOT',
    notes_path = '',
    filename_template = '${TITLE_CLEAN}',
    templates_path = '$NOTEBOOKS_TEMPLATES',
    default_template = '$NOTEBOOKS_TEMPLATES/basic_note.tpl',
    },
    {
    name = 'test',
    path = '$NOTEBOOKS_TEST_NB_ROOT/cck/nb1',
    notes_path = 'notes',
    filename_template = '${TITLE_CLEAN}',
    templates_path = '$NOTEBOOKS_TEMPLATES',
    default_template = '$NOTEBOOKS_TEMPLATES/basic_note.tpl',
    },
    {
    name = 'test2',
    path = '$NOTEBOOKS_TEST_NB_ROOT/cck/nb2',
    notes_path = 'other',
    filename_template = '%s-${TITLE_CLEAN}',
    templates_path = '$NOTEBOOKS_TEMPLATES',
    default_template = '$NOTEBOOKS_TEMPLATES/basic_note.tpl',
    },
    }
    
  end,
}
