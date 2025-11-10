---@type LazyPluginSpec
local spec_resession_nvim = {
  "stevearc/resession.nvim",
  -- MEMO: Lazy and plugin opts config inherited from AstroNvim defaults.
}

---@type LazyPluginSpec
local spec_resession_nvim__astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local astromaps = opts.mappings
    local maps, map = require("cck.core.keymaps").get_astrocore_mapper()

    map("n", "<LEADER>qsl", { copy = { "n", "<Leader>Sl", source = astromaps } }) -- desc = "Load last session"
    map("n", "<LEADER>qsL", { copy = { "n", "<Leader>S.", source = astromaps } }) -- desc = "Load current dirsession"
    map("n", "<LEADER>qss", { copy = { "n", "<Leader>Ss", source = astromaps } }) -- desc = "Save this session"
    map("n", "<LEADER>qsS", { copy = { "n", "<Leader>SS", source = astromaps } }) -- desc = "Save this dirsession"
    map("n", "<LEADER>qst", { copy = { "n", "<Leader>St", source = astromaps } }) -- desc = "Save this tab's session"
    map("n", "<LEADER>qsx", { copy = { "n", "<Leader>Sd", source = astromaps } }) -- desc = "Delete a session"
    map("n", "<LEADER>qsX", { copy = { "n", "<Leader>SD", source = astromaps } }) -- desc = "Delete a dirsession"
    map("n", "<LEADER>fs", { copy = { "n", "<Leader>Sf", source = astromaps, desc = "find a session" } })
    map("n", "<LEADER>qsf", { copy = { "n", "<LEADER>fs" } })
    map("n", "<LEADER>fS", { copy = { "n", "<Leader>SF", source = astromaps, desc = "Find a dirsession" } })
    map("n", "<LEADER>qsF", { copy = { "n", "<LEADER>fS" } })

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

spec_resession_nvim.specs = {
  spec_resession_nvim__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_resession_nvim,
}
