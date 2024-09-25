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

    map({ "n", "x" }, "<LEADER>la", { copy = { "n", "<Leader>la", source = astromaps } }) -- desc = "LSP code action"
    map("n", "<LEADER>lA", { copy = { "n", "<Leader>lA", source = astromaps } }) -- desc = "LSP source action"

    map("n", "<LEADER>ll", { copy = { "n", "<Leader>ll", source = astromaps } }) -- desc = "LSP CodeLens refresh"
    map("n", "<LEADER>lL", { copy = { "n", "<Leader>lL", source = astromaps } }) -- desc = "LSP CodeLens run"
    map("n", "<LEADER>uL", { copy = { "n", "<Leader>uL", source = astromaps } }) -- desc = "Toggle CodeLens"

    map({ "n", "v" }, "<LEADER>lf", { copy = { "n", "<Leader>lf", source = astromaps } }) -- desc = "Format buffer"
    map("n", "<LEADER>uf", { copy = { "n", "<Leader>uf", source = astromaps } }) -- desc = "Toggle autoformatting (buffer)"
    map("n", "<LEADER>uF", { copy = { "n", "<Leader>uF", source = astromaps } }) -- desc = "Toggle autoformatting (global)"

    map("n", "<LEADER>u?", { copy = { "n", "<Leader>u?", source = astromaps } }) -- desc = "Toggle automatic signature help"

    map("n", "<LEADER>uh", { copy = { "n", "<Leader>uh", source = astromaps } }) -- desc = "Toggle LSP inlay hints (buffer)"
    map("n", "<LEADER>uH", { copy = { "n", "<Leader>uH", source = astromaps } }) -- desc = "Toggle LSP inlay hints (global)"

    map("n", "<LEADER>lR", { copy = { "n", "<Leader>lR", source = astromaps, desc = "List references" } })

    map("n", "<LEADER>lr", { copy = { "n", "<Leader>lr", source = astromaps } }) -- desc = "Rename current symbol"

    map("n", "<LEADER>lh", { copy = { "n", "<Leader>lh", source = astromaps } }) -- desc = "Signature help"

    map("n", "<LEADER>lG", { copy = { "n", "<Leader>lG", source = astromaps, desc = "List workspace symbols" } })

    map("n", "<LEADER>uY", { copy = { "n", "<Leader>uY", source = astromaps } }) -- desc = "Toggle LSP semantic highlight (buffer)"

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}
