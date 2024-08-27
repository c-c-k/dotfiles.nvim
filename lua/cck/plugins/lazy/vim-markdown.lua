-- ============
-- VIM-MARKDOWN
-- ============

-- repo url: <https://github.com/preservim/vim-markdown>
-- nvim help: `:help vim-markdown`

return {
  -- == PLUGIN DISABLED ==
  -- This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one.
  -- It is temporarily disabled until it passed manual inspection to check that it has been converted correctly.
  enabled = false,
  'preservim/vim-markdown',
  init = function()      
    vim.g['vim_markdown_folding_disabled'] = 1
    vim.g['vim_markdown_override_foldtext'] = 0
    -- vim.g['vim_markdown_folding_level'] = 6
    vim.g['vim_markdown_conceal_code_blocks'] = 0
    vim.g['vim_markdown_follow_anchor'] = 1
    vim.g['vim_markdown_anchorexpr'] = [['\\\c^#\\\+\\\s*'.substitute(v:anchor, '-', '.', 'g')]]
    vim.g['vim_markdown_strikethrough'] = 1
    vim.g['vim_markdown_new_list_item_indent'] = 0
    vim.g['vim_markdown_edit_url_in'] = 'tab'
  end,
}
