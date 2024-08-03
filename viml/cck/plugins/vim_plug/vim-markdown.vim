" ---------------------------------------------------------------------------
" VIM-MARKDOWN
" ---------------------------------------------------------------------------
" see: <https://github.com/preservim/vim-markdown>
" see: `:help vim-markdown`

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_override_foldtext = 0
" let g:vim_markdown_folding_level = 6
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_anchorexpr = "'\\\c^#\\\+\\\s*'.substitute(v:anchor, '-', '.', 'g')"
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_edit_url_in = 'tab'
