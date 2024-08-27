-- =========
-- CCK-Notes
-- =========

-- repo url: <https://github.com/ttt/ttt>
-- nvim help: `:help ttt`

return {
  -- == PLUGIN DISABLED ==
  -- This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one.
  -- It is temporarily disabled until it passed manual inspection to check that it has been converted correctly.
  enabled = false,
  'ttt/ttt',
  init = function()      -- This pseudo-plugin configuration file is meant for extra notebooks related
    -- configuration need for the customization in `lua/cck` and
    -- `rplugin/.../cck/`.
    
    -- map <LEADER>ne :CCKEditNote 
    -- map <LEADER>nl :CCKAddNoteRefLink 
    -- map <LEADER>nll :CCKAddNoteRefLink 
    -- map <LEADER>nlc :CCKAddClipboardRefLink 
    
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
