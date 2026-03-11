local my = require "my"
---@class my.notify
local M = {}

M.opts = {}

M.opts.snacks_notifier_core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_snknotfy)
end

--@param msg string|string[]
---@param opts? snacks.notify.Opts
function M.error(msg, opts) --
  return M.notify(msg, my.tbl.merge_dicts_into_last(opts, { level = vim.log.levels.ERROR }))
end

---@param msg string|string[]
---@param opts? snacks.notify.Opts
function M.debug(msg, opts) --
  return M.notify(msg, my.tbl.merge_dicts_into_last(opts, { level = vim.log.levels.DEBUG }))
end

function M.dismiss_all() --
  require("snacks.notifier").hide()
end

---@param msg string|string[]
---@param opts? snacks.notify.Opts
function M.info(msg, opts) --
  return M.notify(msg, my.tbl.merge_dicts_into_last(opts, { level = vim.log.levels.INFO }))
end

---@param msg string|string[]
---@param opts? snacks.notify.Opts
function M.notify(msg, opts) --
  local has_snacks, snacks = pcall(require, "snacks")
  if has_snacks then return snacks.notify(msg, opts) end
  opts = opts or {}
  local level = opts.level
  msg = vim.inspect(msg)
  if opts.title then msg = "# " .. opts.title .. "\n" .. msg end
  return vim.notify(msg, level)
end

---@param msg any
---@param opts? snacks.notify.Opts
function M.trace(msg, opts) --
  if not type(msg) == "table" then msg = { msg } end
  for index, item in ipairs(msg) do
    if type(item) ~= "string" then msg[index] = vim.inspect(item) end
  end
  ---@cast msg string[]
  msg[#msg + 1] = "TRACEBACK:"
  local trace_level = 1
  while true do
    trace_level = trace_level + 1
    local trace_info = debug.getinfo(trace_level)
    if not trace_info then break end
    msg[#msg + 1] = ("  %s: %s"):format(trace_info.source:gsub("^@", ""), trace_info.currentline)
  end

  return M.notify(msg, my.tbl.merge_dicts_into_last(opts, { level = vim.log.levels.TRACE }))
end

---@param msg string|string[]
---@param opts? snacks.notify.Opts
function M.warn(msg, opts) --
  return M.notify(msg, my.tbl.merge_dicts_into_last(opts, { level = vim.log.levels.WARN }))
end

M.keymaps = {}

M.keymaps.dismiss_all = { ---@type my.keymap.keymap_spec
  desc = "dismiss all notifications",
  rhs = M.dismiss_all,
}

return M
