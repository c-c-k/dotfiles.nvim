---@class MyWs
---@field resession MyWsResession
local M = {}
M.init = { no_init = true, recurse = true } ---@type MyModuleInit

---@enum
M.Priority = {
  DEFAULT = 10,
  WORKSPACE_NORMAL = 20,
}

local my = require "my"

---@class MyWsBufInfo
---@field name string
---@field root_dir_path string

---@class MyWsConfig
---@field name string
---@field root_dir_path string?
---@field buf_validator (fun(buf_id:BufId): MyWsBufInfo?) | "root_dir_prefix"

--- Get workspace info for a buffer.
---@param buf_id integer
---@return MyWsBufInfo | false | nil
function M.buf_get_ws_info(buf_id)
  ---@type MyWsBufInfo | false | nil
  local ws_buf_info

  -- Try get workspace info from cache
  ws_buf_info = my.config.ws_buf_info_cache_buf[buf_id]
  if ws_buf_info ~= nil then return ws_buf_info end

  -- local ws_configs ---@type MyWsConfig[]
  local ws_configs = my.config.ws_configs
  if ws_configs == nil then
    M._resolve_ws_configs()
    ws_configs = my.config.ws_configs
  end
  ---@cast ws_configs -nil

  for _, ws_config in ipairs(ws_configs) do
    local buf_validator = ws_config.buf_validator

    -- Set buffer workspace info via workspace root dir prefix
    if buf_validator == "root_dir_prefix" then
      local root_dir_path = ws_config.root_dir_path

      if type(root_dir_path) ~= "string" then
        local _msg =
          string.format([[invalid `root_dir_path` for `buf_validator="root_dir_prefix"`: %s]], vim.inspect(ws_config))
        error(_msg)
      end

      local buf_name = vim.api.nvim_buf_get_name(buf_id)
      if buf_name:find(root_dir_path, 1, true) == 1 then
        ws_buf_info = { name = ws_config.name, root_dir_path = root_dir_path }
        break
        -- my.config.ws_buf_info_cache_buf[buf_id] = ws_buf_info
        -- return ws_buf_info
      end

    -- Set buffer workspace info via workspace validator
    elseif type(buf_validator) == "function" then
      ws_buf_info = buf_validator(buf_id)
      if ws_buf_info ~= nil then
        break
        -- my.config.ws_buf_info_cache_buf[buf_id] = ws_buf_info
        -- return ws_buf_info
      end
    else
      local _msg = string.format([[invalid `buf_validator`: %s]], vim.inspect(ws_config))
      error(_msg)
    end
  end

  if ws_buf_info == nil then ws_buf_info = false end

  my.config.ws_buf_info_cache_buf[buf_id] = ws_buf_info
  return ws_buf_info

  -- -- Try to match buffer to workspace via workspace's buffer validation function
  -- for _, ws_validate_buf_func in ipairs(my.config.ws_validate_buf_funcs) do
  --   ws_buf_info = ws_validate_buf_func(buf_id)
  --   if ws_buf_info ~= nil then
  --     my.config.ws_buf_info_cache_buf[buf_id] = ws_buf_info
  --     return ws_buf_info
  --   end
  -- end

  -- -- Try to match buffer to workspace via workspace root dir prefixes
  -- for _, candidate_ws_info in ipairs(my.config.ws_root_dir_paths) do
  --   local buf_name = vim.api.nvim_buf_get_name(buf_id)
  --   local root_dir_path = candidate_ws_info.root_dir_path
  --   if buf_name:find(root_dir_path, 1, true) == 1 then
  --     my.config.ws_buf_info_cache_buf[buf_id] = candidate_ws_info
  --     return candidate_ws_info
  --   end
  -- end
end

--- Register a workspace configuration.
---@param priority integer
---@param config MyWsConfig
function M.register_ws_config(priority, config)
  local ws_configs_by_priority = my.config.ws_configs_by_priority

  local ws_configs_for_priority = ws_configs_by_priority[priority]
  if not ws_configs_for_priority then
    ws_configs_for_priority = {}
    ws_configs_by_priority[priority] = ws_configs_for_priority
  end

  table.insert(ws_configs_for_priority, config)

  if my.config.ws_configs ~= nil then M._resolve_ws_configs() end
end

--- Collect workspace configurations by priority.
--- Bigger priority number equals higher priority.
function M._resolve_ws_configs()
  local ws_configs_by_priority = my.config.ws_configs_by_priority
  local ws_configs = {}

  -- Sort priorities from biggest to smallest.
  local priorities = vim.tbl_keys(ws_configs_by_priority)
  table.sort(priorities, function(a, b) return a > b end)

  -- Flatten priorities from biggest to smallest.
  -- NOTE(MEMO): could probably use `vim.iter.flatten` but using an iterator
  --             directly seems simpler and no less efficient.
  for _, priority in ipairs(priorities) do
    for _, ws_config in ipairs(ws_configs_by_priority[priority]) do
      ws_configs[#ws_configs + 1] = ws_config
    end
  end

  my.config.ws_configs = ws_configs
end

M.keymaps = {}

M.keymaps.exit_with_confirm = { ---@type MyKeymapKeymapSpec
  desc = "Exit with confirm",
  rhs = "<CMD>confirm qall<CR>",
}
M.keymaps.write_all = { ---@type MyKeymapKeymapSpec
  desc = "Write all",
  rhs = "<CMD>confirm wall<CR>",
}

return M
