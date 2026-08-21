---@class MyNotify
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_snacks_notifier
end

M._spec_snacks_notifier = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["snacks-nvim"],
    opts = { ---@type snacks.Config
      notifier = {
        config = function() --
          my.keymap.queue_km_group_load(my.config.keymaps.g_snknotfy)
        end,
      },
    },
  }
  return spec
end

--@param msg string|string[]
---@param opts? snacks.notify.Opts
function M.error(msg, opts) --
  return M.notify(msg, my.tbl.merge("dDfL", opts, { level = vim.log.levels.ERROR }))
end

---@param msg string|string[]
---@param opts? snacks.notify.Opts
function M.debug(msg, opts) --
  return M.notify(msg, my.tbl.merge("dDfL", opts, { level = vim.log.levels.DEBUG }))
end

function M.dismiss_all() --
  require("snacks.notifier").hide()
end

---@param msg string|string[]
---@param opts? snacks.notify.Opts
function M.info(msg, opts) --
  return M.notify(msg, my.tbl.merge("dDfL", opts, { level = vim.log.levels.INFO }))
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

---@param items any
---@param opts? snacks.notify.Opts
function M.trace(items, opts) --
  ---@type string[]
  local msg = {}

  if not type(items) == "table" then items = { items } end
  for key, value in pairs(items) do
    -- if type(value) ~= "string" then value = vim.inspect(value) end
    -- if type(key) ~= "string" then key = vim.inspect(key) end
    msg[#msg + 1] = string.format("%s: %s", vim.inspect(key), vim.inspect(value))
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

  return M.notify(msg, my.tbl.merge("dDfL", opts, { level = vim.log.levels.TRACE }))
end

---@param msg string|string[]
---@param opts? snacks.notify.Opts
function M.warn(msg, opts) --
  return M.notify(msg, my.tbl.merge("dDfL", opts, { level = vim.log.levels.WARN }))
end

M.keymaps = {}

M.keymaps.dismiss_all = { ---@type MyKeymapKeymapSpec
  desc = "dismiss all notifications",
  rhs = M.dismiss_all,
}

return M
