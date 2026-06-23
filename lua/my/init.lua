--- Create a module that will recursively lazy load it's submodules as fields.
---@param module_name string
---@param module table
---@return table
local function _lazy_loading_module(module_name, module)
  vim.validate("module(" .. module_name .. ")", module, "table", false)

  module_name = module_name:gsub("%.+$", "") -- strip trailing periods

  local lazy_loader__index = function(module_table, key)
    local submodule_name = string.format("%s.%s", module_name, key)

    local ok, result = pcall(require, submodule_name)
    if not ok then
      local err = result
      local msg = string.format('error loading submodule "%s": %s', submodule_name, err)
      error(msg, 2)
    end

    local submodule = result
    if type(submodule) == "table" then
      local metatable = getmetatable(submodule)
      if metatable == nil or metatable.__apply_lazy_module_loader then
        submodule = _lazy_loading_module(submodule_name, submodule)
      end
    end

    rawset(module_table, key, submodule)
    return submodule
  end

  local lazy_load_metatable = getmetatable(module) or {}
  lazy_load_metatable.__index = lazy_loader__index
  return setmetatable(module, lazy_load_metatable)
end

---@class my: my._submodules
local M = _lazy_loading_module("my", {})

return M
