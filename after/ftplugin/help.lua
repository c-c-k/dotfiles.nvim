-- Override NVIM defaults.
-- Needs to be done before the `did_ftplugin` check due to lazy.nvim emitting
-- filetype autocommands multiple times and NVIM executing the default filetype
-- config each time, see:
--  * https://github.com/folke/lazy.nvim/issues/1993
vim.opt_local.conceallevel = 0

if vim.b["did_ftplugin_my_help"] then return end
vim.b["did_ftplugin_my_help"] = true
