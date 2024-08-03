" ---------------------------------------------------------------------------
"  YCM
" ---------------------------------------------------------------------------
" see: <https://github.com/ycm-core/youcompleteme>
" see: `:help youcompleteme`

" -- key maps
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_key_list_stop_completion = ['<C-y>']
" let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_key_detailed_diagnostics = '<LEADER>jd'

" -- disable ycm syntax checking
let g:ycm_echo_current_diagnostic = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_show_diagnostics_ui = 0

" -- identifier-based completion only
" let g:ycm_min_num_of_chars_for_completion = 2
" let g:ycm_min_num_identifier_candidate_chars = 0
" let g:ycm_max_num_identifier_candidates = 10

" -- semantic completion only
" let g:ycm_max_num_candidates = 50
" let g:ycm_max_num_candidates_to_detail = 0
" let g:ycm_filetype_specific_completion_to_disable = {
"       \ 'gitcommit': 1
"       \}

" -- semantic and identifier-based completion
" let g:ycm_auto_trigger = 0
" let g:ycm_filetype_whitelist = {'*': 1} | " default
" let g:ycm_filetype_whitelist = {
" \ '*': 1,
" \ 'ycm_nofiletype': 1
" \ } | " to enable completion in buffers without filetype
let g:ycm_filetype_blacklist = {
      \ 'infolog': 1,
      \ 'leaderf': 1,
      \ 'mail': 1,
      \ 'markdown': 1,
      \ 'netrw': 1,
      \ 'notes': 1,
      \ 'tagbar': 1,
      \ 'text': 1,
      \ 'pandoc': 1,
      \ 'unite': 1,
      \ 'vimwiki': 1
      \}
" let g:ycm_filepath_blacklist = {'*': 1} | " disable filepath completion
" let g:ycm_filepath_blacklist = {
"       \ 'html': 1,
"       \ 'jsx': 1,
"       \ 'xml': 1,
"       \}
" b:ycm_hover " see help
" let g:ycm_auto_hover =  'CursorHold' " default, see help
" let g:ycm_auto_hover =  '' " disable auto info popup
" g:ycm_filter_diagnostics " see help
" let g:ycm_always_populate_location_list = 0
" let g:ycm_open_loclist_on_ycm_diags = 1
" let g:ycm_complete_in_comments = 0
" let g:ycm_complete_in_strings = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 0
" let g:ycm_collect_identifiers_from_tags_files = 0
" let g:ycm_seed_identifiers_with_syntax = 0
" let g:ycm_extra_conf_vim_data = []
" let g:ycm_server_python_interpreter = ''
" let g:ycm_keep_logfiles = 0
" let g:ycm_log_level = 'info'
" let g:ycm_add_preview_to_completeopt = 0
" let g:ycm_autoclose_preview_window_after_completion = 0
" let g:ycm_autoclose_preview_window_after_insertion = 0
" let g:ycm_max_diagnostics_to_display = 30
let g:ycm_show_detailed_diag_in_popup = 1
" let g:ycm_global_ycm_extra_conf = ''
" let g:ycm_confirm_extra_conf = 1
" let g:ycm_extra_conf_globlist = [] " see help
" let g:ycm_filepath_completion_use_working_dir = 0
" let g:ycm_semantic_triggers =  {
"   \   'c': ['->', '.'],
"   \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
"   \            're!\[.*\]\s'],
"   \   'ocaml': ['.', '#'],
"   \   'cpp,cuda,objcpp': ['->', '.', '::'],
"   \   'perl': ['->'],
"   \   'php': ['->', '::'],
"   \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
"   \   'ruby,rust': ['.', '::'],
"   \   'lua': ['.', ':'],
"   \   'erlang': [':'],
"   \ }
" let g:ycm_cache_omnifunc = 1
" let g:ycm_use_ultisnips_completer = 1
" let g:ycm_goto_buffer_command = 'same-buffer' " default
" let g:ycm_disable_for_files_larger_than_kb = 1000
" let g:ycm_language_server = [] " see help
" let g:ycm_disable_signature_help = 0
" g:ycm_tsserver_binary_path " see help
" let g:ycm_update_diagnostics_in_insert_mode = 1
