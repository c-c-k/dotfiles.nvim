-- ========
-- NERDTREE
-- ========

-- repo url: <https://github.com/scrooloose/nerdtree'>
-- nvim help: `:help nerdtree`

return {
  -- == PLUGIN DISABLED ==
  -- Switched for oil.nvim and mini.files
  enabled = false,
  'scrooloose/nerdtree',
  init = function()      
    vim.g['NERDTreeUseTCD'] = 0
    vim.g['NERDTreeChDirMode'] = 3
    vim.g['NERDTreeQuitOnOpen'] = 1
    vim.g['NERDTreeShowBookmarks'] = 1
  end,
}
