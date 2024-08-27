-- =======
-- VIM-PAD
-- =======

-- repo url: <https://github.com/fmoralesc/vim-pad>
-- nvim help: `:help vim-pad`

return {
  -- == PLUGIN DISABLED ==
  -- This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one.
  -- It is temporarily disabled until it passed manual inspection to check that it has been converted correctly.
  enabled = false,
  'fmoralesc/vim-pad',
  init = function()      
    vim.g['pad#dir'] = {vim.fn.expand('$NOTEBOOKS_TEST_NB_ROOT/vimpad')}
  end,
}
