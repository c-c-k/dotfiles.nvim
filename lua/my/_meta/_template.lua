---@meta _
--# selene: allow(unused_variable)
---@diagnostic disable: unused-local
error "Cannot require a meta file"

---@class my
local my = ...

---@class my._TEMPLATE
my._TEMPLATE = ...

---@class my._TEMPLATE._submodules

--- THIS is some func
---@param a string
---@param b boolean
---@return integer
function my._TEMPLATE.somefunc(a, b) end
