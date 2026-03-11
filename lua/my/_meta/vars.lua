---@meta _
--# selene: allow(unused_variable)
---@diagnostic disable: unused-local
error "Cannot require a meta file"

---@class (exact) my.vars.optional_var_spec
---@field b boolean?
---@field w boolean?
---@field t boolean?
---@field g boolean?
---@field bp boolean?
---@field wp boolean?
---@field tp boolean?
---@field gp boolean?

---@alias my.vars.scope_normal
---| "b" # Buffer variables
---| "w" # Window variables
---| "t" # Tab page variables
---| "g" # Global variables

---@alias my.vars.scope_priority
---| "bp" # Buffer Priority variables
---| "wp" # Window Priority variables
---| "tp" # Tab page Priority variables
---| "gp" # Global Priority variables

---@alias my.vars.scope
---| my.vars.scope_normal
---| my.vars.scope_priority

---@alias PV<T> my.vars.PriorityVar<T>
---@class my.vars.PriorityVar<T>: {
---scope: my.vars.scope_priority,
---use_handle: boolean,
---handle: integer,
---var_name: string,
---get: (fun(self: PV<T>, priority: integer): T),
---get_top_info: (fun(self: PV<T>): integer, T),
---get_top: (fun(self: PV<T>): T),
---get_all: (fun(self: PV<T>): {[integer]: T}),
---set: (fun(self: PV<T>, priority: integer, value: T)),
---delete: (fun(self: PV<T>, priority: integer)),
---}

---@class my.vars.apply_pvar_to_handles.opts
---@field handles integer | integer[] | (fun(): integer | integer[])
---@field p_scope my.vars.scope_priority
---@field var_name string
---@field on_func fun(handle: integer, pvar?: PV<unknown>)
---@field off_func fun(handle: integer, pvar?: PV<unknown>)
---

-- TODO: write proper metadata for the accessors and backend
---@alias my.vars.Backend table
---@alias my.vars.Accessor table

-- ---@alias my.vars.vars_dict  table<string, any>
--
-- ---@class (exact) my.vars.Accessor.Direct
-- ---@field [string] any
--
-- ---@class (exact) my.vars.Accessor.Handles
-- ---@field [integer] my.vars.vars_dict
--
-- ---@alias my.vars.Accessor
-- ---| my.vars.Accessor.Direct
-- ---| my.vars.Accessor.Handles
--
-- ---@class (exact) my.vars.Backend.Direct
-- ---@field vars my.vars.vars_dict
--
-- ---@class  my.vars.Backend.Handles
-- ---@field [integer] my.vars.vars_dict
--
-- ---@class (exact) my.vars.Backend.PriorityHandles
-- ---@field shared ...
-- ---@field handles table<integer, ...>
--
-- ---@class (exact) my.vars.Backend
-- ---@field b my.vars.Backend.Handles
-- ---@field w my.vars.Backend.Handles
-- ---@field t my.vars.Backend.Handles
-- ---@field g my.vars.Backend.Direct
