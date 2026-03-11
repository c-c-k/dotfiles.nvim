---@meta _
error "Cannot require a meta file"

---@alias my.keymap.modes
---| "" # Normal, Visual, Select, Operator-pending modes
---| "n" # Normal mode
---| "!" # Insert, Command-line modes
---| "i" # Insert mode
---| "c" # Command-line mode
---| "v" # Visual, Select modes
---| "x" # Visual mode
---| "s" # Select mode
---| "o" # Operator-pending mode
---| "t" # Terminal mode
---| "l" # Lang-Arg mode

---@alias my.keymap.mode_slugs
---| "n___" # Normal mode
---| "i___" # Insert mode
---| "c___" # Command-line mode
---| "x___" # Visual mode
---| "s___" # Select mode
---| "o___" # Operator-pending mode
---| "t___" # Terminal mode
---| "l___" # Lang-Arg mode
---| "nx__" # Normal, Visual modes
---| "nxo_" # Normal, Visual, Operator-pending modes
---| "nv__" # Normal, Visual, Select modes
---| "____" # Normal, Visual, Select, Operator-pending modes
---| "v___" # Visual, Select modes
---| "xo__" # Visual, Operator-pending modes
---| "!___" # Insert, Command-line modes
---| "it__" # Insert, Terminal modes
---| "il__" # Insert, Lang-Arg modes
---| "!t__" # Insert, Command-line, Terminal modes
---| "!l__" # Insert, Command-line, Lang-Arg modes
---| "!tl_" # Insert, Command-line, Terminal, Lang-Arg modes
---| "itl_" # Insert, Terminal, Lang-Arg modes
---| "all_" # All modes

---@alias my.keymap.modes_lhs
---| my.keymap.mode_slugs
---| string # hack to accept the lhs part

---@class (exact) my.keymap.keymap_spec
---@field rhs? string|(fun(): string?)
---@field nowait? boolean
---@field silent? boolean
---@field script? boolean
---@field expr? boolean
---@field unique? boolean
---@field desc? string
---@field wk_group? string
---@field wk_proxy? my.keymap.keymap_copy_spec
---@field wk_toggle? my.keymap.toggle_spec
---@field buffer? integer|boolean
---@field replace_keycodes? boolean
---@field remap? boolean
---@field noremap? boolean
---@field cond? (fun(bufnr?: integer, args?: my.keymap.keymap_spec.cond_callback_args): boolean)

---@class (exact) my.keymap.keymap_spec_full: my.keymap.keymap_spec
---@field mode string | string[]
---@field lhs string

---@class (exact) my.keymap.toggle_spec
---@field type my.keymap.toggle_spec.type
---@field id? string
---@field name? string
---@field get? fun(): boolean
---@field set? fun(enable: boolean)
---@field on_func? fun()
---@field off_func? fun()
---@field on? any
---@field off? any
---@field global? boolean

---@alias my.keymap.toggle_spec.type
---| "basic" # delegates directly to `snacks.toggle.new`
---| "option" # delegates to `snacks.toggle.option`

---@alias my.keymap.keymap_spec.cond_callback_args
---| my.lsp.lsp_attach_args

---@alias my.keymap.keymap_copy_item {km_group: my.keymap.keymaps_loader_group, km_id: my.keymap.modes_lhs}
---@alias my.keymap.keymap_copy_spec my.keymap.keymap_copy_item| my.keymap.keymap_copy_item[]

---@class my.keymap.loader_ctx
---@field buffer? integer|boolean
---@field args? my.lsp.lsp_attach_args

---@class (exact) my.keymap.keymaps_loader_group
---@field defaults? my.keymap.keymap_spec|my.keymap.keymap_spec[]
---@field [my.keymap.modes_lhs] my.keymap.keymap_spec
-- ---@alias my.keymap.keymaps_loader_keys  "defaults"|my.keymap.modes_lhs
-- ---@alias my.keymap.keymaps_loader_group
-- ---| {["defaults"]: my.keymap.keymap_spec|my.keymap.keymap_spec[]}
-- ---| table<my.keymap.modes_lhs, my.keymap.keymap_spec>
-- ---| my.keymap.keymaps_loader_keys # hack to get autocompletion for keys

-- ---@alias my.keymap.keymaps_module table<string, my.keymap.keymaps_loader_group>
-- ---@class my.keymap.keymaps_table
-- ---@field [`string`] my.keymap.keymap_spec
