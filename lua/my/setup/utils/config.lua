local my = require "my"

---@enum HandleType
local HandleType = {
  BUF = 1,
  WIN = 2,
  TABPAGE = 3,
}

---@alias RegisterHandleFunc fun(t: table, k: integer, v: any)

-- NOTE: Should be initialized in `my.config._setup_my_config`
local CLEAN_UP_AUTOCMDS_GROUP = "my.config.cleanup"

-- dict{event: dict{handle: list[tables from which handle needs to be cleared]}}
---@type table<string, table<integer, table[]>>
local clean_up_autocmd_registries = {}
---@type integer
local prev_tab_id

--- Initializes a buf/win/tabpage handles list with a metatable that
--- will call `register_handle_func(t, k, v)` for every handle that is
--- inserted into it.
--- This is mostly meant for setting up autocommands or other means to cleanup
--- the handles from the list when they are no longer needed.
---@param handle_type HandleType
---@param register_handle_func RegisterHandleFunc
---@return table
local function init_hadle_opt(handle_type, register_handle_func)
  local default_handle_func = (handle_type == HandleType.BUF and vim.api.nvim_get_current_buf)
    or (handle_type == HandleType.WIN and vim.api.nvim_get_current_win)
    or (handle_type == HandleType.TABPAGE and vim.api.nvim_get_current_tabpage)
    or error("invalid handle type: " .. vim.inspect(handle_type))

  local handle_t = setmetatable({}, {
    __newindex = function(t, k, v)
      k = k == 0 and default_handle_func() or k
      register_handle_func(t, k, v)
      rawset(t, k, v)
    end,
    __index = function(t, k)
      k = k == 0 and default_handle_func() or k
      return rawget(t, k)
    end,
  })
  return handle_t
end

--- Setup the cleanup autocmd and `clean_up_autocmd_registries` entry
--- for `init_std_clear_on_autocmds_handles_list`
---@param handle_type HandleType
---@param event string
---@return table
local function setup_cleanup_autocmd(handle_type, event)
  local clean_up_autocmd_registry = {}
  clean_up_autocmd_registries[event] = clean_up_autocmd_registry
  local group = my.autocmd.get_augroup(CLEAN_UP_AUTOCMDS_GROUP, false)

  if handle_type == HandleType.BUF then
    my.autocmd.add_autocmd {
      group = group,
      event = event,
      callback = function(args)
        local handle = args.buf
        -- perf?: manually copy code instead of delegating to a function
        local tables_to_cleanup = clean_up_autocmd_registry[handle]
        if tables_to_cleanup ~= nil then
          clean_up_autocmd_registry[handle] = nil
          for _, table_to_cleanup in pairs(tables_to_cleanup) do --
            table_to_cleanup[handle] = nil
          end
        end
        -- perf?: END
      end,
    }
  elseif handle_type == HandleType.WIN then
    my.autocmd.add_autocmd {
      group = group,
      event = event,
      callback = function(args)
        local handle = tonumber(args.file) or -1 -- perf?: skim on a type check
        -- perf?: manually copy code instead of delegating to a function
        local tables_to_cleanup = clean_up_autocmd_registry[handle]
        if tables_to_cleanup ~= nil then
          clean_up_autocmd_registry[handle] = nil
          for _, table_to_cleanup in pairs(tables_to_cleanup) do --
            table_to_cleanup[handle] = nil
          end
        end
        -- perf?: END
      end,
    }
  elseif event == "BufDelete" then
    --- Because the "TabClosed" event only fires after the tab has
    --- already closed but returns the tab number rather than the tab id
    --- there is no clean way to get the tab id of the closed tab (or at least
    --- I don't know one) and so this workaround is needed to get the actual
    --- tab id.
    prev_tab_id = vim.api.nvim_get_current_tabpage()
    my.autocmd.add_autocmd {
      -- record the current tab id on `TabLeave`.
      group = group,
      event = "TabClosedPre",
      callback = function(_) --
        prev_tab_id = vim.api.nvim_get_current_tabpage()
      end,
    }
    my.autocmd.add_autocmd {
      -- on `TabClosed` clean up tables for the handle recorded by 'TabLeave'.
      group = group,
      event = "TabClosed",
      callback = function(_) --
        local handle = prev_tab_id
        -- perf?: manually copy code instead of delegating to a function
        local tables_to_cleanup = clean_up_autocmd_registry[handle]
        if tables_to_cleanup ~= nil then
          clean_up_autocmd_registry[handle] = nil
          for _, table_to_cleanup in pairs(tables_to_cleanup) do --
            table_to_cleanup[handle] = nil
          end
        end
        -- perf?: END
      end,
    }
  else -- handle_type == HandleType.TABPAGE
    my.autocmd.add_autocmd {
      group = group,
      event = event,
      callback = function(_)
        -- Unlike with window and buffer autocommands, tabpage autocommands
        -- don't seem to receive the tab id in the autocommand args,
        -- but there also doesn't seem to be a way for a tab event to trigger
        -- for an inactive tab.
        local handle = vim.api.nvim_get_current_tabpage()
        -- perf?: manually copy code instead of delegating to a function
        local tables_to_cleanup = clean_up_autocmd_registry[handle]
        if tables_to_cleanup ~= nil then
          clean_up_autocmd_registry[handle] = nil
          for _, table_to_cleanup in pairs(tables_to_cleanup) do --
            table_to_cleanup[handle] = nil
          end
        end
        -- perf?: END
      end,
    }
  end

  return clean_up_autocmd_registry
end

--- Initializes a buf/win/tabpage handles list such that handles will be
--- removed from it by the given `events`.
---@param handle_type HandleType
---@param events string[]
---@return table
local function init_clear_on_autocmds_handles_list(handle_type, events)
  return init_hadle_opt(
    handle_type,
    ---@type RegisterHandleFunc
    function(t, k, _)
      for _, event in ipairs(events) do
        local clean_up_autocmd_registry = clean_up_autocmd_registries[event]
          or setup_cleanup_autocmd(handle_type, event)
        local tables_to_cleanup = clean_up_autocmd_registry[k]
        if tables_to_cleanup == nil then
          tables_to_cleanup = {}
          clean_up_autocmd_registry[k] = tables_to_cleanup
        end
        table.insert(tables_to_cleanup, t)
      end
    end
  )
end

--- Initializes a tabpage handles list such that handles will be
--- removed from it by the `TabClosed` event.
---@return table
local function init_clear_on_tab_closed_handles_list()
  return init_clear_on_autocmds_handles_list(HandleType.BUF, { "TabClosed" })
end

--- Initializes a buf handles list such that handles will be
--- removed from it by the `BufWipeout` event.
---@return table
local function init_clear_on_buf_wipeout_handles_list()
  return init_clear_on_autocmds_handles_list(HandleType.BUF, { "BufWipeout" })
end

--- Initializes a buf handles list such that handles will be
--- removed from it by the `BufDelete` event.
---@return table
local function init_clear_on_buf_delete_handles_list()
  return init_clear_on_autocmds_handles_list(HandleType.BUF, { "BufDelete" })
end

--- Initializes a buf handles list such that handles will be
--- removed from it by the `BufWritePost` event.
---@return table
local function init_clear_on_buf_write_post_handles_list()
  return init_clear_on_autocmds_handles_list(HandleType.BUF, { "BufWritePost" })
end

---@class MySetupUtilsConfig
local M = {
  CLEAN_UP_AUTOCMDS_GROUP = CLEAN_UP_AUTOCMDS_GROUP,
  HandleType = HandleType,
  init_clear_on_autocmds_handles_list = init_clear_on_autocmds_handles_list,
  init_clear_on_buf_delete_handles_list = init_clear_on_buf_delete_handles_list,
  init_clear_on_buf_wipeout_handles_list = init_clear_on_buf_wipeout_handles_list,
  init_clear_on_buf_write_post_handles_list = init_clear_on_buf_write_post_handles_list,
  init_clear_on_tab_closed_handles_list = init_clear_on_tab_closed_handles_list,
  init_hadle_opt = init_hadle_opt,
}

return M
