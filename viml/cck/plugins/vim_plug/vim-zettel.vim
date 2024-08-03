" ---------------------------------------------------------------------------
"" VIM-ZETTEL
" ---------------------------------------------------------------------------
" see: <https://github.com/michal-h21/vim-zettel>
" see `:help zettel`

let s:vimwikiroot = [expand('$NOTEBOOKS_TEST_NB_ROOT/vimwiki')]

let g:zettel_options = [
   \   {
   \        'disable_front_matter' : 0,
   \        'front_matter' : [["tags", ""], ["type","note"]],
   \        'template' : s:vimwikiroot.. '/templates/zettel.tpl',
   \   }
   \]
let g:zettel_format = "%Y%m%dT%H%M%S-%title"
let g:zettel_default_title = "PLACEHOLDER_TITLE"
let g:zettel_date_format = "%Y-%m-%d %H:%M"
let g:zettel_default_mappings = 1
" let g:zettel_fzf_command = "ag"
" let g:zettel_fzf_options = ['--exact', '--tiebreak=end']
" let g:zettel_generated_index_title = "Generated Index"
" let g:zettel_generated_index_title_level = 1
" let g:zettel_backlinks_title = "Backlinks"
" let g:zettel_backlinks_title_level = 1
" let g:zettel_unlinked_notes_title = "Unlinked Notes"
" let g:zettel_unlinked_notes_title_level = 1
" let g:zettel_generated_tags_title = "Generated Tags"
" let g:zettel_generated_tags_title_level = 1
" let g:zettel_link_format="[%title](%link)"
" let g:zettel_random_chars=8
let g:zettel_bufflist_format = "%filename"
