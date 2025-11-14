if vim.b["did_ftplugin_my_go"] then return end
vim.b["did_ftplugin_my_go"] = true

vim.opt_local.expandtab = false
vim.opt_local.textwidth = 0
vim.opt_local.shiftwidth = 0
vim.opt_local.softtabstop = 0
vim.opt_local.tabstop = 2
