-- ===========
-- VIM-AIRLINE
-- ===========

-- repo url: <https://github.com/vim-airline/vim-airline>
-- nvim help: `:help vim-airline`

return {
  'vim-airline/vim-airline',
  -- == PLUGIN DISABLED ==
  -- Replaced by AstroNvim statusline
  -- MEMO: When enabling/disabling also enable/disable after/plugin/vim-airline-after.vim
  enabled = false,
  dependencies = { 'vim-airline/vim-airline-themes' },
  init = function()      
    vim.g['airline_experimental'] = 0
    -- vim.g['airline_left_sep'] = '>'
    -- vim.g['airline_right_sep'] = '<'
    -- vim.g['airline_detect_modified'] = 1
    -- vim.g['airline_detect_paste'] = 1
    -- vim.g['airline_detect_crypt'] = 1
    vim.g['airline_detect_spell'] = 0
    vim.g['airline_detect_spelllang'] = 0
    -- vim.g['airline_detect_iminsert'] = 0
    -- vim.g['airline_inactive_collapse'] = 1
    -- vim.g['airline_inactive_alt_sep'] = 1
    vim.g['airline_theme'] = 'solarized_flood'
    -- vim.g['airline_theme_patch_func'] = 'AirlineThemePatch'
    -- vim.g['airline_powerline_fonts'] = 1
    -- vim.g['airline_symbols_ascii'] = 1
    -- vim.g['airline_mode_map'] = {} " see source for the defaults
    -- vim.g['airline_mode_map'] = {}
    -- vim.g['airline_exclude_filenames'] = {} " see source for current list
    -- vim.g['airline_exclude_filetypes'] = {} " see source for current list
    -- vim.g['airline_filetype_overrides'] = {}
    -- vim.g['airline_exclude_preview'] = 0
    -- vim.w['airline_disable_statusline '] =  1
    -- vim.g['airline_disable_statusline'] = 1
    -- vim.b['airline_disable_statusline '] =  1
    -- vim.g['airline_skip_empty_sections'] = 1
    -- vim.w['airline_skip_empty_sections '] =  0
    -- vim.g['airline_highlighting_cache'] = 0
    -- vim.g['airline_focuslost_inactive'] = 0
    -- vim.g['airline#parts#ffenc#skip_expected_string'] = 'utf-8{unix}'
    -- vim.g['airline_statusline_ontop'] = 1
    -- vim.g['airline_stl_path_style'] = 'short'
    -- vim.g['airline_section_c_only_filename'] = 1
    
    -- symbol overides
    -- to help with unicode induced misalignment
    -- ! needs to be applied in `after` to take effect.
    
    -- unicode symbols
    -- vim.g['airline_left_sep'] = '»'
    -- vim.g['airline_left_sep'] = '▶'
    -- vim.g['airline_right_sep'] = '«'
    -- vim.g['airline_right_sep'] = '◀'
    -- vim.g['airline_symbols.colnr'] = ' ㏇:'
    -- vim.g['airline_symbols.colnr'] = ' ℅:'
    -- vim.g['airline_symbols.crypt'] = '🔒'
    -- vim.g['airline_symbols.linenr'] = '☰'
    -- vim.g['airline_symbols.linenr'] = ' ␊:'
    -- vim.g['airline_symbols.linenr'] = ' ␤:'
    -- vim.g['airline_symbols.linenr'] = '¶'
    -- vim.g['airline_symbols.maxlinenr'] = ''
    -- vim.g['airline_symbols.maxlinenr'] = '㏑'
    -- vim.g['airline_symbols.branch'] = '⎇'
    -- vim.g['airline_symbols.paste'] = 'ρ'
    -- vim.g['airline_symbols.paste'] = 'Þ'
    -- vim.g['airline_symbols.paste'] = '∥'
    -- vim.g['airline_symbols.spell'] = 'Ꞩ'
    -- vim.g['airline_symbols.notexists'] = 'Ɇ'
    -- vim.g['airline_symbols.notexists'] = '∄'
    -- vim.g['airline_symbols.whitespace'] = 'Ξ'
    
    -- powerline symbols
    -- vim.g['airline_left_sep'] = ''
    -- vim.g['airline_left_alt_sep'] = ''
    -- vim.g['airline_right_sep'] = ''
    -- vim.g['airline_right_alt_sep'] = ''
    -- vim.g['airline_symbols.branch'] = ''
    -- vim.g['airline_symbols.colnr'] = ' ℅:'
    -- vim.g['airline_symbols.readonly'] = ''
    -- vim.g['airline_symbols.linenr'] = ' :'
    -- vim.g['airline_symbols.maxlinenr'] = '☰ '
    -- vim.g['airline_symbols.dirty'] = '⚡'
    
    -- old vim-powerline symbols
    -- vim.g['airline_left_sep'] = '⮀'
    -- vim.g['airline_left_alt_sep'] = '⮁'
    -- vim.g['airline_right_sep'] = '⮂'
    -- vim.g['airline_right_alt_sep'] = '⮃'
    -- vim.g['airline_symbols.branch'] = '⭠'
    -- vim.g['airline_symbols.readonly'] = '⭤'
    -- vim.g['airline_symbols.linenr'] = '⭡'
  end,
}
