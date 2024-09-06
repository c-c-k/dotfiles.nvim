-- ===========================================
-- ASTRONVIM ASTROLSP (COMMANDS, AUTOCOMMANDS)
-- ===========================================

-- repo url: <https://github.com/AstroNvim/astrolsp>
-- nvim help: `:help astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      -- -- Configure buffer local auto commands to add when attaching a language server
      -- autocmds = {
      --   -- first key is the `augroup` (:h augroup)
      --   lsp_document_highlight = {
      --     -- condition to create/delete auto command group
      --     -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
      --     -- condition will be resolved for each client on each execution and if it ever fails for all clients,
      --     -- the auto commands will be deleted for that buffer
      --     cond = "textDocument/documentHighlight",
      --     -- list of auto commands to set
      --     {
      --       -- events to trigger
      --       event = { "CursorHold", "CursorHoldI" },
      --       -- the rest of the autocmd options (:h nvim_create_autocmd)
      --       desc = "Document Highlighting",
      --       callback = function() vim.lsp.buf.document_highlight() end,
      --     },
      --     {
      --       event = { "CursorMoved", "CursorMovedI", "BufLeave" },
      --       desc = "Document Highlighting Clear",
      --       callback = function() vim.lsp.buf.clear_references() end,
      --     },
      --   },
      -- },

      -- -- Configure buffer local user commands to add when attaching a language server
      -- commands = {
      --   Format = {
      --     function() vim.lsp.buf.format() end,
      --     -- condition to create the user command
      --     -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
      --     cond = "textDocument/formatting",
      --     -- the rest of the user command options (:h nvim_create_user_command)
      --     desc = "Format file with LSP",
      --   },
      -- },
    } --[[@as AstroLSPOpts]])
  end,
}
