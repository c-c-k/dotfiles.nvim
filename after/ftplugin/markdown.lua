-- Override NVIM defaults.
-- Needs to be done before the `did_ftplugin` check due to lazy.nvim emitting
-- filetype autocommands multiple times and NVIM executing the default filetype
-- config each time, see:
--  * https://github.com/folke/lazy.nvim/issues/1993
vim.opt_local.formatoptions = "tcroqwn2l1j"

if vim.b["did_ftplugin_my_markdown"] then return end
vim.b["did_ftplugin_my_markdown"] = true

local astrocore = require "astrocore"
local maps, map = require("my.core.keymaps").get_astrocore_mapper()

map({ "n", "x" }, "<LEADER>gf", "<CMD>MyGoToFile<CR>", { desc = "goto file" })
map({ "n", "x" }, "<LEADER>gx", "<CMD>MyGoToEx<CR>", { desc = "goto external" })
map({ "n", "x" }, "gf", "<CMD>MyGoToFile<CR>", { desc = "goto file" })
map({ "n", "x" }, "gx", "<CMD>MyGoToEx<CR>", { desc = "goto external" })

astrocore.set_mappings(maps, { buffer = true })
