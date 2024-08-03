" ---------------------------------------------------------------------------
"" CCK-Notes
" ---------------------------------------------------------------------------
" This pseudo-plugin configuration file is meant for extra notebooks related
" configuration need for the customization in `lua/cck` and
" `rplugin/.../cck/`.

map <LEADER>ne :CCKEditNote 
map <LEADER>nl :CCKAddNoteRefLink 
map <LEADER>nll :CCKAddNoteRefLink 
map <LEADER>nlc :CCKAddClipboardRefLink 

let g:cck_uri_resolvers = [
            \'cck.pkbm.resolve_uri_as_path',
\]
let g:cck_notebook_prefix = 'cck-'

let g:cck_notebooks = [
            \{
                \'name': 'pkb',
                \'path': '$NOTEBOOKS_PKB_ROOT',
                \'notes_path': '',
                \'filename_template': '${TITLE_CLEAN}',
                \'templates_path': '$NOTEBOOKS_TEMPLATES',
                \'default_template': '$NOTEBOOKS_TEMPLATES/basic_note.tpl',
            \},
            \{
                \'name': 'test',
                \'path': '$NOTEBOOKS_TEST_NB_ROOT/cck/nb1',
                \'notes_path': 'notes',
                \'filename_template': '${TITLE_CLEAN}',
                \'templates_path': '$NOTEBOOKS_TEMPLATES',
                \'default_template': '$NOTEBOOKS_TEMPLATES/basic_note.tpl',
            \},
            \{
                \'name': 'test2',
                \'path': '$NOTEBOOKS_TEST_NB_ROOT/cck/nb2',
                \'notes_path': 'other',
                \'filename_template': '%s-${TITLE_CLEAN}',
                \'templates_path': '$NOTEBOOKS_TEMPLATES',
                \'default_template': '$NOTEBOOKS_TEMPLATES/basic_note.tpl',
            \},
\]

