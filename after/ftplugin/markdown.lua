if vim.b["did_ftplugin_cck_markdown"] then return end
vim.b["did_ftplugin_cck_markdown"] = true

vim.opt_local.textwidth = 0

local astrocore = require "astrocore"
local maps, map = require("cck.utils.config").get_astrocore_mapper()

map({ "n", "x" }, "<LEADER>gf", "<CMD>CCKGoToFile<CR>", { desc = "(CCK) goto file" })
map({ "n", "x" }, "<LEADER>gx", "<CMD>CCKGoToFile<CR>", { desc = "(CCK) goto external" })
-- map({ "n", "x" }, "gf", "<CMD>CCKGoToFile<CR>", { desc = "(CCK) goto file" } )
-- map({ "n", "x" }, "gx", "<CMD>CCKGoToFile<CR>", { desc = "(CCK) goto external" } )
map("n", "<LEADER>flh", [=[<CMD>FzfBLines ^\v#{1,7}<CR>]=], { desc = "Find(FZF) MD headers (buffer)" })
map(
  "n",
  "<LEADER>fll",
  [=[<CMD>FzfBLines \v(\[([^ x-]<BAR>[^]]{2,})]<BAR>\<[^>]{2,}\><BAR><https?://)<CR>]=],
  { desc = "Find(FZF) MD links (buffer)" }
)

astrocore.set_mappings(maps, { buffer = true })
