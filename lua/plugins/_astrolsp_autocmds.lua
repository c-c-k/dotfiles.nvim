local my = require "my"

---@type LazyPluginSpec
local spec_astrolsp = {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    return my.tbl.merge("dDFn", opts, {
      commands = {
        -- PLACEHOLDER
      },
      autocmds = {
        lsp_document_highlight = {
          cond = "textDocument/documentHighlight",
          {
            event = { "CursorHold", "CursorHoldI" },
            desc = "Document Highlighting",
            callback = function() vim.lsp.buf.document_highlight() end,
          },
          {
            event = { "CursorMoved", "CursorMovedI", "BufLeave" },
            desc = "Document Highlighting Clear",
            callback = function() vim.lsp.buf.clear_references() end,
          },
        },
      },
    } --[[@as AstroLSPOpts]])
  end,
}

---@type LazyPluginSpec[]
return {
  spec_astrolsp,
}
