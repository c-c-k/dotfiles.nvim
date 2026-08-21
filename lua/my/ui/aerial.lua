---@class MyUiAerial
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_aerial
end

M._spec_aerial = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["aerial.nvim"],
    opts = {
      filter_kind = false,
      backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
      nav = {
        win_opts = {
          winblend = 0,
        },
      },
    },
    config = function(_, opts)
      require("aerial").setup(opts)

      my.keymap.queue_km_group_load(my.config.keymaps.g_aerial__)
    end,
  }
  return spec
end

M.keymaps = {}

M.keymaps.nav = { ---@type MyKeymapKeymapSpec
  desc = "Symbols outline",
  rhs = function()
    -- vim.b.aerial_backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" }
    require("aerial").nav_toggle()
  end,
}

M.keymaps.symbols_outline = { ---@type MyKeymapKeymapSpec
  desc = "Symbols outline",
  rhs = function()
    -- vim.b.aerial_backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" }
    require("aerial").toggle()
  end,
}

return M
