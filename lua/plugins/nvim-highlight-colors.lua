---@type LazyPluginSpec
local spec_nvim_highlight_colors = {
  "brenoprata10/nvim-highlight-colors",
}

---@type LazyPluginSpec
local spec_nvim_highlight_colors__astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local astromaps = opts.mappings

    local maps, map = require("cck.utils.config").get_astrocore_mapper()

    map("n", "<LEADER>uz", { copy = { "n", "<Leader>uz", source = astromaps } }) -- desc = "Toggle color highlight"

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

spec_nvim_highlight_colors.specs = {
  spec_nvim_highlight_colors__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_nvim_highlight_colors,
}
