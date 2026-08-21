local my = require "my"
local config = my.config

config.auto_cd_root = false
config.cmp_enabled = true
config.codelens_enabled = true
config.format = true
config.format_on_save = true
config.format_timeout_ms = 1000
config.hlsearch_auto_off_modes = { "n", "v", "V", "<C-V>" }
config.hlsearch_keep_keys = { "n", "N", "*", "#", "?", "/" }
config.icons_enabled = true
config.illuminate_invisible = false
config.illuminate_pause = false
config.indent_guide = true
config.mason_clean_on_startup = true
-- config.mason_log_level = vim.log.levels.DEBUG
config.lsp_file_ops_timeout_ms = 5000
config.root_markers = { ".git" }
config.tab_labels = [==[sfnjklhodweimbuyvrgtaqpcxzSFNJKLHODWEIMBUYVRGTAQPCXZ]==]
config.toggle_notifications = true
