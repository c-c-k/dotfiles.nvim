local my = require "my"
---@class my.lsp.lspconfig
local M = {}

M.opts = {}

M.opts.core_integration = function()
  my.autocmd.add_autocmd {
    group = my.autocmd.get_augroup("my.lsp_attach.lspconfig", true),
    event = "LspAttach",
    desc = "LSP on_attach setup for nvim-lspconfig",
    callback = function(args) --
      my.keymap.load_km_group(my.config.keymaps.b_lspconfg, { args = args })
    end,
  }
end

M.keymaps = {}

M.keymaps.lsp_information = { ---@type my.keymap.keymap_spec
  desc = "LSP information",
  rhs = "<Cmd>LspInfo<CR>",
}

return M
