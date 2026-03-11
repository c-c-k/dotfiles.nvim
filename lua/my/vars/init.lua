---@class my.vars4
local M = {}
local _l = {}

local my = require "my"
local Var = require "my.vars._var"
local var_priorities = require "my.config._var_priorities"

--TODO: DELETE >>>>>>>>>>>>>>>>>

---@class (exact) my.ttt
---@field povar_i POVar4<integer> # sldfj
---@field svar_i SVar4<integer?> # description
---@field sovar_i SOVar4<integer?> # odsifa
local ttt = {}

ttt.svar_i:init(nil, { simple = true })
ttt.svar_i:init(3, { simple = true })
ttt.svar_i:init("3", { simple = true })
ttt.svar_i:init(3, {})
ttt.sovar_i:init(nil, { simple = true, nvim_opt = true })
ttt.sovar_i:init(nil, { simple = true })
ttt.povar_i:set(0, "a")
ttt.svar_i:set(0, "a")
ttt.sovar_i:set(0, "a")

---@type boolean
local ttv = ttt.povar_i:get_top_entry()[2]
-- local ttv = ttt.povar_i:get_all_entries_as_dict()
-- local ttv = ttt.povar_i:get()
---@type boolean
local ttv2 = ttt.svar_i:get()
my.notify.trace({ ttv, ttv2 }, { title = "DELETE IN SOURCE" })

--TODO: DELETE <<<<<<<<<<<<<<<<<

M.priority_info = vim.iter(var_priorities):fold({}, function(acc, priority_name, priority_value)
  acc[priority_value] = ("%s (%d)"):format(priority_name, priority_value)
  return acc
end)

--- Delete the accessor and backend handles for the given buffer.
---@param handle_id integer
function M._delete_buf_handles(handle_id)
  Var.delete_handle("b", handle_id)
  rawset(my.b, handle_id, nil)
end

--- Delete the accessor and backend handles for the given window.
---@param handle_id integer
function M._delete_win_handles(handle_id)
  Var.delete_handle("w", handle_id)
  rawset(my.w, handle_id, nil)
end

--- Delete the accessor and backend handles for the given tabpage.
---@param handle_id integer
function M._delete_tab_handles(handle_id)
  Var.delete_handle("t", handle_id)
  rawset(my.t, handle_id, nil)
end

M.autocmds = {}

M.autocmds.setup_handles_delete = function()
  local augroup = my.autocmd.get_augroup("my.vars.handles_delete", true)
  my.autocmd.add_autocmd {
    desc = "delete buffer scope MyVar handles on buffer delete",
    group = augroup,
    event = "BufDelete",
    callback = function(args) --
      vim.schedule_wrap(M._delete_buf_handles)(args.buf)
    end,
  }
  my.autocmd.add_autocmd {
    desc = "delete window scope MyVar handles on window delete",
    group = augroup,
    event = "WinClosed",
    callback = function(args) --
      vim.schedule_wrap(M._delete_win_handles)(tonumber(args.file))
    end,
  }
  my.autocmd.add_autocmd {
    desc = "delete tabpage scope MyVar handles on tabpage delete",
    group = augroup,
    event = "User",
    pattern = "MyTabClosed",
    callback = function(args) --
      vim.schedule_wrap(M._delete_tab_handles)(args.data.tab_id)
    end,
  }
end

return M
