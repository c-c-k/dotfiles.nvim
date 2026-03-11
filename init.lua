local my = require "my"
_G.My = my

vim.cmd.colorscheme "darkblue"
my.config.lazy_nvim.bootstrap()

require "my.config._setup_vars"
require "my.config._setup_nvim_opts"
require "my.config._init_core"
my.ft.init_filetypes()

my.config.lazy_nvim.setup()

require "my.config._setup_keymaps"
require "my.config._setup_autocommands"
vim.cmd.colorscheme "solarized-osaka"
