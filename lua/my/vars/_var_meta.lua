---@meta _
--# selene: allow(unused_variable)
---@diagnostic disable: unused-local
error "Cannot require a meta file"

---@alias Terr "LLS Generics :("

--- MyVar version 4: Use `MyVar:init(...)` to configure MyVar instances
-- ---@generic T
---@class (exact) POVar4<T>: my.vars4.VarImpl.public_fields, {
---delete: (fun(self: POVar4<T>, priority: my.vars4.priority, opts: my.vars4.VarImpl.delete.opts)),
---delete_handle: (fun(scope_name: my.vars4.scope_name, handle_id: integer)),
---get: (fun(self: POVar4<T>, priority: my.vars4.priority): T?),
---get_all_entries_as_dict: (fun(self: POVar4<T>): table<my.vars4.priority,Terr>),
---get_all_entries_as_list: (fun(self: POVar4<T>): [my.vars4.priority, Terr][]),
---get_top: (fun(self: POVar4<T>): T),
---get_top_entry: (fun(self: POVar4<T>): [my.vars4.priority, Terr]),
---get_var: (fun(scope_name: my.vars4.scope_name, handle_id: integer, var_name: string): POVar4<T>?),
---init: (fun(self: POVar4<T>, opts: POVar4.init.opts<T>)),
---set: (fun(self: POVar4<T>, priority: my.vars4.priority, value: T)),
---}

---@class (exact) SVar4<T>: my.vars4.VarImpl.public_fields, {
---get: (fun(self: SVar4<T>): T),
---init: (fun(self: SVar4<T>, default: T, opts: SVar4.init.opts)),
---set: (fun(self: SVar4<T>, value: T)),
---}

---@class (exact) SOVar4<T>: my.vars4.VarImpl.public_fields, {
---get: (fun(self: SOVar4<T>): T),
---init: (fun(self: SOVar4<T>, default: T, opts: SOVar4.init.opts)),
---set: (fun(self: SOVar4<T>, value: T)),
---}

---@alias my.vars4.scope_name
---| "b" # Buffer variables
---| "w" # Window variables
---| "t" # Tab page variables
---| "g" # Global variables

---@alias my.vars4._backend.scope.handle table<string, my.vars4.VarImpl>

---@class my.vars4._backend.scope
---@field current_handle_getter (fun(): integer) | false
---@field handles table<integer,my.vars4._backend.scope.handle>

---@alias my.vars4.priority my.vars4.priority_levels | integer
---@alias my.vars4.VarImpl.priority_entry [my.vars4.priority, unknown]

---@class (exact) my.vars4.VarImpl.public_fields
---@field scope_name my.vars4.scope_name
---@field handle_id integer
---@field var_name string

---@class (exact) my.vars4.VarImpl.private_fields
---@field _data table<integer, unknown> | unknown,
---@field _did_init boolean
---@field _no_fallback boolean?,
---@field _nvim_opt string?
---@field _simple boolean?

---@class (exact) my.vars4.VarImpl.delete.opts
---@field unset_ok boolean?

---@class (exact) PVar4.init.opts # Priority Var
---@field nvim_opt false?,
---@field simple false?,

---@class (exact) POVar4.init.opts # Priority Var tied to an NVIM Option
---@field nvim_opt true,
---@field simple false?,

---@class (exact) SVar4.init.opts # Simple Var
---@field no_fallback boolean?,
---@field nvim_opt false?,
---@field simple true,

---@class (exact) SOVar4.init.opts # Simple Var tied to an NVIM Option
---@field no_fallback boolean?,
---@field nvim_opt true,
---@field simple true,

---@class (exact) my.vars4.VarImpl.init.opts
---@field no_fallback boolean?,
---@field nvim_opt boolean,
---@field simple boolean,
