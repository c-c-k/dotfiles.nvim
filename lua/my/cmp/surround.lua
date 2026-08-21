---@class MyCmpSurround
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_surround
end

M._spec_surround = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["nvim-surround"],
    lazy = true,
    event = "VeryLazy",
    init = function() --
      vim.api.nvim_set_var("nvim_surround_no_mappings", true)
    end,
    config = function(_, opts)
      require("nvim-surround").setup(opts)

      my.keymap.queue_km_group_load(my.config.keymaps.g_surround)
    end,
  }
  return spec
end

M.keymaps = {}

M.keymaps.add_around_line = { ---@type MyKeymapKeymapSpec
  desc = "Surround (line)",
  rhs = "<Plug>(nvim-surround-normal-cur)",
}
M.keymaps.add_around_line_with_nl = { ---@type MyKeymapKeymapSpec
  desc = "Surround (line Add NL)",
  rhs = "<Plug>(nvim-surround-normal-cur-line)",
}
M.keymaps.add_i_ = { ---@type MyKeymapKeymapSpec
  desc = "Surround",
  rhs = "<Plug>(nvim-surround-insert)",
}
M.keymaps.add_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Surround",
  rhs = "<Plug>(nvim-surround-normal)",
}
M.keymaps.add_with_nl = { ---@type MyKeymapKeymapSpec
  desc = "Surround (Add NL)",
  rhs = "<Plug>(nvim-surround-normal-line)",
}
M.keymaps.add_with_nl_i_ = { ---@type MyKeymapKeymapSpec
  desc = "Surround (Add NL)",
  rhs = "<Plug>(nvim-surround-insert-line)",
}
M.keymaps.add_with_nl_x_ = { ---@type MyKeymapKeymapSpec
  desc = "Surround (Add NL)",
  rhs = "<Plug>(nvim-surround-visual-line)",
}
M.keymaps.add_x_ = { ---@type MyKeymapKeymapSpec
  desc = "Surround",
  rhs = "<Plug>(nvim-surround-visual)",
}
M.keymaps.change = { ---@type MyKeymapKeymapSpec
  desc = "Surround (change)",
  rhs = "<Plug>(nvim-surround-change)",
}
M.keymaps.change_line = { ---@type MyKeymapKeymapSpec
  desc = "Surround (change-line)",
  rhs = "<Plug>(nvim-surround-change-line)",
}
M.keymaps.delete = { ---@type MyKeymapKeymapSpec
  desc = "Surround (delete)",
  rhs = "<Plug>(nvim-surround-delete)",
}

return M
