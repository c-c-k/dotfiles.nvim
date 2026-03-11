---@class my.vars4.VarImpl: my.vars4.VarImpl.private_fields, my.vars4.VarImpl.public_fields
local M = {}

local my = require "my"
local _backend = require "my.vars._backend"
local _priority_level = require "my.vars._var_priorities"

local PRIORITY_DEFAULT = _priority_level.GLOBAL_DEFAULT
-- local PRIORITY_SIMPLE = _priority_level.SIMPLE
local PRIORITY_SIMPLE = nil

function M:__index(key)
  if M[key] then return M[key] end
  local msg = "Invalid MyVar index."
  my.notify.trace({ msg, key, self }, { title = "Invalid MyVar access" })
end

function M:__new_index(key, value)
  local msg = "Direct assignment to MyVar not supported."
  my.notify.trace({ msg, key, value, self }, { title = "Invalid MyVar access" })
end

--- Delete priority from MyVar.
---@param priority my.vars4.priority
---@param opts my.vars4.VarImpl.delete.opts
function M:delete(priority, opts)
  if self:no_init() then return end
  if self._data[priority] == nil and not opts.unset_ok then
    local msg = "Attempted to delete unset priority."
    my.notify.trace({ msg, self, priority, opts }, { title = "Invalid MyVar access" })
    return
  end
  self._data[priority] = nil
  if self._nvim_opt then self:_update_nvim_opt() end
  self:trigger_my_var_modified()
end

--- Delete buf/win/tab handle from backend.
---@param scope_name my.vars4.scope_name
---@param handle_id integer
function M.delete_handle(scope_name, handle_id) --
  _backend[scope_name].handles[handle_id] = nil
end

--- Get a specific MyVar priority value.
---@param priority my.vars4.priority?
---@return unknown
function M:get(priority)
  if self:no_init() then return nil end

  if priority == nil and not self._simple then
    local msg = "Missing priority, use `get_top` to get top priority value."
    my.notify.trace({ msg, self, priority }, { title = "Invalid MyVar access" })
    return nil
  elseif priority ~= nil and self._simple then
    local msg = "Attempted to get a priority value on a simple var."
    my.notify.trace({ msg, self, priority }, { title = "Invalid MyVar access" })
    return nil
  elseif priority == nil and self._simple then
    return self:get_simple()
  end

  -- TODO: Delete
  -- local global_fallback = self.scope_name ~= "g" and M.get_var("g", 0, self.var_name)
  -- local tab_fallback = self.scope_name == "w"
  --   and M.get_var("t", vim.api.nvim_win_get_tabpage(self.handle_id), self.var_name)
  -- local data_sources = { self, tab_fallback, global_fallback }
  local value
  -- TODO: Delete
  -- for _, data_source in ipairs(data_sources) do
  for _, data_source in ipairs { self:_get_data_sources() } do
    if data_source and data_source[priority] ~= nil then
      value = data_source[priority]
      break
    end
  end

  vim.schedule(function() self:trigger_my_var_accessed() end)
  return value
end

--- Get all relevant data sources (own, tab, global).
---
--- If reverse is `true` the data sources are (global, tab, own).
---@param reverse boolean?
---@return table?, table?, table?
function M:_get_data_sources(reverse)
  local global = self.scope_name ~= "g" and M.get_var("g", 0, self.var_name)
  local tab = self.scope_name == "w" and M.get_var("t", vim.api.nvim_win_get_tabpage(self.handle_id), self.var_name)
  if reverse then return global and global._data or nil, tab and tab._data or nil, self._data end
  return self._data, tab and tab._data or nil, global and global._data or nil
end

--- Get priority levels and values for all defined scopes.
---@return my.vars4.VarImpl.priority_entry[]
function M:get_all_entries()
  if self:no_init() then return {} end
  -- TODO: Delete
  -- local global_fallback = self.scope_name ~= "g" and M.get_var("g", 0, self.var_name)
  -- local tab_fallback = self.scope_name == "w"
  --   and M.get_var("t", vim.api.nvim_win_get_tabpage(self.handle_id), self.var_name)
  -- local entries = my.tbl.merge_dicts_into_first(
  --   {},
  --   self._data,
  --   tab_fallback and tab_fallback._data or nil,
  --   global_fallback and global_fallback._data or nil
  -- )
  local entries = my.tbl.merge_dicts_into_first({}, self:_get_data_sources())
  -- table.sort(entries, function(a, b) return a[1] > b[1] end)
  vim.schedule(function() self:trigger_my_var_accessed() end)
  return entries
end

--- Get value of simple MyVar.
---@return unknown
function M:get_simple()
  if self:no_init() then return nil end
  -- local value
  -- for _, data_source in ipairs { self:_get_data_sources() } do
  --   if data_source ~= nil or self._no_fallback then
  --     value = data_source
  --     break
  --   end
  -- end
  vim.schedule(function() self:trigger_my_var_accessed() end)
  -- return value
  -- NOTE: Simple vars should not have a fallback,
  --        if they have a fallback they should not be simple.
  return self._data
end

--- Get the value of the top priority for MyVar.
---@return unknown
function M:get_top() --
  if self:no_init() then return nil end
  return select(2, self:get_top_entry())
end

--- Get top priority and value for MyVar.
---@return integer, unknown
function M:get_top_entry()
  if self:no_init() then return 0, nil end
  local global_fallback = self.scope_name ~= "g" and _backend.g.handles[0][self.var_name]._data
  local tab_fallback = self.scope_name == "w" and self._tab_fallback._data
  local data_sources = { self._data, tab_fallback, global_fallback }
  local max_priority = 0
  local max_value
  for _, data_source in ipairs(data_sources) do
    if data_source then
      for priority, value in pairs(data_source) do
        if priority >= max_priority then
          max_priority = priority
          max_value = value
        end
      end
    end
  end
  vim.schedule(function() self:trigger_my_var_accessed() end)
  return max_priority, max_value
end

--- Get MyVar.
---@param scope_name my.vars4.scope_name
---@param handle_id integer
---@param var_name string
---@return my.vars4.VarImpl?
function M.get_var(scope_name, handle_id, var_name)
  local scope = _backend[scope_name]
  if not scope then
    local msg = "Invalid MyVar scope."
    my.notify.trace({ msg, scope_name, handle_id, var_name }, { title = "Invalid MyVar access" })
    return
  end
  if handle_id == 0 and scope.current_handle_getter then handle_id = scope.current_handle_getter() end
  return scope[handle_id] and scope[handle_id][var_name] or M._new(scope_name, handle_id, var_name)
end

--- Get MyVar or it's value if simple MyVar.
---@param scope_name my.vars4.scope_name
---@param handle_id integer
---@param var_name string
---@return my.vars4.VarImpl | unknown?
function M.get_var_or_simple(scope_name, handle_id, var_name)
  local var = M.get_var(scope_name, handle_id, var_name)
  if var == nil then return nil end
  if var:no_init() then return nil end
  if var._simple then
    return var:get(_priority_level.SIMPLE)
  else
    return var
  end
end

--- Setup the MyVar instance.
---@param default unknown
---@param opts my.vars4.VarImpl.init.opts
function M:init(default, opts)
  local init_err = function(msg) --
    return my.notify.trace({ msg, opts, self }, { title = "Invalid MyVar Initialization" })
  end

  if self._did_init then return init_err "MyVar reinitialization not supported." end
  self._did_init = true

  if self.scope_name ~= "g" then return init_err "Initialization only supported for global scope." end
  if opts.no_fallback and not opts.simple then return init_err "`no_fallback` only supported for simple vars." end

  opts = opts or {}
  self._data = not opts.simple and {} or nil
  self._no_fallback = opts.no_fallback
  self._nvim_opt = opts.nvim_opt == true and self.var_name or opts.nvim_opt
  self._simple = opts.simple

  local value = default
  local priority = self._simple and PRIORITY_SIMPLE or PRIORITY_DEFAULT

  self:set(priority, value)
end

--- Create new MyVar.
---@param scope_name my.vars4.scope_name
---@param handle_id integer
---@param var_name string
---@return my.vars4.VarImpl?
function M._new(scope_name, handle_id, var_name)
  ---@type my.vars4.VarImpl
  local new = {
    scope_name = scope_name,
    handle_id = handle_id,
    var_name = var_name,
  }
  if scope_name == "g" then
    new._did_init = false
  else
    ---@type my.vars4.VarImpl
    local glob_var = _backend.g[0][var_name] or { _did_init = false }
    if glob_var:no_init() then return nil end

    new._data = not glob_var._simple and {} or nil
    new._did_init = true
    new._no_fallback = glob_var._no_fallback
    new._nvim_opt = glob_var._nvim_opt
    new._simple = glob_var._simple
  end
  new = setmetatable(new, M)

  local scope = _backend[scope_name]
  local handle = scope.handles[handle_id]
  if not handle then
    handle = {}
    scope.handles[handle_id] = handle
  end
  handle[var_name] = new
  return new
end

function M:no_init()
  if self._did_init then return false end
  local msg = "Global MyVar must be initialized before use."
  my.notify.trace({ msg, self }, { title = "Invalid MyVar access" })
  return true
end

--- Set MyVar value for a priority.
---@param priority integer?
---@param value unknown
function M:set(priority, value)
  if self:no_init() then return end
  if self._simple then
    if value ~= nil then
      local msg = "Attempted to set priority for a simple MyVar."
      my.notify.trace({ msg, self, priority, value }, { title = "Invalid MyVar access" })
      return
    end
    value = priority
    priority = _priority_level.SIMPLE
  end
  if value == nil then
    local msg = "Attempted to set MyVar value to `nil` (use `MyVar:delete()` instead.)"
    my.notify.trace({ msg, self, priority, value }, { title = "Invalid MyVar access" })
    return
  else
    self._data[priority] = value
  end
  if self._nvim_opt then self:_update_nvim_opt() end
  self:trigger_my_var_modified()
end

function M:set_simple(value)
  if self:no_init() then return nil end
  if self._simple then
    self:set(_priority_level.SIMPLE, value)
  else
    local msg = "Attempted to use `set_simple` for non simple var."
    my.notify.trace({ msg, value, self }, { title = "Invalid MyVar access" })
  end
end

function M:trigger_my_var_accessed()
  vim.api.nvim_exec_autocmds("User", {
    pattern = ("MyVarAccessed_%s_%s"):format(self.scope_name, self.var_name),
    modeline = false,
    data = { var = self },
  })
end

function M:trigger_my_var_modified()
  vim.api.nvim_exec_autocmds("User", {
    -- pattern = ("%s_%s"):format(self.scope_name, self.var_name),
    pattern = ("MyVarModified_%s_%s"):format(self.scope_name, self.var_name),
    modeline = false,
    data = { var = self },
  })
end

function M:_update_nvim_opt()
  local scope_name = self.scope_name
  local scope = _backend[scope_name]
  local o_scope, win, buf
  if scope_name == "o" then
    o_scope = "global"
  elseif scope_name == "bo" then
    o_scope = "local"
    buf = self.handle_id
  elseif scope_name == "wo" then
    o_scope = "local"
    win = self.handle_id
  else
    local msg = "Attempted to use `_update_option` for non option var."
    my.notify.trace({ msg, self }, { title = "Invalid MyVar access" })
    return
  end
  local var_value = self:get_top()
  local option_value = vim.api.nvim_get_option_value(scope.option, { scope = o_scope, win = win, buf = buf })
  if var_value ~= option_value then
    vim.api.nvim_set_option_value(scope.option, var_value, { scope = o_scope, win = win, buf = buf })
  end
end

function M:_update_nvim_var()
  local scope_name = self.scope_name
  local scope = _backend[scope_name]
  local getter, setter, deletter
  local args = { self.handle_id, scope.vim_var }
  if scope_name == "gp" then
    args = { scope.vim_var }
    getter = vim.api.nvim_get_var
    setter = vim.api.nvim_set_var
    deletter = vim.api.nvim_del_var
  elseif scope_name == "bp" then
    getter = vim.api.nvim_buf_get_var
    setter = vim.api.nvim_buf_set_var
    deletter = vim.api.nvim_buf_del_var
  elseif scope_name == "wp" then
    getter = vim.api.nvim_win_get_var
    setter = vim.api.nvim_win_set_var
    deletter = vim.api.nvim_win_del_var
  elseif scope_name == "tp" then
    getter = vim.api.nvim_tabpage_get_var
    setter = vim.api.nvim_tabpage_set_var
    deletter = vim.api.nvim_tabpage_del_var
  else
    local msg = "Attempted to use `_update_vim_var` for non vim var."
    my.notify.trace({ msg, self }, { title = "Invalid MyVar access" })
    return
  end
  local var_value = self:get_top()
  local var_exists, vim_var_value = pcall(getter, unpack(args))
  if not var_exists then vim_var_value = nil end
  if var_value ~= vim_var_value then
    if var_value == nil then
      deletter(unpack(args))
    else
      table.insert(args, var_value)
      setter(unpack(args))
    end
  end
end

return M
