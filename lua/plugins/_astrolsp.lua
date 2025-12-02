local my = require "my"

---@type LazyPluginSpec
local spec_astrolsp = {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    return my.tbl.merge("dDFn", opts, {
      -- PLACEHOLDER
    } --[[@as AstroLSPOpts]])
  end,
}

---@type LazyPluginSpec[]
return {
  spec_astrolsp,
}
