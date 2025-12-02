local my = require "my"

---@type LazyPluginSpec
local spec_aerial_nvim = {
  "stevearc/aerial.nvim",
}

---@type LazyPluginSpec
local spec_aerial_nvim__astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local astromaps = opts.mappings
    local maps, map = my.keymap.get_astrocore_mapper()

    map("n", "<LEADER>ls", { copy = { "n", "<Leader>lS", source = astromaps } }) -- desc = "Symbols outline"

    opts.mappings = my.tbl.merge("dDFn", opts.mappings, maps)
  end,
}

spec_aerial_nvim.specs = {
  spec_aerial_nvim__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_aerial_nvim,
}
