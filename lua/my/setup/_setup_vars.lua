local my = require "my"

my.vars.setup_optinal_vars {
  _var_defaults = { b = true, w = true, t = true, g = false, bp = false, wp = false, tp = false, gp = false },
}
my.vars.setup_var_accessors()

my.g.auto_cd_root = false
my.bp.cmp_enabled:set(my.vp.GLOBAL_DEFAULT, true)
my.bp.codelens_enabled:set(my.vp.GLOBAL_DEFAULT, true)
my.bp.format:set(my.vp.GLOBAL_DEFAULT, true)
my.bp.format_on_save:set(my.vp.GLOBAL_DEFAULT, true)
my.bp.format_timeout_ms:set(my.vp.GLOBAL_DEFAULT, 1000)
my.g.icons_enabled = true
my.bp.illuminate_freeze:set(my.vp.GLOBAL_DEFAULT, false)
my.bp.illuminate_invisible:set(my.vp.GLOBAL_DEFAULT, false)
my.bp.illuminate_pause:set(my.vp.GLOBAL_DEFAULT, false)
my.bp.indent_guide:set(my.vp.GLOBAL_DEFAULT, true)
my.wp.indent_guide:set(my.vp.GLOBAL_DEFAULT, true)
my.g.hlsearch_auto_off_modes = { "n", "v", "V", "<C-V>" }
my.g.hlsearch_keep_keys = { "n", "N", "*", "#", "?", "/" }
my.g.lsp_file_ops_timeout_ms = 5000
my.bp.lsp_semantic_hl:set(my.vp.GLOBAL_DEFAULT, true)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.python3_host_prog = vim.fn.stdpath "config" .. "/.venv/bin/python3"
my.g.root_markers = { ".git" }
my.bp.syntax:set(my.vp.GLOBAL_DEFAULT, "off")
my.g.tab_labels = [==[sfnjklhodweimbuyvrgtaqpcxzSFNJKLHODWEIMBUYVRGTAQPCXZ]==]
my.g.toggle_notifications = true
