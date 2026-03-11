---@meta _
--# selene: allow(unused_variable)
---@diagnostic disable: unused-local
error "Cannot require a meta file"

---@class (exact) SomeClass
---@field f1 integer # description f1
---@field f2 string[] # description f2

---@alias g.var_a integer # description A
---@alias g.var_b SomeClass # description B

---@class b (exact)
---@field var_c integer

---@class my.var5
local M = {}

--- TODO: description
---@generic T
---@param priority my.vars4.priority
---@param var_acc `T`
---@return T
function M.get(priority, var_acc) end

return M
