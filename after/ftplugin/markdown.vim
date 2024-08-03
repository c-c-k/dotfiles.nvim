if (exists('b:did_ftplugin_my_markdown') && b:did_ftplugin_my_markdown)
    finish
endif
let b:did_ftplugin_my_markdown = 1

map <buffer><LEADER>flh :FzfBLines ^\v#{1,7} <CR>
map <buffer><LEADER>fll :FzfBLines \v(\[([^ x-]<BAR>[^]]{2,})]<BAR>\<[^>]{2,}\><BAR><https?://)<CR>
