local my = require "my"

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
    local maps, map = my.keymap.get_astrocore_mapper()

    map("n", "<LEADER>li", { copy = { "n", "<Leader>li", source = astromaps } }) -- desc = "LSP information"

    opts.mappings = my.tbl.merge("dDFn", opts.mappings, maps)
  end,
}

spec_nvim_lspconfig.specs = {
  spec_nvim_lspconfig__astrolsp,
}

---@type LazyPluginSpec[]
return {
  spec_nvim_lspconfig,
}
