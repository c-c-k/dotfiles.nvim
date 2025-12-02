local my = require "my"

---@type LazyPluginSpec
local spec_my_core = {
  dir = vim.fn.stdpath "config",
  opts = function()
    require "config/options"
    -- require "config/commands"
    -- require "config/mappings"
    -- require "config/autocommands"
  end,
}

---@type LazyPluginSpec[]
return {
  spec_my_core,
}
