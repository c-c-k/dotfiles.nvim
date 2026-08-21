---@class MyTbl
local M = {}
M.init = { no_init = true, recurse = false } ---@type MyModuleInit

---@alias MyTblMergeFlagsSupported
---| "dDeF" # dict Deep merge, error on conflict, merge into First.
---| "dDfF" # dict Deep merge, replace on conflict, merge into First.
---| "dDkF" # dict Deep merge, keep on conflict, merge into First.
---| "dDeL" # dict Deep merge, error on conflict, merge into Last.
---| "dDfL" # dict Deep merge, replace on conflict, merge into Last.
---| "dDkL" # dict Deep merge, keep on conflict, merge into Last.
---| "lUF" # list Unique merge, merge into First.
---| "lUL" # list Unique merge, merge into Last.

local deepcopy = vim.deepcopy

--- Tests if `t` is an empty table.
---@param t table table to check
---@return boolean `true` if table is empty
local function is_empty(t)
  vim.validate("t", t, "table")
  return next(t) == nil
end
M.is_empty = is_empty

--- Tests if `t` is a "list": a table indexed only by consecutive numbers.
---
--- An empty table `{}` is considered a "list".
--- If the table has a metatable it is only considered a list
---   if the metatable has a field `__is_list_like = true`.
---@param t? table table to check.
---@return boolean `true` if table is a "list".
local function is_list(t)
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
M.is_list = is_list

--- Tests if `t` is a "pure_dict": a table with no `t[1]` key.
---
--- An empty table `{}` is considered a "pure_dict".
---@param t? table table to check.
---@return boolean `true` if table is a "pure_dict".
local function is_pure_dict(t) --
  return type(t) == "table" and (M.is_empty(t) or not t[1])
end
M.is_pure_dict = is_pure_dict

--- Tests if `t` is "dict_like": a table that is not a "list".
---
--- An empty table `{}` is considered "dict_like".
---@param t? table table to check.
---@return boolean `true` if table is "dict_like".
local function is_dict_like(t) --
  return type(t) == "table" and (M.is_empty(t) or not M.is_list(t))
end
M.is_dict_like = is_dict_like

M.keys = vim.tbl_keys

--- MEMO: No input validation is performed.
---@param copy boolean
---@param ... table
---@return table
local function merge_lists(_, _, copy, ...)
  local ret = select(1, ...) or {}
  local set = {}

  for _, v in ipairs(ret) do
    set[v] = true
  end

  for i = 2, select("#", ...) do
    local current_t = select(i, ...)
    if current_t then
      for _, v in ipairs(current_t) do
        if copy then v = deepcopy(v) end
        if not set[v] then
          set[v] = true
          ret[#ret + 1] = v
        end
      end
    end
  end

  return ret
end

--- MEMO: No input validation is performed.
---@param err_on_conflict boolean
---@param replace boolean
---@param copy boolean
---@param ... table
local function merge_dicts_recursive(err_on_conflict, replace, copy, ...)
  local ret = select(1, ...) or {}
  for i = 2, select("#", ...) do
    local current_t = select(i, ...)
    if current_t then
      for key, new_v in pairs(current_t) do
        local orig_v = ret[key]
        if orig_v == nil then
          if copy then
            ret[key] = deepcopy(new_v)
          else
            ret[key] = new_v
          end
        else
          if err_on_conflict then
            local _msg = string.format(
              "conlicting values for key `%s`:\n\t%s\n\t%s",
              tostring(key),
              vim.inspect(orig_v),
              vim.inspect(new_v)
            )
            error(_msg)
          elseif is_dict_like(orig_v) and is_dict_like(new_v) then --
            merge_dicts_recursive(err_on_conflict, replace, copy, orig_v, new_v)
          elseif replace then
            if copy then
              ret[key] = deepcopy(new_v)
            else
              ret[key] = new_v
            end
          end
        end
      end
    end
  end
  return ret
end

--- A flag controlled Swiss knife merge.
---
--- This function merges two or more tables according to the `flags` parameter
--- (see the description of each available flag for what it does).
---
--- For convenience the merged table is also returned.
---
--- **IMPORTANT**:
---  * Arguments will be merged in place into the target table
---    (pass an empty table as the merge target to avoid this).
---  * Arguments must be "lists" or "dict_likes" according to the flags.
---  * Arguments can also be `nil` in which case they will be ignored,
---    in case the target table is `nil` a new table will be created.
---  * "Lists" are treated as literals and are replaced during a "dict_like" merge.
---
---@generic T table
---@param flags MyTblMergeFlagsSupported
---@param ... T
---@return T
function M.merge(flags, ...)
  -- NOTE: the `copy` placeholder is added in case it will become necessary,
  --      looking at NVIM's and snacks.nvim implementations of merge functions
  --      it seems (deep) copying tables is generally not required.
  local copy
  local err_on_conflict
  local list_unique_merge
  local replace
  local switch_first_last

  if flags == "dDeF" then
    err_on_conflict = true
  elseif flags == "dDfF" then
    replace = true
    -- selene: allow(empty_if)
  elseif flags == "dDkF" then
    -- Default option (default as result of `nil` value falsiness)
  elseif flags == "dDeL" then
    err_on_conflict = true
    switch_first_last = true
  elseif flags == "dDfL" then
    replace = true
    switch_first_last = true
  elseif flags == "dDkL" then
    switch_first_last = true
  elseif flags == "lUF" then
    list_unique_merge = true
  elseif flags == "lUL" then
    list_unique_merge = true
    switch_first_last = true
  else
    error("invalid/unsupported merge flags: " .. vim.inspect(flags))
  end

  local validate_func, validate_type, merge_func
  if list_unique_merge then
    validate_func, validate_type, merge_func = is_list, [["list"]], merge_lists
  else
    validate_func, validate_type, merge_func = is_dict_like, [["dict_like"]], merge_dicts_recursive
  end
  for i = 1, select("#", ...) do
    local t = select(i, ...)
    vim.validate("argument " .. tostring(i), t, validate_func, true, validate_type)
    -- vim.validate("argument " .. tostring(i), t, "table")
  end

  if switch_first_last then
    local num_args = select("#", ...)

    if num_args == 2 then
      local a, b = ...
      return merge_func(err_on_conflict, replace, copy, b, a)
    elseif num_args == 3 then
      local a, b, c = ...
      return merge_func(err_on_conflict, replace, copy, c, a, b)
    elseif num_args == 4 then
      local a, b, c, d = ...
      return merge_func(err_on_conflict, replace, copy, d, a, b, c)
    else
      local args = { ... }
      return merge_func(err_on_conflict, replace, copy, select(num_args, ...), unpack(args, 1, num_args - 1))
    end
  end

  return merge_func(err_on_conflict, replace, copy, ...)
end

---@class MySet<T>: table<T, boolean>

--- Convert a set to a list.
---@generic T
---@param list T[]
---@return table<T, boolean>
function M.set_from_list(list)
  local set = {}
  for _, key in ipairs(list) do
    set[key] = true
  end
  return set
end

--- Convert a set to a list.
---@generic T
---@param set table<T, boolean>
---@return T[]
function M.set_to_list(set)
  local list = {}
  for key, value in pairs(set) do
    if value then list[#list + 1] = key end
  end
  return list
end

---@class MySimpleSetString
---@field add fun(items: string|string[])
---@field as_list fun(): string[]
---@field raw_set table<string, boolean>
---@field remove fun(items: string|string[])

--- Create a very simple set that can add/remove items and
--- return a list of items in the set.
---
--- Because of the limitations of LuaLS in regards to generics,
--- the type of the set needs to be explicitly  provide with
--- `---@type MySimpleSet...` .
---@param initial_items any
---@return table
function M.create_simple_set(initial_items)
  local set = {}

  local function add(new)
    if type(new) == "table" then
      for _, v in ipairs(new) do
        set[v] = true
      end
      return
    elseif new ~= nil then
      set[new] = true
    end
  end

  local function remove(rem)
    if type(rem) == "table" then
      for _, v in ipairs(rem) do
        set[v] = nil
      end
      return
    elseif rem ~= nil then
      set[rem] = nil
    end
  end

  local function as_list()
    local list = {}
    for k, v in pairs(set) do
      if v then list[#list + 1] = k end
    end
    return list
  end

  add(initial_items)

  return { raw_set = set, add = add, remove = remove, as_list = as_list }
end

M.values = vim.tbl_values

return M
