-- =================================
-- ASTRONVIM ASTROLSP (KEY MAPPINGS)
-- =================================

-- repo url: <https://github.com/AstroNvim/astrolsp>
-- nvim help: `:help astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@param opts AstroLSPOpts
  -- opts = function(_, opts)
  --   local astrocore = require "astrocore"
  --   local maps, map = require("cck.utils.config").get_astrocore_mapper()
  --
  --   -- Configuration of mappings added when attaching a language server during the core `on_attach` function
  --   -- A `cond` key can be added to the mapping options which can either be a string of a language server capability or a function with `client` and `bufnr` parameters that returns a boolean of whether or not the mapping is added.
  --
  --   -- a binding with no condition and therefore is always added
  --   map("n", "gl", function() vim.diagnostic.open_float() end, {
  --     desc = "Hover diagnostics" })
  --   -- condition for only server with declaration capabilities
  --   map("n", "gD", function() vim.lsp.buf.declaration() end, {
  --     desc = "Declaration of current symbol",
  --     cond = "textDocument/declaration", })
  --   -- condition with a full function with `client` and `bufnr`
  --   map("n", "<LEADER>uY", function() require("astrolsp.toggles").buffer_semantic_tokens() end, {
  --     desc = "Toggle LSP semantic highlight (buffer)",
  --     cond = function(client, bufnr)
  --       return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens
  --     end })
  --
  --   opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  -- end,
}
