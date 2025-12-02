local M = {}

---@class my.tbl.keyset.merge_opts
---@field dict boolean
---@field deep boolean
---@field error boolean
---@field force boolean
---@field keep boolean
---@field list boolean
---@field unique boolean
---@field new boolean
---@field none boolean

local MERGE_FLAGS_TO_OPTS = {
  d = "dict",
  D = "deep",
  E = "error",
  F = "force",
  K = "keep",
  l = "list",
  u = "unique",
  n = "new",
}

--- Merge several tables according to flags.
---
--- Discards non-table arguments.
--- Flags:
---   - "dD": dict Deep, deep merge several dict-likes,
---     delegates to `vim.tbl_deep_extend`,
---     "EFK" flags translate into "error"/"force"/"keep" for `vim.tbl_deep_extend`.
---   - "lu": list unique, merge unique items from several lists,
---     no list validation is performed, non-list tables will cause an error.
---   - "n": new table,
---     return an empty table in case no table arguments were present,
---     without this flag `nil` will be returned.
---@param flags "dDEFKlun"|string
---@param ... table?
function M.merge(flags, ...)
  ---@type my.tbl.keyset.merge_opts
  local opts = vim.iter(flags:gmatch "."):fold({}, function(o, f)
    if not MERGE_FLAGS_TO_OPTS[f] then
      local _msg = ('Illegal flag : "%s"'):format(f)
      error(_msg, 2)
    end
    o[MERGE_FLAGS_TO_OPTS[f]] = true
    return o
  end)
  local args = vim.iter({ ... }):filter(function(v) return type(v) == "table" end):totable()

  if #args == 0 then return opts.new and {} or nil end
  if #args == 1 then return args[1] end

  if opts.dict and opts.list then
    local _msg = 'Mix of "d" and "l" flags currently not supported'
    error(_msg, 2)
  elseif opts.dict and opts.deep then
    local mode = opts.error and "error" or opts.force and "force" or opts.keep and "keep"
    if not mode then
      local _msg = 'One of the "EFK" flags must be present for "dD"'
      error(_msg, 2)
    end
    return vim.tbl_deep_extend(mode, unpack(args))
  elseif opts.list and opts.unique then
    local set = {}
    local filter_unique = function(v)
      if set[v] then
        return false
      else
        set[v] = true
        return true
      end
    end
    return vim.iter(args):flatten(1):filter(filter_unique):totable()
  else
    local _msg = 'One of the "dD" or "lu" flags must be present'
    error(_msg, 2)
  end
end

-- --- Tests if `t` is an empty table.
-- ---@param t table table to check
-- ---@return boolean `true` if table is empty
-- function M.is_empty(t)
--   vim.validate("t", t, "table")
--   return next(t) == nil
-- end

-- --- Tests if `t` is a "list": a table indexed only by consecutive numbers.
-- ---
-- --- An empty table `{}` is considered a "list".
-- --- If the table has a metatable it is only considered a list
-- ---   if the metatable has a field `__is_list_like = true`.
-- ---@param t? table table to check.
-- ---@return boolean `true` if table is a "list".
-- function M.is_list(t)
--   if type(t) ~= "table" then return false end
--   local mt = getmetatable(t)
--   if mt ~= nil and not mt.__is_list_like then return false end
--   if M.is_empty(t) then return true end
--
--   local c, l = 1, #t
--   for _ in pairs(t) do
--     if c > l then return false end
--     c = c + 1
--   end
--   return true
-- end

-- --- Tests if `t` is a "pure_dict": a table with no `t[1]` key.
-- ---
-- --- An empty table `{}` is considered a "pure_dict".
-- ---@param t? table table to check.
-- ---@return boolean `true` if table is a "pure_dict".
-- function M.is_pure_dict(t) --
--   return type(t) == "table" and (M.is_empty(t) or not t[1])
-- end

-- --- Tests if `t` is "dict_like": a table that is not a "list".
-- ---
-- --- An empty table `{}` is considered "dict_like".
-- ---@param t? table table to check.
-- ---@return boolean `true` if table is "dict_like".
-- function M.is_dict_like(t) --
--   return type(t) == "table" and (M.is_empty(t) or not M.is_list(t))
-- end

-- --- Merge unique items from several option "lists".
-- ---
-- --- IMPORTANT:
-- ---  * The unique items will be merged in place into
-- ---    the first non-empty "list" passed in.
-- ---@param ... table "Lists" to merge unique items from.
-- ---@return table? "List" with merged unique items or nil
-- function M.merge_opt_lists(...)
--   local ret = nil
--   local did_init_set = false
--   local set = {}
--
--   local function init_set(t)
--     for _, v in ipairs(t) do
--       set[v] = true
--     end
--     did_init_set = true
--   end
--
--   local function set_insert_unique(t)
--     for _, v in ipairs(t) do
--       if not set[v] then
--         set[v] = true
--         ret[#ret + 1] = v
--       end
--     end
--   end
--
--   for i = 1, select("#", ...) do
--     local t = select(i, ...)
--     if did_init_set then
--       if M.is_list(t) then set_insert_unique(t) end
--     else
--       ret = t
--       if #t > 0 then init_set(t) end
--     end
--   end
--
--   return ret
-- end

-- --- Merge in place "dict_like" `src` into `trg`.
-- ---
-- --- IMPORTANT:
-- ---  * No input validation is performed.
-- ---  * "Lists" are treated as literals and are replaced not merged.
-- ---@param trg table
-- ---@param src table
-- local function deep_merge_2_dict_likes(trg, src)
--   for k, src_v in pairs(src) do
--     local trg_v = trg[k]
--     if trg_v ~= nil and M.is_dict_like(trg_v) and M.is_dict_like(src_v) then
--       deep_merge_2_dict_likes(trg_v, src_v)
--     else
--       trg[k] = src_v
--     end
--   end
-- end

-- --- Deep merge several option "dict_likes".
-- ---
-- --- IMPORTANT:
-- ---  * The "dict_likes" will be merged in place into
-- ---    the first non-empty "dict_like" passed in.
-- ---  * "Lists" are treated as literals and are replaced not merged.
-- ---@param ... table "dict_likes" to merge.
-- ---@return table? "dict_like" with all merged options.
-- function M.merge_opt_dicts(...)
--   local ret = nil
--   local found_base_dict = false
--
--   for i = 1, select("#", ...) do
--     local t = select(i, ...)
--     if M.is_dict_like(t) then
--       if found_base_dict then
--         ---@diagnostic disable-next-line: param-type-mismatch
--         deep_merge_2_dict_likes(ret, t)
--       else
--         ret = t
--         if not M.is_empty(t) then found_base_dict = true end
--       end
--     end
--   end
--
--   return ret
-- end

return M
