-- ==========
-- VIM-ZETTEL
-- ==========

-- repo url: <https://github.com/michal-h21/vim-zettel>
-- nvim help: `:help zettel`

return {
  -- == PLUGIN DISABLED ==
  -- MEMO: This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one and requires a manual inspection to check that it has been converted correctly.
  -- Vim-zettel is disabled because it does not currently feel convenient for my note taking workflow.
  enabled = false,
  'michal-h21/vim-zettel',
  init = function()      
    local vimwikiroot = {vim.fn.expand('$NOTEBOOKS_TEST_NB_ROOT/vimwiki')}
    
    vim.g['zettel_options'] = {
       {
            disable_front_matter = 0,
            front_matter = {{"tags", ""}, {"type","note"}},
            template = vimwikiroot.. '/templates/zettel.tpl',
       }
    }
    vim.g['zettel_format'] = "%Y%m%dT%H%M%S-%title"
    vim.g['zettel_default_title'] = "PLACEHOLDER_TITLE"
    vim.g['zettel_date_format'] = "%Y-%m-%d %H:%M"
    vim.g['zettel_default_mappings'] = 1
    -- vim.g['zettel_fzf_command'] = "ag"
    -- vim.g['zettel_fzf_options'] = {'--exact', '--tiebreak=end'}
    -- vim.g['zettel_generated_index_title'] = "Generated Index"
    -- vim.g['zettel_generated_index_title_level'] = 1
    -- vim.g['zettel_backlinks_title'] = "Backlinks"
    -- vim.g['zettel_backlinks_title_level'] = 1
    -- vim.g['zettel_unlinked_notes_title'] = "Unlinked Notes"
    -- vim.g['zettel_unlinked_notes_title_level'] = 1
    -- vim.g['zettel_generated_tags_title'] = "Generated Tags"
    -- vim.g['zettel_generated_tags_title_level'] = 1
    -- let g:zettel_link_format="{%title}(%link)"
    -- let g:zettel_random_chars=8
    vim.g['zettel_bufflist_format'] = "%filename"
  end,
}
