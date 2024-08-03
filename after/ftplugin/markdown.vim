if (exists('b:did_ftplugin_my_markdown') && b:did_ftplugin_my_markdown)
    finish
endif
let b:did_ftplugin_my_markdown = 1

map <buffer><LEADER>gf :CCKGoToFile<CR>
map <buffer><LEADER>gx :CCKGoToEx<CR>
map <buffer>gf :CCKGoToFile<CR>
map <buffer>gx :CCKGoToEx<CR>
"nnoremap <buffer><LEADER><CR> :.s/\[v]/[ ]/e<CR><CR>
"vnoremap <buffer><LEADER><CR> :s/\[v]/[ ]/e<CR><CR>
map <buffer><LEADER>flh :FzfBLines ^\v#{1,7} <CR>
map <buffer><LEADER>fll :FzfBLines \v(\[([^ x-]<BAR>[^]]{2,})]<BAR>\<[^>]{2,}\><BAR><https?://)<CR>
