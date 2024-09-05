-- =========
--  SUPERTAB
-- =========

-- repo url: <https://github.com/ervandew/supertab>
-- nvim help: `:help supertab`

return {
  'ervandew/supertab',
  init = function()      vim.g['SuperTabDefaultCompletionType'] = '<C-n>'
  end,
}
