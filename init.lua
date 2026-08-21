vim.cmd.colorscheme "darkblue"

local my = require "my"
_G.My = my

my.setup.load_my_rs()

my.setup.init_my_config()

my.setup.set_my_config_opts()

my.setup.set_nvim_opts_and_vars()

my.setup.init_lzplugin_manifest()

my.setup.collect_my_inits()

my.setup.init_keymap_groups()

my.setup.load_keymaps_table()

my.setup.lazy_nvim_bootstrap()

my.setup.init_plugins()

my.setup.init_filetypes()

my.setup.init_workspaces()

my.setup.lazy_nvim_load_plugins()

my.setup.after_add_keymaps()

my.setup.after_apply_lsp_configs()

my.setup.after_add_autodmds_core()

my.setup.after_add_autocmds_filetypes()

my.setup.after_add_autocmds_projects()

my.setup.after_add_autodmds_autostart()

vim.cmd.colorscheme "solarized-osaka"
