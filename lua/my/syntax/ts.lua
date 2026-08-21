---@class MySyntaxTS
local M = {}
M.init = { no_init = true, recurse = false } ---@type MyModuleInit

local my = require "my"

--- Check if buffer treesitter highlighting is on.
function M.syntax_hl_is_enabled_buf()
  local buf_id = vim.api.nvim_get_current_buf()
  local has_ts_hl, ts_hl = pcall(vim.api.nvim_buf_get_var, buf_id, "ts_highlight")
  return has_ts_hl and ts_hl
end

--- Toggle buffer treessitter highlighting.
---@param enable boolean # if false turns highlighting off.
function M.syntax_hl_toggle_buf(enable)
  local ok, err
  if enable then
    ok, err = pcall(vim.treesitter.start)
  else
    ok, err = pcall(vim.treesitter.stop)
  end
  if not ok then
    local state = enable and "start" or "stop"
    local _msg = string.format("failed to %s Treesitter: %s", state, err)
    my.notify.error(_msg)
    return
  end
end

M.keymaps = {}
M.keymaps.init_selection = { ---@type MyKeymapKeymapSpec
  desc = "TS start inc selection",
  rhs = function() vim.treesitter.select "parent" end,
}
M.keymaps.node_decremental = { ---@type MyKeymapKeymapSpec
  desc = "TS node- selection",
  rhs = function() vim.treesitter.select "child" end,
}
M.keymaps.node_incremental = { ---@type MyKeymapKeymapSpec
  desc = "TS node+ selection",
  rhs = function() vim.treesitter.select "parent" end,
}
M.keymaps.scope_incremental = { ---@type MyKeymapKeymapSpec
  desc = "TS scope+ selection",
  rhs = function() vim.treesitter.select "extend_next" end,
}

return M
