-- ==================
-- NOTATIONAL-FZF-VIM
-- ==================

-- repo url: <https://github.com/alok/notational-fzf-vim'>
-- nvim help: `:tabe ~/.vim/plugged/notational-fzf-vim/README.md`

return {
  -- == PLUGIN DISABLED ==
  -- This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one.
  -- It is temporarily disabled until it passed manual inspection to check that it has been converted correctly.
  enabled = false,
  'alok/notational-fzf-vim',
  init = function()      
    vim.g['nv_default_extension'] = ''
    vim.g['nv_create_note_window'] = 'tabedit'
    vim.g['nv_search_paths'] = {vim.env['NOTEBOOKS_PKB_ROOT']}
  end,
}
