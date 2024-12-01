if vim.b["did_ftplugin_cck_markdown"] then return end
vim.b["did_ftplugin_cck_markdown"] = true

vim.opt_local.textwidth = 0
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

local astrocore = require "astrocore"
local maps, map = require("cck.utils.config").get_astrocore_mapper()

map({ "n", "x" }, "<LEADER>gf", "<CMD>CCKGoToFile<CR>", { desc = "(CCK) goto file" })
map({ "n", "x" }, "<LEADER>gx", "<CMD>CCKGoToEx<CR>", { desc = "(CCK) goto external" })
-- map({ "n", "x" }, "gf", "<CMD>CCKGoToFile<CR>", { desc = "(CCK) goto file" } )
-- map({ "n", "x" }, "gx", "<CMD>CCKGoToFile<CR>", { desc = "(CCK) goto external" } )

astrocore.set_mappings(maps, { buffer = true })
