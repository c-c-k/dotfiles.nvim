-- =================================
-- ASTRONVIM ASTROLSP (KEY MAPPINGS)
-- =================================

-- repo url: <https://github.com/AstroNvim/astrolsp>
-- nvim help: `:help astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local astromaps = opts.mappings
    local maps, map = require("cck.utils.config").get_astrocore_mapper()

    -- Configuration of mappings added when attaching a language server during the core `on_attach` function
    -- A `cond` key can be added to the mapping options which can either be:
    --  * A string (e.g. `cond = "textDocument/declaration"`) of a language server capability.
    --  * A function (sig: `cond = function(client, bufnr) ... end`)  that returns a boolean of whether or not the mapping is added.

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}
