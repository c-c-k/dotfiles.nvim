local my = require "my"
---@class my.syntax.indent
local M = {}

M.opts = {}
M.opts.snacks_indent_general = function(_, opts) ---@cast opts snacks.indent.Config
  return my.tbl.merge_dicts_into_last(opts, {
    filter = M.is_enabled_buf,
  } --[[@as snacks.indent.Config]])
end
M.opts.snacks_indent_core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_snkindnt)
end

function M.is_enabled_buf(bufnr, win_id) --
  return my.buf.is_normal(bufnr)
    and my.bp[bufnr or 0].indent_guide:get_top()
    and my.wp[win_id or 0].indent_guide:get_top()
end

function M.toggle_buf(enable) --
  my.ui.toggle.toggle_priority_var(my.bp[0].indent_guide, enable)
end

return M
