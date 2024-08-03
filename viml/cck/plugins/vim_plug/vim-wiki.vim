" ---------------------------------------------------------------------------
"" VIMWIKI
" ---------------------------------------------------------------------------
" see: <https://github.com/vimwiki/vimwiki>
" see `:help vimwiki`

let s:vimwikiroot = [expand('$NOTEBOOKS_TEST_NB_ROOT/vimwiki')]

let g:vimwiki_list = [
    \    {
    \        'path': s:vimwikiroot .. '/wiki',
    \        'path_html': s:vimwikiroot .. '/html',
    \        'template_path': s:vimwikiroot.. '/templates',
    \        'ext': '.md',
    \        'diary_start_week_day': 'sunday',
    \        'links_space_char': '_',
    \    }
    \]

" let g:vimwiki_CJK_length = 0
" let g:vimwiki_auto_chdir = 0
" let g:vimwiki_auto_header = 0
" let g:vimwiki_autowriteall = 1
" let g:vimwiki_commentstring = '%%%s'
let g:vimwiki_conceal_onechar_markers = 0
" let g:vimwiki_conceal_pre = 0
let g:vimwiki_conceallevel = 0
" let g:vimwiki_create_link = 1
" let g:vimwiki_diary_months = {1: 'January',...}
" let g:vimwiki_dir_link = ''
" let g:vimwiki_emoji_enable = 3
" let g:vimwiki_ext2syntax = {'.md': markdown, ..., '.mw': 'media'}
" let g:vimwiki_filetypes = []
let g:vimwiki_folding = 'expr:quick'
let g:vimwiki_global_ext = 0
" let g:vimwiki_hl_cb_checked = 0
" let g:vimwiki_hl_headers = 0
" let g:vimwiki_html_header_numbering = 0
" let g:vimwiki_html_header_numbering_sym = ''
let g:vimwiki_key_mappings = {
    \   'all_maps': 0,
    \   'global': 0,
    \   'headers': 0,
    \   'text_objs': 0,
    \   'table_format': 0,
    \   'table_mappings': 0,
    \   'lists': 0,
    \   'links': 0,
    \   'html': 0,
    \   'mouse': 0,
    \ }
" let g:vimwiki_links_header = 'Generated Links'
" let g:vimwiki_links_header_level = 1
" let g:vimwiki_listing_hl = 0
" let g:vimwiki_listing_hl_command = 'pygmentize -f html'
" let g:vimwiki_listsyms = ' .oOX'
" let g:vimwiki_listsym_rejected = '-'
let g:vimwiki_map_prefix = '<LEADER>n'
" let g:vimwiki_markdown_header_style = 1
let g:vimwiki_markdown_link_ext = 1
" let g:vimwiki_max_scan_for_caption = 5
" let g:vimwiki_menu = 'Vimwiki'
" let g:vimwiki-option-color_dic = {}
" let g:vimwiki-option-rx_todo = '...'
" let g:vimwiki-option-color_tag_template = '...'
" let g:vimwiki_schemes_any = [...]
" let g:vimwiki_schemes_web = [...]
" let g:vimwiki_syntaxlocal_vars = {...}
" let g:vimwiki_table_auto_fmt = 1
" let g:vimwiki_table_reduce_last_col = 0
let g:vimwiki_tag_format = {'pre': '\(^[ -]*tags\s*: .*\)\@<=',
    \ 'pre_mark': '@', 'post_mark': '', 'sep': '>><<'}
" let g:vimwiki_tags_header = 'Generated Tags'
" let g:vimwiki_tags_header_level = 1
" let g:vimwiki_text_ignore_newline = 1
" let g:vimwiki_toc_header = 'Contents'
" let g:vimwiki_toc_header_level = 1
" let g:vimwiki_toc_link_format = 0
" let g:vimwiki_url_maxsave = 15
" let g:vimwiki_use_calendar = 1
" let g:vimwiki_user_htmls = ''
" let g:vimwiki_valid_html_tags = 'b,i,s,u,sub,sup,kbd,br,hr'
" let g:vimwiki_w32_dir_enc = ''

" vimwiki_list entry example
"     \    {
"     \        'path': '~/vimwiki/',
"     \        'path_html': '',
"     \        'name': '',
"     \        'auto_export': 0,
"     \        'auto_toc': 0,
"     \        'index': 'index',
"     \        'ext': '.wiki',
"     \        'syntax': 'default',
"     \        'links_space_char': ' ',
"     \        'template_path': '~/vimwiki/templates/',
"     \        'template_default': 'default',
"     \        'template_ext': '.tpl',
"     \        'template_date_format': '%Y-%m-%d',
"     \        'css_name': 'style.css',
"     \        'maxhi': 0,
"     \        'nested_syntaxes': {},
"     \        'automatic_nested_syntaxes': 1,
"     \        'diary_rel_path': 'diary/',
"     \        'diary_index': 'diary',
"     \        'diary_header': 'Diary',
"     \        'diary_sort': 'desc',
"     \        'diary_caption_level': 0,
"     \        'diary_frequency': 'daily',
"     \        'diary_start_week_day': 'monday',
"     \        'custom_wiki2html': '',
"     \        'custom_wiki2html_args': '',
"     \        'list_margin': -1,
"     \        'bullet_types': [-', '*', '#']',
"     \        'cycle_bullets': 0,
"     \        'generated_links_caption': 0,
"     \        'listsyms': ' .oOX',
"     \        'listsyms_rejected': '-',
"     \        'listsyms_propagate': 1,
"     \        'auto_tags': 0,
"     \        'auto_diary_index': 0,
"     \        'auto_generate_links': 0,
"     \        'auto_generate_tags': 0,
"     \        'exclude_files': [],
"     \        'html_filename_parameterization': 0,
"     \        'rss_name': 'rss.xml',
"     \        'rss_max_items': 10,
"     \        'base_url': '',
"     \    }
