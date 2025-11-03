---@type LazyPluginSpec
local spec_nvim_autopairs = {
  "windwp/nvim-autopairs",
}

---@type LazyPluginSpec
local spec_nvim_autopairs__astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local astromaps = opts.mappings

    local maps, map = require("cck.utils.config").get_astrocore_mapper()

    map("n", "<LEADER>ua", { copy = { "n", "<Leader>ua", source = astromaps } }) -- desc = "Toggle autopairs"

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

spec_nvim_autopairs.specs = {
  spec_nvim_autopairs__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_nvim_autopairs,
}
