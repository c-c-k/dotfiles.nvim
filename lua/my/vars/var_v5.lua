--  LLS Generics :_(
local my = require "my"
---@type boolean
local x = my.var5.get(my.vp.GLOBAL_DEFAULT, "g.var_a")
local y = my.var5.get(my.vp.GLOBAL_DEFAULT, "my.var5")
local z = my.var5.get(my.vp.GLOBAL_DEFAULT, "b.var_c")
vim.print(x, y, z)
