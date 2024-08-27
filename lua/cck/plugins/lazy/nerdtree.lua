-- ========
-- NERDTREE
-- ========

-- repo url: <https://github.com/scrooloose/nerdtree'>
-- nvim help: `:help nerdtree`

return {
  -- == PLUGIN DISABLED ==
  -- This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one.
  -- It is temporarily disabled until it passed manual inspection to check that it has been converted correctly.
  enabled = false,
  'scrooloose/nerdtree',
  init = function()      
    vim.g['NERDTreeUseTCD'] = 0
    vim.g['NERDTreeChDirMode'] = 3
    vim.g['NERDTreeQuitOnOpen'] = 1
    vim.g['NERDTreeShowBookmarks'] = 1
  end,
}
