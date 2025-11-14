---@type LazyPluginSpec
local spec_vim_illuminate = {
  "RRethy/vim-illuminate",
}

---@type LazyPluginSpec
local spec_vim_illuminate__astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local astromaps = opts.mappings

    local maps, map = require("my.core.keymaps").get_astrocore_mapper()

    map("n", "<LEADER>ur", { copy = { "n", "<Leader>ur", source = astromaps } }) -- desc = "Toggle reference highlighting (buffer)"
    map("n", "<LEADER>uR", { copy = { "n", "<Leader>uR", source = astromaps } }) -- desc = "Toggle reference highlighting (global)"

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

spec_vim_illuminate.specs = {
  spec_vim_illuminate__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_vim_illuminate,
}
