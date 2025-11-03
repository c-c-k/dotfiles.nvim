---@type LazyPluginSpec
local spec_astrolsp = {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      -- PLACEHOLDER
    } --[[@as AstroLSPOpts]])
  end,
}

---@type LazyPluginSpec[]
return {
  spec_astrolsp,
}
