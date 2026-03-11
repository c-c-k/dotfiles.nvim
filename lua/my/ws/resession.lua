local my = require "my"
---@class my.ws.resession
local M = {}

M.opts = {}
M.opts.general = function(_, opts) ---@cast opts MyNoOptsSpec
  -- TODO: Autosave on exit?
  -- TODO: opts.buf_filter = function(bufnr) ... end
  opts.tab_buf_filter = function(tabpage, bufnr) return vim.tbl_contains(vim.t[tabpage].bufs, bufnr) end

  package.preload["resession.extensions.tab_names"] = function() return M.extensions.tab_names end
  return my.tbl.merge_dicts_into_last(opts, {
    extensions = {
      tab_names = { enable_in_tab = true },
    },
  } --[[@as MyNoOptsSpec]])
end
M.opts.core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_rsession)
end

function M.open_sessions_dir() --
  require("oil").toggle_float(vim.fs.joinpath(vim.fn.stdpath "data", "session"))
end

function M.save_current_session_with_timestamp(tab)
  local resession = require "resession"
  local current = resession.get_current_session_info()
  ---@diagnostic disable-next-line: undefined-field # missing annotation upstream
  if current and (tab or false) == current.tab_scoped then
    M.save_session_with_timestamp(current.name, tab)
  else
    M.save_new_session_with_timestamp(tab)
  end
end

function M.save_current_tab_session_with_timestamp() --
  M.save_current_session_with_timestamp(true)
end

function M.save_new_session_with_timestamp(tab)
  vim.ui.input(
    { prompt = "Enter new session name", completion = "customlist,v:lua.require'my.ws.resession'.session_name_cmp" },
    function(name)
      if name then M.save_session_with_timestamp(name, tab) end
    end
  )
end

function M.save_new_tab_session_with_timestamp() --
  M.save_new_session_with_timestamp(true)
end

--- TODO: Description
---@param name string
---@param tab boolean
function M.save_session_with_timestamp(name, tab)
  local resession = require "resession"
  local save_func = tab and resession.save_tab or resession.save
  name = name:gsub(" %(%d%d%d%d%-%d%d%-%d%dT%d%d%-%d%d%)$", "") .. os.date " (%Y-%m-%dT%H-%M)"
  save_func(name, { attach = true, notify = true })
end

function M.session_name_cmp(arg_lead, _, _)
  local sessions, sessions_set = {}, {}
  for _, session in ipairs(require("resession").list()) do
    session = session:gsub(" %(%d%d%d%d%-%d%d%-%d%dT%d%d%-%d%d%)$", "")
    if not sessions_set[session] then
      sessions_set[session] = true
      sessions[#sessions + 1] = session
    end
  end
  return arg_lead == "" and sessions or vim.fn.matchfuzzy(sessions, arg_lead)
end

M.extensions = {}
M.extensions.tab_names = { ---@type resession.Extension
  on_save = function(opts)
    local opt_tabpage = opts.tabpage
    if opt_tabpage then
      local tab_name = vim.t[opt_tabpage].name
      return { tab_scoped = true, tab_name = tab_name or false }
    end

    local tab_names = {}
    for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
      local tab_name = vim.t[tabpage].name
      tab_names[#tab_names + 1] = tab_name or false
    end
    return { tab_scoped = false, tab_names = tab_names }
  end,
  on_post_load = function(data) --
    if data.tab_scoped then
      vim.t[0].name = data.tab_name
    else
      local tab_names = data.tab_names
      local tabpages = vim.api.nvim_list_tabpages()
      if #tab_names ~= #tabpages then
        vim.notify("session mismatch between tab names and tab count", vim.log.levels.ERROR)
        return
      end
      for i = 1, #tabpages do
        vim.t[tabpages[i]].name = tab_names[i]
      end
    end
  end,
}

M.keymaps = {}
M.keymaps.delete_a_dirsession = { ---@type my.keymap.keymap_spec
  desc = "Delete a dirsession",
  rhs = function() require("resession").delete(nil, { dir = "dirsession" }) end,
}
M.keymaps.delete_a_session = { ---@type my.keymap.keymap_spec
  desc = "Delete a session",
  rhs = function() require("resession").delete() end,
}
M.keymaps.load_current_dirsession = { ---@type my.keymap.keymap_spec
  desc = "Load current dirsession",
  rhs = function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
}
M.keymaps.load_last_session = { ---@type my.keymap.keymap_spec
  desc = "Load last session",
  rhs = function() require("resession").load "Last Session" end,
}
M.keymaps.open_sessions_dir = { ---@type my.keymap.keymap_spec
  desc = "Save current session",
  rhs = M.open_sessions_dir,
}
M.keymaps.save_current_session = { ---@type my.keymap.keymap_spec
  desc = "Save current session",
  rhs = M.save_current_session_with_timestamp,
}
M.keymaps.save_current_tab_session = { ---@type my.keymap.keymap_spec
  desc = "Save current tab session",
  rhs = M.save_current_tab_session_with_timestamp,
}
M.keymaps.save_new_session = { ---@type my.keymap.keymap_spec
  desc = "force new session",
  rhs = M.save_new_session_with_timestamp,
}
M.keymaps.save_new_tab_session = { ---@type my.keymap.keymap_spec
  desc = "force new tab session",
  rhs = M.save_new_tab_session_with_timestamp(),
}
M.keymaps.save_this_dirsession = { ---@type my.keymap.keymap_spec
  desc = "Save this dirsession",
  rhs = function() require("resession").save(vim.fn.getcwd(), { dir = "dirsession" }) end,
}

return M
