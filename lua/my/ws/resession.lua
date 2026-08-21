---@class MyWsResession
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_ressesion
end

M._spec_ressesion = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["resession.nvim"],
    opts = {
      -- TODO: Autosave on exit?

      -- TODO: opts.buf_filter = function(bufnr) ... end,

      -- MEMO: The buffers open in the current tabpage are always included,
      --       this function only specifies additional buffers that should
      --       be saved for a tabpage session.
      tab_buf_filter = function() end,
      -- tab_buf_filter = function(tab_id, buf_id) ... end,

      extensions = {
        aerial = {},
        oil = {},
        [M._create_extension_module("tab_names", M.extensions.tab_names)] = {},
      },
    },
    config = function(_, opts)
      require("resession").setup(opts)

      my.keymap.queue_km_group_load(my.config.keymaps.g_rsession)
    end,
  }
  return spec
end

function M._create_extension_module(name, module_table)
  package.preload["resession.extensions." .. name] = function() return module_table end
  return name
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
    { prompt = "Enter new session name: ", completion = "customlist,v:lua.require'my.ws.resession'.session_name_cmp" },
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

-- TODO: Create general purpose extension for saving my.config data
M.extensions.lsp_custom_config_name = { ---@type resession.Extension
  on_save = function(opts)
    local bufs_list
    local tab_id = opts.tabpage
    if tab_id then
      bufs_list = {}
      for _, win_id in ipairs(vim.api.nvim_tabpage_list_wins(tab_id)) do
        bufs_list[vim.api.nvim_win_get_buf(win_id)] = true
      end
      bufs_list = my.tbl.set_to_list(bufs_list)
    else
      bufs_list = vim.api.nvim_list_bufs()
    end

    local buf_names = {}
    for _, buf_id in ipairs(bufs_list) do
      local lsp_custom_config_name = my.config.lsp_custom_config_name_buf[buf_id]
      if lsp_custom_config_name then
        local buf_name = vim.api.nvim_buf_get_name(buf_id)
        buf_names[buf_name] = lsp_custom_config_name
      end
    end
    return { tab_scoped = tab_id ~= nil, buf_names = buf_names }
  end,
  on_post_load = function(data) --
    local buf_names = data.buf_names

    if type(buf_names) ~= "table" or my.tbl.is_empty(buf_names) then return end

    for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
      local buf_name = vim.api.nvim_buf_get_name(buf_id)
      local lsp_custom_config_name = buf_names[buf_name]
      if lsp_custom_config_name then --
        my.config.lsp_custom_config_name_buf[buf_id] = lsp_custom_config_name
      end
    end
  end,
}

M.extensions.tab_names = { ---@type resession.Extension
  on_save = function(opts)
    do
      local tab_id = opts.tabpage
      if tab_id then
        local tab_name = my.config.name_tab[tab_id]
        return { tab_scoped = true, tab_name = tab_name or false }
      end
    end

    local tab_names = {}
    for _, tab_id in ipairs(vim.api.nvim_list_tabpages()) do
      local tab_name = my.config.name_tab[tab_id]
      tab_names[#tab_names + 1] = tab_name or false
    end
    return { tab_scoped = false, tab_names = tab_names }
  end,
  on_post_load = function(data) --
    if data.tab_scoped then
      local tab_id = vim.api.nvim_get_current_tabpage()
      my.config.name_tab[tab_id] = data.tab_name
    else
      local tab_names = data.tab_names
      local tabpages = vim.api.nvim_list_tabpages()
      if #tab_names ~= #tabpages then error "session mismatch between tab names and tab count" end
      for tabnr = 1, #tabpages do
        local tab_id = tabpages[tabnr]
        my.config.name_tab[tab_id] = tab_names[tabnr]
      end
    end
  end,
}

M.keymaps = {}
M.keymaps.delete_a_dirsession = { ---@type MyKeymapKeymapSpec
  desc = "Delete a dirsession",
  rhs = function() require("resession").delete(nil, { dir = "dirsession" }) end,
}
M.keymaps.delete_a_session = { ---@type MyKeymapKeymapSpec
  desc = "Delete a session",
  rhs = function() require("resession").delete() end,
}
M.keymaps.load_current_dirsession = { ---@type MyKeymapKeymapSpec
  desc = "Load current dirsession",
  rhs = function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
}
M.keymaps.load_last_session = { ---@type MyKeymapKeymapSpec
  desc = "Load last session",
  rhs = function() require("resession").load "Last Session" end,
}
M.keymaps.open_sessions_dir = { ---@type MyKeymapKeymapSpec
  desc = "Save current session",
  rhs = M.open_sessions_dir,
}
M.keymaps.save_current_session = { ---@type MyKeymapKeymapSpec
  desc = "Save current session",
  rhs = M.save_current_session_with_timestamp,
}
M.keymaps.save_current_tab_session = { ---@type MyKeymapKeymapSpec
  desc = "Save current tab session",
  rhs = M.save_current_tab_session_with_timestamp,
}
M.keymaps.save_new_session = { ---@type MyKeymapKeymapSpec
  desc = "force new session",
  rhs = M.save_new_session_with_timestamp,
}
M.keymaps.save_new_tab_session = { ---@type MyKeymapKeymapSpec
  desc = "force new tab session",
  rhs = M.save_new_tab_session_with_timestamp,
}
M.keymaps.save_this_dirsession = { ---@type MyKeymapKeymapSpec
  desc = "Save this dirsession",
  rhs = function() require("resession").save(vim.fn.getcwd(), { dir = "dirsession" }) end,
}

return M
