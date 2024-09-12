-- ==================
-- NOTATIONAL-FZF-VIM
-- ==================

-- repo url: <https://github.com/alok/notational-fzf-vim'>
-- nvim help: ``

return {
  -- == PLUGIN DISABLED ==
  -- MEMO: This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one and requires a manual inspection to check that it has been converted correctly.
  -- Notational-fzf-vim is disabled because it does not currently feel convenient for my note taking workflow.
  enabled = false,
  'alok/notational-fzf-vim',
  init = function()      
    vim.g['nv_default_extension'] = ''
    vim.g['nv_create_note_window'] = 'tabedit'
    vim.g['nv_search_paths'] = {vim.env['NOTEBOOKS_PKB_ROOT']}
  end,
}
