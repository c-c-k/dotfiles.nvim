---@type LazyPluginSpec
local spec_nvim_lspconfig = {
  "neovim/nvim-lspconfig",
}

---@type LazyPluginSpec
local spec_nvim_lspconfig__astrolsp = {
  "AstroNvim/astrolsp",
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local astromaps = opts.mappings

    local maps, map = require("cck.utils.config").get_astrocore_mapper()

    map("n", "<LEADER>li", { copy = { "n", "<Leader>li", source = astromaps } }) -- desc = "LSP information"

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

spec_nvim_lspconfig.specs = {
  spec_nvim_lspconfig__astrolsp,
}

---@type LazyPluginSpec[]
return {
  spec_nvim_lspconfig,
}
