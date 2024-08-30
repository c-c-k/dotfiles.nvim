-- =======
-- VIM-PAD
-- =======

-- repo url: <https://github.com/fmoralesc/vim-pad>
-- nvim help: `:help vim-pad`

return {
  -- == PLUGIN DISABLED ==
  -- MEMO: This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one and requires a manual inspection to check that it has been converted correctly.
  -- Vim-pad is disabled because it does not currently feel convenient for my note taking workflow.
  enabled = false,
  'fmoralesc/vim-pad',
  init = function()      
    vim.g['pad#dir'] = {vim.fn.expand('$NOTEBOOKS_TEST_NB_ROOT/vimpad')}
  end,
}
