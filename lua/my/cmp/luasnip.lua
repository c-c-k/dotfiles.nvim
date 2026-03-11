---@class my.cmp.luasnip
local M = {}

M.opts = {}
M.opts.general = function(_, opts) --
  opts.link_children = true
  opts.link_roots = true
  opts.keep_roots = true
  opts.delete_check_events = "TextChanged"
  opts.region_check_events = "CursorMoved"
end
M.opts.config = function(_, opts) --
  require("luasnip").config.setup(opts or {})
  require("luasnip.loaders.from_vscode").lazy_load()
end

return M
