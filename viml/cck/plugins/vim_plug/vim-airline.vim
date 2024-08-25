" ---------------------------------------------------------------------------
" VIM-AIRLINE
" ---------------------------------------------------------------------------
" see: <https://github.com/vim-airline/vim-airline>
" see: `:help vim-airline`

" MEMO: Enable plugin extra config in `after/`

let g:airline_experimental = 0
" let g:airline_left_sep='>'
" let g:airline_right_sep='<'
" let g:airline_detect_modified=1
" let g:airline_detect_paste=1
" let g:airline_detect_crypt=1
let g:airline_detect_spell=0
let g:airline_detect_spelllang=0
" let g:airline_detect_iminsert=0
" let g:airline_inactive_collapse=1
" let g:airline_inactive_alt_sep=1
let g:airline_theme='solarized_flood'
" let g:airline_theme_patch_func = 'AirlineThemePatch'
" let g:airline_powerline_fonts = 1
" let g:airline_symbols_ascii = 1
" let g:airline_mode_map = {} " see source for the defaults
" let g:airline_mode_map = {}
" let g:airline_exclude_filenames = [] " see source for current list
" let g:airline_exclude_filetypes = [] " see source for current list
" let g:airline_filetype_overrides = {}
" let g:airline_exclude_preview = 0
" let w:airline_disable_statusline = 1
" let g:airline_disable_statusline = 1
" let b:airline_disable_statusline = 1
" let g:airline_skip_empty_sections = 1
" let w:airline_skip_empty_sections = 0
" let g:airline_highlighting_cache = 0
" let g:airline_focuslost_inactive = 0
" let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" let g:airline_statusline_ontop = 1
" let g:airline_stl_path_style = 'short'
" let g:airline_section_c_only_filename = 1

" symbol overides
" to help with unicode induced misalignment
" ! needs to be applied in `after` to take effect.

" unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.colnr = ' ㏇:'
" let g:airline_symbols.colnr = ' ℅:'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.linenr = ' ␊:'
" let g:airline_symbols.linenr = ' ␤:'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = 'Ɇ'
" let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.colnr = ' ℅:'
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ' :'
" let g:airline_symbols.maxlinenr = '☰ '
" let g:airline_symbols.dirty='⚡'

" old vim-powerline symbols
" let g:airline_left_sep = '⮀'
" let g:airline_left_alt_sep = '⮁'
" let g:airline_right_sep = '⮂'
" let g:airline_right_alt_sep = '⮃'
" let g:airline_symbols.branch = '⭠'
" let g:airline_symbols.readonly = '⭤'
" let g:airline_symbols.linenr = '⭡'
