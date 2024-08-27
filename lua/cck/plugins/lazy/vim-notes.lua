-- =========
-- VIM-NOTES
-- =========

-- repo url: <https://github.com/xolox/vim-notes>
-- nvim help: `:help notes`

return {
  -- == PLUGIN DISABLED ==
  -- This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one.
  -- It is temporarily disabled until it passed manual inspection to check that it has been converted correctly.
  enabled = false,
  'xolox/vim-notes',
  init = function()      
    vim.g['notes_directories'] = {vim.fn.expand('$NOTEBOOKS_TEST_NB_ROOT/vim-notes')}
  end,
}
