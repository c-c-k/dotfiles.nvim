---@class MyUi
---@field aerial MyUiAerial
---@field colorscheme MyUiColorscheme
---@field icons MyUiIcons
---@field lualine MyUiLualine
---@field picker MyUiPicker
---@field toggle MyUiToggle
local M = {}
M.init = { no_init = true, recurse = true } ---@type MyModuleInit

M.keymaps = {}

return M
