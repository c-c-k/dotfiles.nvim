local my = require "my"
---@class my.ui.icons
local M = {}

M.opts = {}
M.opts.mini_icons_general = function(_, opts) ---@cast opts MyNoOptsSpec
  return my.tbl.merge_dicts_into_last(opts, {
    style = my.g.icons_enabled and "glyph" or "ascii",
  } --[[@as MyNoOptsSpec]])
end
M.opts.mini_icons_config = function(_, opts)
  local mini_icons = require "mini.icons"
  local mock_nvim_web_devicons = opts.mock_nvim_web_devicons
  opts.mock_nvim_web_devicons = nil
  mini_icons.setup(opts)

  if mock_nvim_web_devicons then mini_icons.mock_nvim_web_devicons() end
end

return M
