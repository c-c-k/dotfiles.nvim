if vim.b["did_ftplugin_cck_markdown"] then return end
vim.b["did_ftplugin_cck_markdown"] = true

vim.opt_local.textwidth = 0
-- set indentation to 4 spaces to:
-- 1. Fall in line with mkdn-flow's hardcoded indent.
-- 2. Compensate for mdformat counting sub-indent in ordered lists
--  from after the last list enumeration digit and thus sees a 2 spaces
--  sub-indent as being only 1 spaces and therefor flattens the list.
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

local astrocore = require "astrocore"
local maps, map = require("cck.core.keymaps").get_astrocore_mapper()

map({ "n", "x" }, "<LEADER>gf", "<CMD>CCKGoToFile<CR>", { desc = "(CCK) goto file" })
map({ "n", "x" }, "<LEADER>gx", "<CMD>CCKGoToEx<CR>", { desc = "(CCK) goto external" })
map({ "n", "x" }, "gf", "<CMD>CCKGoToFile<CR>", { desc = "(CCK) goto file" })
map({ "n", "x" }, "gx", "<CMD>CCKGoToEx<CR>", { desc = "(CCK) goto external" })

astrocore.set_mappings(maps, { buffer = true })
