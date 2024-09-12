-- =========
--  SUPERTAB
-- =========

-- repo url: <https://github.com/ervandew/supertab>
-- nvim help: `:help supertab`

return {
  'ervandew/supertab',
  -- == PLUGIN DISABLED ==
  -- supertab has been disabled with no replacement to avoid potential conflicts with other plugins.
  enabled = false,
  init = function()      vim.g['SuperTabDefaultCompletionType'] = '<C-n>'
  end,
}
