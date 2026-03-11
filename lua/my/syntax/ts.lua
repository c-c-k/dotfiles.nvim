local my = require "my"
---@class my.syntax.ts
local M = {}

M.opts = {}
M.opts.general = function(_, opts) ---@cast opts MyNoOptsSpec
  return my.tbl.merge_dicts_into_last(opts, {
    ensure_installed = {},
    incremental_selection = false, -- mappings added manually
  } --[[@as MyNoOptsSpec]])
end
M.opts.core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_nv_ts___)
end

--- Check if buffer has a treesitter parser available.
function M.buf_has_parser()
  local nts_avail, parsers = pcall(require, "nvim-treesitter.parsers")
  if not nts_avail then
    my.notify.warn "Nvim.treesitter not available"
    return pcall(vim.treesitter.get_parser)
  end
  return parsers.has_parser()
end

function M.syntax_hl_is_enabled_buf() -- Check if buffer treesitter highlighting is on.
  return vim.b.ts_highlight
end

--- Toggle buffer treessitter highlighting.
---@param enable boolean # if false turns highlighting off.
function M.syntax_hl_toggle_buf(enable)
  if not M.buf_has_parser() then return my.notify.error "No treesitter parser available for current buffer." end
  if enable then
    vim.treesitter.start()
  else
    vim.treesitter.stop()
  end
end

M.keymaps = {}

M.keymaps.init_selection = { ---@type my.keymap.keymap_spec
  desc = "TS start inc selection",
  rhs = function() require("treesitter.incremental_selection").init_selection() end,
}
M.keymaps.node_decremental = { ---@type my.keymap.keymap_spec
  desc = "TS node- selection",
  rhs = function() require("treesitter.incremental_selection").node_decremental() end,
}
M.keymaps.node_incremental = { ---@type my.keymap.keymap_spec
  desc = "TS node+ selection",
  rhs = function() require("treesitter.incremental_selection").node_incremental() end,
}
M.keymaps.scope_incremental = { ---@type my.keymap.keymap_spec
  desc = "TS scope+ selection",
  rhs = function() require("treesitter.incremental_selection").scope_incremental() end,
}

return M
