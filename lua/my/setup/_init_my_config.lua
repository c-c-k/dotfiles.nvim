local my = require "my"

local init_clear_on_buf_delete_handles_list = my.setup.utils.config.init_clear_on_buf_delete_handles_list
local init_clear_on_buf_wipeout_handles_list = my.setup.utils.config.init_clear_on_buf_wipeout_handles_list
local init_clear_on_buf_write_post_handles_list = my.setup.utils.config.init_clear_on_buf_write_post_handles_list
local init_clear_on_tab_closed_handles_list = my.setup.utils.config.init_clear_on_tab_closed_handles_list
local requires_init = my.setup.utils.requires_init

my.autocmd.get_augroup(my.setup.utils.config.CLEAN_UP_AUTOCMDS_GROUP, true)

---@class MyConfig
local config = {

  --- Auto cd ? root on ? (not implemented) (global)
  ---@type boolean
  auto_cd_root = false,

  --- Callback to delete a special buffer (buffer)
  ---@type table<BufId, fun(buf_id: BufId?)>
  close_buf = init_clear_on_buf_wipeout_handles_list(),

  --- Callback to close a special buffer fixed window (buffer)
  ---@type table<BufId, fun(buf_id: BufId?)>
  close_buf_fixed_win_buf = init_clear_on_buf_wipeout_handles_list(),

  --- completion enabled (global)
  ---@type boolean
  cmp_enabled = false,

  --- completion enabled (buffer)
  ---@type table<BufId, boolean>
  cmp_enabled_buf = init_clear_on_buf_wipeout_handles_list(),

  --- scroll documentation instead of selection (buffer)
  ---@type table<BufId, boolean>
  cmp_scroll_doc_buf = init_clear_on_buf_delete_handles_list(),

  --- list of cmp providers available for a buffer (buffer)
  ---@type table<BufId, string[]>
  cmp_providers_buf = init_clear_on_buf_wipeout_handles_list(),

  --- index of currently filtered cmp provider (buffer)
  ---@type table<BufId, integer>
  cmp_provider_index_buf = init_clear_on_buf_delete_handles_list(),

  --- list of the original cmp providers available for a buffer (buffer)
  ---@type table<BufId, string[]>
  cmp_providers_orig_buf = init_clear_on_buf_delete_handles_list(),

  --- LSP CodeLens capability enabled (global)
  ---@type boolean
  codelens_enabled = false,

  --- LSP CodeLens capability enabled (buffer)
  ---@type table<BufId, boolean>
  codelens_enabled_buf = init_clear_on_buf_wipeout_handles_list(),

  --- The last filetype that was applied (buffer)
  ---@type table<BufId, string>
  did_ftplugin_buf = init_clear_on_buf_wipeout_handles_list(),

  --- Enable LSP formatting (global)
  ---@type boolean
  format = false,

  --- Enable LSP formatting (buffer)
  ---@type table<BufId, boolean>
  format_buf = init_clear_on_buf_wipeout_handles_list(),

  --- LSP format on save (global)
  ---@type boolean
  format_on_save = false,

  --- LSP format on save (buffer)
  ---@type table<BufId, boolean>
  format_on_save_buf = init_clear_on_buf_wipeout_handles_list(),

  --- LSP formating timeout in milliseconds (global)
  ---@type integer
  format_timeout_ms = 0,

  --- LSP formating timeout in milliseconds (buffer)
  ---@type table<BufId, integer>
  format_timeout_ms_buf = init_clear_on_buf_wipeout_handles_list(),

  --- Function to get the file path of a buffer (meant for special buffers like fugitive)
  ---@type table<BufId, fun():string>
  get_file_path_func_buf = init_clear_on_buf_wipeout_handles_list(),

  --- Function to get the directory path of a buffer (meant for special buffers like fugitive)
  ---@type table<BufId, fun():string>
  get_dir_path_func_buf = init_clear_on_buf_wipeout_handles_list(),

  --- Callback to override default `gx` behavior(buffer)
  ---@type table<BufId, fun()>
  goto_external_buf = init_clear_on_buf_wipeout_handles_list(),

  --- Callback to override default `gf` behavior(buffer)
  ---@type table<BufId, fun()>
  goto_file_buf = init_clear_on_buf_wipeout_handles_list(),

  --- List of modes in which to auto turn off hlsearch
  ---@type string[]
  hlsearch_auto_off_modes = {},

  --- List of keys for which to not auto turn off hlsearch
  ---@type string[]
  hlsearch_keep_keys = {},

  --- Use glyphs for icons (requires patched Nerd Fonts)
  ---@type boolean
  icons_enabled = false,

  --- Freeze the current Vim.illuminate highlights (buffer)
  ---@type table<BufId, boolean>
  illuminate_freeze_buf = init_clear_on_buf_delete_handles_list(),

  --- Make Vim.illuminate highlights in/visible (global)
  ---@type boolean
  illuminate_invisible = false,

  --- Make Vim.illuminate highlights in/visible (buffer)
  ---@type table<BufId, boolean>
  illuminate_invisible_buf = init_clear_on_buf_delete_handles_list(),

  --- Pause Vim.illuminate highlights (global)
  ---@type boolean
  illuminate_pause = false,

  --- Pause Vim.illuminate highlights (buffer)
  ---@type table<BufId, boolean>
  illuminate_pause_buf = init_clear_on_buf_delete_handles_list(),

  --- enable indent guides (global)
  ---@type boolean
  indent_guide = false,

  --- enable indent guides (buffer)
  ---@type table<BufId, boolean>
  indent_guide_buf = init_clear_on_buf_wipeout_handles_list(),

  --- Keymap groups for the keymap loader
  ---@type MyKeymapLoaderGroups
  keymaps = requires_init "keymaps",

  --- Restored last cursor position from when the file was last edited has been restored (buffer)
  ---@type table<BufId, boolean>
  last_loc_restored_buf = init_clear_on_buf_delete_handles_list(),

  --- Set of mason lsp packages to install
  ---@type table<string, boolean|string>
  mason_ensure_installed = {},

  --- Clean all packages not listed in `mason_ensure_installed` on startup
  ---@type boolean
  mason_clean_on_startup = false,

  --- Log level for mason log
  ---@type vim.log.levels
  mason_log_level = vim.log.levels.INFO,

  --- List of functions defining null-ls sources
  ---@type (fun(null_ls: table):table[])[]
  null_ls_sources = {},

  --- List of snippet loaders for LuaSnip
  ---@type (fun())[]
  luasnip_loaders = {},

  --- List of functions returning the LSP config root dir for a buffer
  ---@type (fun(buf_id: BufId): string?)[]
  lsp_config_get_root_dir_funcs = {},

  --- Cache mapping root dirs to filenames (full buffer paths)
  ---@type table<string, string>
  lsp_filename_to_root_dir_cache = {},

  --- Name of custom (project) LSP configuration (buffer)
  ---@type table<BufId, string>
  lsp_custom_config_name_buf = init_clear_on_buf_wipeout_handles_list(),

  --- Previous diagnostic virtual lines setting (global)
  ---@type any
  lsp_prev_diagnostic_virtual_lines = nil,

  --- Previous diagnostic virtual text setting (global)
  ---@type any
  lsp_prev_diagnostic_virtual_text = nil,

  --- LSP file actions timeout in milliseconds (global)
  ---@type integer
  lsp_file_ops_timeout_ms = 0,

  --- LSP semantic Highlighting (buffer)
  ---@type table<BufId, boolean>
  lsp_semantic_hl_buf = init_clear_on_buf_wipeout_handles_list(),

  --- custom tab name (used in 'tabline' expression)
  ---@type table<TabId, string>
  name_tab = init_clear_on_tab_closed_handles_list(),

  --- Buffer for which an on disk file has not been created yet
  ---@type table<BufId, string|boolean>
  new_file_buf = init_clear_on_buf_write_post_handles_list(),

  --- List of global default root markers to be used as fallbacks in case no LSP root is found
  ---@type string[]
  root_markers = {},

  --- Collection of module initialization functions
  ---@type MyInitLists
  setup_init_lists = requires_init "setup_init_lists",

  --- Set of `lazy-nvim` spec sources that have already been added at least once
  ---@type table<string, boolean>
  setup_lzplugin_has_spec = requires_init "my.config.setup_lzplugin_has_spec",

  --- Table of `lazy-nvim` plugins manifest spec "headers"
  ---@type MySetupPluginsManifest
  lzplugins_manifest = requires_init "my.config.setup_lzplugin_manifest",

  --- List of `lazy-nvim` plugins specs to be passed to it's `setup()`
  ---@type (LazyPluginSpec | fun():LazyPluginSpec)[]
  lzsetup_plugin_specs = requires_init "my.config.setup_lzsetup_plugin_specs",

  --- Table of functions making `lazy-nvim` spec's according to the plugins manifest
  ---@type MySetupPluginsManifest2
  setup_lzplugin_make_spec = requires_init "my.config.setup_lzplugin_make_spec",

  --- List of specs for `lazy-nvim`
  ---@type LazyPluginSpec[]
  setup_lzplugin_specs = requires_init "my.config.setup_lzplugin_specs",

  --- filetype specific Lazy.nvim plugin spec modifications
  ---@type LazyPluginSpec[]
  setup_lazy_specs = {},

  --- List of functions to setup filetype autocmds
  ---@type (fun())[]
  setup_filetype_autocmds = {},

  --- List of tuples for customizing and enabling `lspconfig.nvim` config's
  ---@type [fun(enable_config: boolean), boolean][]
  setup_lsp_configs = {},

  --- List of functions to setup project autocmds
  ---@type (fun())[]
  setup_project_autocmds = {},

  --- Callback to sync (write and reload) the current buf (buffer)
  ---@type table<BufId, fun()>
  sync_buf = init_clear_on_buf_wipeout_handles_list(),

  --- Autostart regex highlighting for filetype (buffer)
  ---@type table<BufId, boolean>
  syntax_autostart_regex_filetype_buf = init_clear_on_buf_wipeout_handles_list(),

  --- Autostart Treesiter highlighting for filetype (buffer)
  ---@type table<BufId, boolean>
  syntax_autostart_ts_filetype_buf = init_clear_on_buf_wipeout_handles_list(),

  --- Previous buffer syntax (see `help syntax`)
  ---@type table<BufId, string>
  syntax_prev_buf = init_clear_on_buf_wipeout_handles_list(),

  --- Use Treesiter indentation for filetype (buffer)
  ---@type table<BufId, boolean>
  syntax_use_ts_indent_filetype_buf = init_clear_on_buf_wipeout_handles_list(),

  --- List of charts to be used as labels for tab jumping
  ---@type string
  tab_labels = "",

  --- Show notifications on UI toggles (global)
  ---@type boolean
  toggle_notifications = false,

  --- Toggle a buffer fixed window when performing a CD operation (buffer)
  ---@type table<BufId, fun()>
  toggle_buf_fixed_win_func_buf = init_clear_on_buf_wipeout_handles_list(),

  --- Toggle function for a buffer fixed window (buffer)
  ---@type table<BufId, boolean>
  toggle_buf_fixed_win_on_cd_buf = init_clear_on_buf_wipeout_handles_list(),

  --- Set of nvim-treesitter parsers to always install
  ---@type table<string, boolean>
  ts_ensure_installed = {},

  --- Set of available nvim-treesitter parsers
  ---@type table<string, boolean>
  ts_available = {},

  --- Cache of workspace buffer infos (buffer)
  ---@type table<BufId, MyWsBufInfo | false>
  ws_buf_info_cache_buf = init_clear_on_buf_wipeout_handles_list(),

  --- List of workspace configurations (after priority sort)
  ---@type MyWsConfig[]?
  ws_configs = nil,

  --- List of workspace configurations (before priority sort)
  ---@type table<integer, MyWsConfig[]>
  ws_configs_by_priority = {},
}

my.config = config
