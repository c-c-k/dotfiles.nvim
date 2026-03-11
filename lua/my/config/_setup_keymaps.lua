local my = require "my"

require "my.keymap._auto_nohlsearch"
my.keymap.load_km_group(my.config.keymaps.g_core____)
my.keymap.load_queued_km_groups()
