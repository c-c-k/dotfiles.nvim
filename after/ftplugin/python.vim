if (exists('b:did_ftplugin_my_python') && b:did_ftplugin_my_python)
    finish
endif
let b:did_ftplugin_my_python = 1

map <buffer><LEADER>fla :FzfBLines ^\v(\s*def<BAR>\s*class<BAR>[A-Z_]<BAR>import<BAR>from)<CR>
map <buffer><LEADER>flc :FzfBLines ^\s*class<CR>
map <buffer><LEADER>flf :FzfBLines ^\s*def<CR>
map <buffer><LEADER>fli :FzfBLines ^\v(import<BAR>from)<CR>
map <buffer><LEADER>fln :FzfBLines #<CR>
map <buffer><LEADER>flo :FzfBLines ^[A-Z_]<CR>
