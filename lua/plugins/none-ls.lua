---@type LazyPluginSpec
local spec_none_ls_nvim = {
  "nvimtools/none-ls.nvim",
}

---@type LazyPluginSpec
local spec_none_ls_nvim__astrocore = {
  "AstroNvim/astrolsp",
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local astromaps = opts.mappings

    local maps, map = require("my.core.keymaps").get_astrocore_mapper()

    map("n", "<LEADER>lI", { copy = { "n", "<Leader>lI", source = astromaps } }) -- desc = "Null-ls information"

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

spec_none_ls_nvim.specs = {
  spec_none_ls_nvim__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_none_ls_nvim,
}
