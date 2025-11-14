---@type LazyPluginSpec
local spec_heirline_nvim = {
  "rebelot/heirline.nvim",
}

---@type LazyPluginSpec
local spec_heirline_nvim__astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local astromaps = opts.mappings

    local maps, map = require("my.core.keymaps").get_astrocore_mapper()

    map("n", "<Leader>bss", { copy = { "n", "<Leader>bb", source = astromaps } }) -- desc = "Select buffer from tabline"
    map("n", "<Leader>bxs", { copy = { "n", "<Leader>bd", source = astromaps } }) -- desc = "Close buffer from tabline"

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

spec_heirline_nvim.specs = {
  spec_heirline_nvim__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_heirline_nvim,
}
