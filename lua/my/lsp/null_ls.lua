---@class MyLspNullLs
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_none_ls
end

M._spec_none_ls = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["none-ls"],
    lazy = false,
    config = function(_, opts)
      local null_ls = require "null-ls"
      local source_funcs = my.config.null_ls_sources
      local sources = {}

      for _, source_func in pairs(source_funcs) do
        sources[#sources + 1] = source_func(null_ls)
      end

      opts = my.tbl.merge("dDkL", opts, { sources = sources })

      null_ls.setup(opts)

      M._autocmd_lsp_attach()
    end,
    dependencies = { make_lzspec { source = plugins["plenary.nvim"], optional = false } },
  }
  return spec
end

M._autocmd_lsp_attach = function()
  my.autocmd.add_autocmd {
    group = "my.lsp_attach.null_ls",
    event = "LspAttach",
    desc = "LSP on_attach setup for null_ls/none_ls",
    callback = function(ev) --
      my.keymap.load_km_group(my.config.keymaps.b_null_ls_, { ev = ev })
    end,
  }
end

M.keymaps = {}

M.keymaps.null_ls_information = { ---@type MyKeymapKeymapSpec
  desc = "Null-ls information",
  rhs = "<Cmd>checkhealth null-ls<CR>",
}

return M
