local my = require "my"

---@type LazyPluginSpec
local spec_astroui = {
  "AstroNvim/astroui",
  opts = function(_, opts)
    return my.tbl.merge("dDFn", opts, {
      status = {
        -- PLACEHOLDER
      },
    } --[[@as AstroUIOpts]])
  end,
}

---@type LazyPluginSpec[]
return {
  spec_astroui,
}
