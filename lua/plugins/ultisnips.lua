-- ==========
--  ULTISNIPS
-- ==========

-- repo url: <https://github.com/sirver/ultisnips>
-- nvim help: `:help UltiSnips`

return {
  'sirver/ultisnips',
  init = function()      
    -- vim.g['UltiSnipsRemoveSelectModeMappings'] = 1
    -- vim.g['UltiSnipsMappingsToIgnore'] = { 'somePlugin', 'otherPlugin' }
    -- vim.g['UltiSnipsNoPythonWarning'] = 1
    vim.g['UltiSnipsEditSplit'] = 'tabdo'
    -- let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit
    -- vim.g['UltiSnipsSnippetDirectories'] = { 'UltiSnips' }
    vim.g['UltiSnipsSnippetDirectories'] = {vim.fn.stdpath('data') .. '/lazy/vim-snippets/UltiSnips'}
    -- vim.g['UltiSnipsEnableSnipMate'] = 1
    -- -- note: expand and jump can be set to the same value to use an
    --  expand_or_jump function
    -- -- default keybindings
    -- vim.g['UltiSnipsListSnippets'] = '<c-tab>'
    -- vim.g['UltiSnipsExpandTrigger'] = '<tab>'
    -- vim.g['UltiSnipsJumpForwardTrigger'] = '<c-j>'
    -- vim.g['UltiSnipsJumpBackwardTrigger'] = '<c-k>'
    -- -- tab only keybindings
    vim.g['UltiSnipsExpandTrigger'] = "<tab>"
    vim.g['UltiSnipsJumpForwardTrigger'] = "<tab>"
    vim.g['UltiSnipsJumpBackwardTrigger'] = "<s-tab>"
    -- -- <LEFT> <RIGHT> keybindins
    -- vim.g['UltiSnipsJumpForwardTrigger'] = '<RIGHT>'
    -- vim.g['UltiSnipsJumpBackwardTrigger'] = '<LEFT>'
  end,
}
