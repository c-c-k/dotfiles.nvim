local my = require "my"
---@class my.lsp.null_ls
local M = {}

M.opts = {}

M.opts.core_integration = function() --
  my.autocmd.add_autocmd {
    group = my.autocmd.get_augroup("my.lsp_attach.null_ls", true),
    event = "LspAttach",
    desc = "LSP on_attach setup for null_ls/none_ls",
    callback = function(args) --
      my.keymap.load_km_group(my.config.keymaps.b_null_ls_, { args = args })
    end,
  }
end

M.keymaps = {}

M.keymaps.null_ls_information = { ---@type my.keymap.keymap_spec
  desc = "Null-ls information",
  rhs = "<Cmd>NullLsInfo<CR>",
}

return M
