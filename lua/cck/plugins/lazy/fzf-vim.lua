-- =======
-- FZF-VIM
-- =======

-- repo url: <https://github.com/junegunn/fzf.vim>
-- nvim help: `:help fzf-vim`

return {
  -- == PLUGIN DISABLED ==
  -- This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one.
  -- It is temporarily disabled until it passed manual inspection to check that it has been converted correctly.
  enabled = false,
  'junegunn/fzf.vim',
  init = function()      
    vim.g['fzf_buffers_jump'] = 0
    vim.g['fzf_command_prefix'] = 'Fzf'
  end,
}
