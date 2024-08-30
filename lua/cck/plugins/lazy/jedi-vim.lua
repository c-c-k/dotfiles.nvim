-- ========
-- JEDI-VIM
-- ========

-- repo url: <https://github.com/davidhalter/jedi-vim>
-- nvim help: `:help jedi-vim

return {
  -- == PLUGIN DISABLED ==
  -- MEMO: This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one and requires a manual inspection to check that it has been converted correctly.
  -- Jedi-vim is integrated into YCM
  enabled = false,
  'davidhalter/jedi-vim',
  init = function()      
    vim.g['jedi#goto_command'] = "<LEADER>jd"
    vim.g['jedi#goto_assignments_command'] = "<LEADER>jg"
    vim.g['jedi#goto_stubs_command'] = "<LEADER>js"
    vim.g['jedi#rename_command'] = "<LEADER>jr"
    vim.g['jedi#rename_command_keep_name'] = "<LEADER>jR"
    vim.g['jedi#usages_command'] = "<LEADER>jn"
    vim.g['jedi#use_tabs_not_buffers'] = 1
    --vim.g['jedi#force_py_version'] = 'auto'
    vim.g['jedi#smart_auto_mappings'] = 1
    --vim.g['jedi#environment_path'] = 'auto'
    --vim.g['jedi#added_sys_path'] = {}
  end,
}
