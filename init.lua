local my = require "my"
_G.My = my

vim.cmd.colorscheme "darkblue"
my.setup.lazy_nvim.bootstrap()

require "my.setup._setup_vars"
require "my.setup._setup_nvim_opts"
require "my.setup._init_core"
my.ft.init_filetypes()

my.setup.lazy_nvim.setup()

require "my.setup._setup_keymaps"
require "my.setup._setup_autocommands"
vim.cmd.colorscheme "solarized-osaka"
