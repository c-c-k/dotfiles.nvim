---@class My
---@field autocmd MyAutocmd
---@field buf MyBuf
---@field cmp MyCmp
---@field dap MyDap
---@field fs MyFs
---@field ft MyFt
---@field git MyGit
---@field go_to MyGoTo
---@field keymap MyKeymap
---@field lsp MyLsp
---@field misc MyMisc
---@field motion MyMotion
---@field notify MyNotify
---@field setup MySetup
---@field syntax MySyntax
---@field tab MyTab
---@field tbl MyTbl
---@field term MyTerm
---@field ui MyUi
---@field win MyWin
---@field ws MyWs
---@field ypxcd MyYpxcd
local M = require "my.setup.utils._lazy_loading_module_func"("my", {})
M.init = { no_init = true, recurse = true } ---@type MyModuleInit

---@type MyConfig
M.config = require("my.setup.utils").requires_init "my.config"
---@type table
M.rs = require("my.setup.utils").requires_init "my.rs"

return M
