---@diagnostic disable: unused-local
error "Cannot require a meta file"

---@class (exact) my.vars.g
---@field auto_cd_root boolean # Auto cd ? root on ? (not implemented)(global)
---@field codelens_enabled boolean # LSP CodeLens capability enabled (global)
---@field core_setup_autocmds (fun())[] # Filetype setup autocmds
---@field hlsearch_keep_keys string[] # List of keys for which to not auto turn off hlsearch
---@field hlsearch_auto_off_modes string[] # List of modes in which to auto turn off hlsearch
---@field filetype_setup_autocmds (fun())[] # Filetype setup autocmds
---@field icons_enabled boolean # Use glyphs for icons (requires patched Nerd Fonts)
---@field lazy_filetype_specs LazyPluginSpec[] # filetype specific Lazy.nvim plugin spec modifications
---@field lsp_enable table<string, boolean> # List of LSP clients to enable (or not)
---@field lsp_file_ops_timeout_ms integer # LSP file actions timeout in milliseconds (global)
---@field root_markers string[] # List of global default root markers to be used as fallbacks in case no LSP root is found
---@field rustaceanvim rustaceanvim.Opts|(fun():rustaceanvim.Opts) # rustacenvim plugin configuration (global)
---@field tab_labels string # List of charts to be used as labels for tab jumping
---@field toggle_notifications boolean # Show notifications on UI toggles (global)

---@class (exact) my.vars.gp

---@class (exact) my.vars.b
---@field close_buf fun() # Callback to delete a special buffer
---@field close_buf_win fun() # Callback to close a special buffer fixed window
---@field get_buf_dir_path fun():string # Function to get the directory path of a buffer (meant for special buffers like fugitive)
---@field new_file string|boolean # Buffer for which an on disk file has not been created yet
---@field syntax_prev string? # Previous buffer syntax (see `help syntax`)
---@field [integer] my.vars.b

---@class (exact) my.vars.bp
---@field cmp_enabled PV<boolean> # completion enabled
---@field codelens_enabled PV<boolean> # LSP CodeLens capability enabled
---@field format PV<boolean> # LSP format
---@field format_on_save PV<boolean> # LSP format on save
---@field format_timeout_ms PV<integer> # LSP formating timeout in milliseconds
---@field lsp_semantic_hl PV<boolean> # LSP semantic Highlighting
---@field illuminate_freeze PV<boolean> # Freeze the current Vim.illuminate highlights
---@field illuminate_pause PV<boolean> # Pause Vim.illuminate highlights
---@field illuminate_invisible PV<boolean> # Make Vim.illuminate highlights in/visible
---@field indent_guide PV<boolean> # enable indent guides
---@field syntax PV<string> # Buffer syntax (see `help syntax`)
---@field [integer] my.vars.bp

---@class (exact) my.vars.w
---@field [integer] my.vars.w

---@class (exact) my.vars.wp
---@field indent_guide PV<boolean> # enable indent guides
---@field [integer] my.vars.wp

---@class (exact) my.vars.t
---@field name? string # custom tab name (used in 'tabline' expression)
---@field [integer] my.vars.t

---@class (exact) my.vars.tp
---@field [integer] my.vars.tp
