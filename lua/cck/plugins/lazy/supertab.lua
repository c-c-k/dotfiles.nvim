-- =========
--  SUPERTAB
-- =========

-- repo url: <https://github.com/ervandew/supertab>
-- nvim help: `:help supertab`

return {
  -- == PLUGIN DISABLED ==
  -- This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one.
  -- It is temporarily disabled until it passed manual inspection to check that it has been converted correctly.
  enabled = false,
  'ervandew/supertab',
  init = function()      vim.g['SuperTabDefaultCompletionType'] = '<C-n>'
  end,
}
