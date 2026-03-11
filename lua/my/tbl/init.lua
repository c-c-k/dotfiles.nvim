---@class my.tbl
local M = {}

--- Tests if `t` is an empty table.
---@param t table table to check
---@return boolean `true` if table is empty
function M.is_empty(t)
  vim.validate("t", t, "table")
  return next(t) == nil
end

--- Tests if `t` is a "list": a table indexed only by consecutive numbers.
---
--- An empty table `{}` is considered a "list".
--- If the table has a metatable it is only considered a list
---   if the metatable has a field `__is_list_like = true`.
---@param t? table table to check.
---@return boolean `true` if table is a "list".
function M.is_list(t)
  if type(t) ~= "table" then return false end
  local mt = getmetatable(t)
  if mt ~= nil and not mt.__is_list_like then return false end
  if M.is_empty(t) then return true end

  local c, l = 1, #t
  for _ in pairs(t) do
    if c > l then return false end
    c = c + 1
  end
  return true
end

--- Tests if `t` is a "pure_dict": a table with no `t[1]` key.
---
--- An empty table `{}` is considered a "pure_dict".
---@param t? table table to check.
---@return boolean `true` if table is a "pure_dict".
function M.is_pure_dict(t) --
  return type(t) == "table" and (M.is_empty(t) or not t[1])
end

--- Tests if `t` is "dict_like": a table that is not a "list".
---
--- An empty table `{}` is considered "dict_like".
---@param t? table table to check.
---@return boolean `true` if table is "dict_like".
function M.is_dict_like(t) --
  return type(t) == "table" and (M.is_empty(t) or not M.is_list(t))
end
---@generic T table
---@param use_first boolean
---@param ... T
---@return T
local function merge_lists(use_first, ...)
  local ret_index = use_first and 1 or select("#", ...)
  local ret = select(ret_index, ...)
  local start_index = use_first and 2 or 1
  local end_index = select("#", ...) - (use_first and 0 or 1)
  local set = {}
  vim.validate("argument " .. tostring(ret_index), ret, M.is_list, true, [["list"]])
  if not ret then ret = {} end

  for _, v in ipairs(ret) do
    set[v] = true
  end

  for i = start_index, end_index do
    local t = select(i, ...)
    vim.validate("argument " .. tostring(i), t, M.is_list, true, [["list"]])
    if t then
      for _, v in ipairs(t) do
        if not set[v] then
          set[v] = true
          ret[#ret + 1] = v
        end
      end
    end
  end

  return ret
end

--- Merge unique items from several option "lists".
---
--- **IMPORTANT**:
---   * Items will be merged in place into the ***FIRST*** "list"
---     (pass an empty "list" as first argument to avoid this).
---   * If first argument is `nil` it a new "list" will be used instead.
---   * `nil` arguments except for first one will be skipped.
---   * Non "list"/`nil` arguments will cause an error.
---
---@generic T table
---@param ... T "Lists" to merge.
---@return T # The first "list" with all the merged items.
function M.merge_lists_into_first(...) return merge_lists(true, ...) end

--- Merge unique items from several option "lists".
---
--- **IMPORTANT**:
---   * Items will be merged in place into the ***LAST*** "list"
---     (pass an empty "list" as last argument to avoid this).
---   * If last argument is `nil` it a new "list" will be used instead.
---   * `nil` arguments except for last one will be skipped.
---   * Non "list"/`nil` arguments will cause an error.
---
---@generic T table
---@param ... T "Lists" to merge.
---@return T # The last "list" with all the merged items.
function M.merge_lists_into_last(...) return merge_lists(false, ...) end

--- Merge in place "dict_like" `src` into `trg`.
---
--- IMPORTANT:
---  * No input validation is performed.
---  * "dict_like" values are deep copied.
---  * "Lists" are treated as literals and are not merged.
---  * If `replace` is true `src` values take priority (like `vim.tbl_deep_extend` with "force").
---  * Else (if `replace` is false) `trg` values take priority (like `vim.tbl_deep_extend` with "keep").
---@param trg table
---@param src table
---@param replace boolean
local function merge_2_opts_dicts_recursive(trg, src, replace)
  for k, src_v in pairs(src) do
    if M.is_dict_like(trg[k]) and M.is_dict_like(src_v) then --
      merge_2_opts_dicts_recursive(trg[k], src_v, replace)
    elseif replace or trg[k] == nil then
      trg[k] = vim.deepcopy(src_v)
      -- if M.is_dict_like(src_v) then --
      --   trg[k] = {}
      --   merge_2_opts_dicts_recursive(trg[k], src_v, keep)
      -- else
      --   trg[k] = src_v
      -- end
      -- else keep value of `trg[k]`.
    end
  end
end

---@generic T table
---@param use_first boolean
---@param ... T
---@return T
local function merge_dicts(use_first, ...)
  local replace = use_first
  local ret_index = use_first and 1 or select("#", ...)
  local ret = select(ret_index, ...)
  local start_index = use_first and 2 or 1
  local end_index = select("#", ...) - (use_first and 0 or 1)
  vim.validate("argument " .. tostring(ret_index), ret, M.is_dict_like, true, [["dict_like"]])
  if not ret then ret = {} end

  for i = start_index, end_index do
    local t = select(i, ...)
    vim.validate("argument " .. tostring(i), t, M.is_dict_like, true, [["dict_like"]])
    if t then merge_2_opts_dicts_recursive(ret, t, replace) end
  end

  return ret
end

--- Deep merge several option "dict_likes".
---
--- **IMPORTANT**:
---   * Items will be merged in place into the ***FIRST*** "dict_like"
---     (pass an empty "dict_like" as first argument to avoid this).
---   * Items in the ***FIRST*** "dict_like" will be replaced (like `vim.tbl_deep_extend` with "force")
---   * First/single argument can't be `nil`.
---   * If first argument is `nil` it a new "dict_like" will be used instead.
---   * `nil` arguments except for first one will be skipped.
---   * Non "dict_like"/`nil` arguments will cause an error.
---  * "Lists" are treated as literals and are replaced not merged.
---
---@generic T: any
---@vararg T "dict_likes" to merge.
---@return T # The first "dict_like" with all the merged items.
function M.merge_dicts_into_first(...) return merge_dicts(true, ...) end

--- Deep merge several option "dict_likes".
---
--- **IMPORTANT**:
---   * Items will be merged in place into the ***LAST*** "dict_like"
---     (pass an empty "dict_like" as last argument to avoid this).
---   * Items in the ***LAST*** "dict_like" will be kept (like `vim.tbl_deep_extend` with "keep")
---   * If last argument is `nil` it a new "dict_like" will be used instead.
---   * `nil` arguments except for last one will be skipped.
---   * Non "dict_like"/`nil` arguments will cause an error.
---  * "Lists" are treated as literals and are replaced not merged.
---
---@generic T table
---@param ... T "dict_likes" to merge.
---@return T # The last "dict_like" with all the merged items.
function M.merge_dicts_into_last(...) return merge_dicts(false, ...) end

--- Create a module that will recursively lazy load it's submodules as fields.
---@param module_name string
---@param module table
---@return table
function M._lazy_loading_module(module_name, module)
  vim.validate("module(" .. module_name .. ")", module, "table", false)
  module_name = module_name:gsub("%.*$", "") -- strip trailing periods
  local excludes ---@type table<string, boolean>?
  return setmetatable(module, {
    __index = function(module_table, key)
      if key == "_excludes" then return excludes and vim.tbl_keys(excludes) or {} end
      local submodule_name = string.format("%s.%s", module_name, key)
      if key:sub(1, 1) == "_" or (excludes and excludes[key]) then
        local msg = string.format('Submodule "%s" forbidden for loading.', submodule_name)
        return error(msg, 2)
      end
      local success, result = pcall(require, submodule_name)
      if success then
        local submodule = result
        rawset(module_table, submodule_name, M._lazy_loading_module(submodule_name, submodule))
        return module_table[submodule_name]
      end
      local err = result
      local msg = string.format('error loading submodule "%s": %s', submodule_name, err)
      return error(msg, 2)
    end,
    __newindex = function(module_table, key, value)
      if key == "_excludes" then
        excludes = {}
        for _, exclude in ipairs(value) do
          excludes[exclude] = true
        end
      else
        rawset(module_table, key, value)
      end
    end,
  })
end

return M
