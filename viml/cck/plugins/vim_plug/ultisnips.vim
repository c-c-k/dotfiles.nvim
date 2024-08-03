" ---------------------------------------------------------------------------
"  ULTISNIPS
" ---------------------------------------------------------------------------
" see: <https://github.com/sirver/ultisnips>
" see: `:help UltiSnips`

" let g:UltiSnipsRemoveSelectModeMappings = 1
" let g:UltiSnipsMappingsToIgnore = [ 'somePlugin', 'otherPlugin' ]
" let g:UltiSnipsNoPythonWarning = 1
let g:UltiSnipsEditSplit = 'tabdo'
" let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit
" let g:UltiSnipsSnippetDirectories = [ 'UltiSnips' ]
let g:UltiSnipsSnippetDirectories=[expand('$NVIM_VIM_PLUG_ROOT/vim-snippets/UltiSnips')]
" let g:UltiSnipsEnableSnipMate = 1
" -- note: expand and jump can be set to the same value to use an
"  expand_or_jump function
" -- default keybindings
" let g:UltiSnipsListSnippets = '<c-tab>'
" let g:UltiSnipsExpandTrigger = '<tab>'
" let g:UltiSnipsJumpForwardTrigger = '<c-j>'
" let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
" -- tab only keybindings
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" -- <LEFT> <RIGHT> keybindins
" let g:UltiSnipsJumpForwardTrigger = '<RIGHT>'
" let g:UltiSnipsJumpBackwardTrigger = '<LEFT>'
