---@meta _
error "Cannot require a meta file"

---@alias MyKeymapModes
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

---@alias MyKeymapModeSlugs
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

---@alias MyKeymapModesLhs
---| MyKeymapModeSlugs
---| string # hack to accept the lhs part

---@class (exact) MyKeymapKeymapSpec
---@field rhs? string|(fun(): string?)
---@field nowait? boolean
---@field silent? boolean
---@field script? boolean
---@field expr? boolean
---@field unique? boolean
---@field desc? string
---@field wk_group? string
---@field wk_proxy? MyKeymapKeymapCopySpec
---@field wk_toggle? MyKeymapToggleSpec
---@field buffer? BufId|boolean
---@field replace_keycodes? boolean
---@field remap? boolean
---@field noremap? boolean
---@field cond? (fun(buf_id?: integer, ev?: MyKeymapCondCallbackEvent): boolean)

---@class (exact) MyKeymapKeymapSpecFull: MyKeymapKeymapSpec
---@field mode string | string[]
---@field lhs string

---@class (exact) MyKeymapToggleSpec
---@field type MyKeymapToggleSpecType
---@field id? string
---@field name? string
---@field get? fun(): boolean
---@field set? fun(enable: boolean)
---@field on_func? fun()
---@field off_func? fun()
---@field on? any
---@field off? any
---@field vim_option? string
---@field global? boolean

---@alias MyKeymapToggleSpecType
---| "basic" # delegates directly to `snacks.toggle.new`
---| "option" # delegates to `snacks.toggle.option`

---@alias MyKeymapCondCallbackEvent
---| vim.api.keyset.create_autocmd.callback_args

---@alias MyKeymapKeymapCopyItem {km_group: MyKeymapKeymapsLoaderGroup, km_id: MyKeymapModesLhs}
---@alias MyKeymapKeymapCopySpec MyKeymapKeymapCopyItem| MyKeymapKeymapCopyItem[]

---@class MyKeymapLoaderCtx
---@field buffer? BufId|boolean
---@field ev? MyKeymapCondCallbackEvent

---@class (exact) MyKeymapKeymapsLoaderGroup
---@field defaults? MyKeymapKeymapSpec|MyKeymapKeymapSpec[]
---@field [MyKeymapModesLhs] MyKeymapKeymapSpec
-- ---@alias MyKeymapKeymapsLoaderKeys  "defaults"|MyKeymapModesLhs
-- ---@alias MyKeymapKeymapsLoaderGroup
-- ---| {["defaults"]: MyKeymapKeymapSpec|MyKeymapKeymapSpec[]}
-- ---| table<MyKeymapModesLhs, MyKeymapKeymapSpec>
-- ---| MyKeymapKeymapsLoaderKeys # hack to get autocompletion for keys

-- ---@alias MyKeymapKeymapsModule table<string, MyKeymapKeymapsLoaderGroup>
-- ---@class MyKeymapKeymapsTable
-- ---@field [`string`] MyKeymapKeymapSpec
