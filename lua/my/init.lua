-- local M = {}
local M = setmetatable({}, {
  __index = function(t, k)
    local success, result = pcall(require, "my." .. k)
    if success then
      rawset(t, k, result)
      return t[k]
    end
    local msg = string.format('Could not load module: "my.%s"', k)
    return error(msg, 2)
  end,
})

---@module "my.autocmd"
M.autocmd = nil
---@module "my.buf"
M.buf = nil
---@module "my.codecompanion"
M.codecompanion = nil
---@module "my.goto"
M.goto = nil
---@module "my.keymap"
M.keymap = nil
---@module "my.misc"
M.misc = nil
---@module "my.path"
M.path = nil
---@module "my.term"
M.term = nil
---@module "my.win"
M.win = nil

function M.setup() end

return M
