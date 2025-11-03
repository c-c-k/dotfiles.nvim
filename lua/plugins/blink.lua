---@type LazyPluginSpec
local spec_blink_cmp = {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then return cmp.accept() end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = {
        "snippet_backward",
        "fallback",
      },
    },
  },
}

---@type LazyPluginSpec
local spec_blink_cmp__astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local astromaps = opts.mappings

    local maps, map = require("cck.utils.config").get_astrocore_mapper()

    map("n", "<LEADER>uc", { copy = { "n", "<Leader>uc", source = astromaps } }) -- desc = "Toggle autocompletion (buffer)"
    map("n", "<LEADER>uC", { copy = { "n", "<Leader>uC", source = astromaps } }) -- desc = "Toggle autocompletion (global)"

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

spec_blink_cmp.specs = {
  spec_blink_cmp__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_blink_cmp,
}
