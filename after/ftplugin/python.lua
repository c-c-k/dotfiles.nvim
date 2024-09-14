if vim.b["did_ftplugin_cck_python"] then return end
vim.b["did_ftplugin_cck_python"] = true

local astrocore = require "astrocore"
local maps = astrocore.empty_map_table()
local map, mapf = require('cck.utils.config').get_astrocore_mapper(maps)

map("n", "<LEADER>flc", [=[<CMD>FzfBLines ^\s*class<CR>]=], { desc = "Find(FZF) python classes (buffer)" })
map("n", "<LEADER>fld", [=[<CMD>FzfBLines ^\s*def<CR>]=], { desc = "Find(FZF) python defs (buffer)" })
map(
  "n",
  "<LEADER>fli",
  [=[<CMD>FzfBLines ^\v\s*(import<BAR>from.*import)<CR>]=],
  { desc = "Find(FZF) python imports (buffer)" }
)
map("n", "<LEADER>fln", [=[<CMD>FzfBLines #<CR>]=], { desc = "Find(FZF) python comments (buffer)" })
map("n", "<LEADER>flo", [=[<CMD>FzfBLines ^\v\u+<CR>]=], { desc = "Find(FZF) python constants (buffer)" })

astrocore.set_mappings(maps, { buffer = true })
