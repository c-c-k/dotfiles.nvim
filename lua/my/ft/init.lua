---@class MyFt
---@field bash MyFtBash
---@field c MyFtC
---@field csv MyFtCSV
---@field git MyFtGit
---@field go MyFtGo
---@field godot MyFtGodot
---@field lua MyFtLua
---@field manpage MyFtManpage
---@field markdown MyFtMarkdown
---@field ts_only MyFtTSOnly
---@field nvim_help MyFtNvimHelp
---@field python MyFtPython
---@field rest MyFtRest
---@field rust MyFtRust
---@field toml MyFtToml
---@field vim MyFtVim
local M = {}
M.init = { no_init = true, recurse = true } ---@type MyModuleInit

return M
