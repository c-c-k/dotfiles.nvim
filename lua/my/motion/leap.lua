---@class MyMotionLeap
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_leap
end

M._spec_leap = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["leap.nvim"],
    opts = {
      safe_labels = "",
      labels = [==[fnjklhodwembuiyvrgtasqpcxz;'/[]FNJKLHODWEMBUIYVRGTASQPCXZ:"?{}]==],
      keys = {
        next_target = "<TAB>",
        prev_target = "<S-TAB>",
        next_group = "<SPACE>",
        prev_group = "BACKSPACE",
      },
    },
    config = function(_, opts)
      require("leap").setup(opts)

      my.keymap.queue_km_group_load(my.config.keymaps.g_leap____)
    end,
    dependencies = make_lzspec(plugins["vim-repeat"]),
  }
  return spec
end

M.keymaps = {}

M.keymaps.esc_and_remote_action = { ---@type MyKeymapKeymapSpec
  desc = "Leap remote action",
  rhs = function()
    my.keymap.force_normal_mode()
    return require("leap.remote").action()
  end,
}
M.keymaps.jump_backward_i_ = { ---@type MyKeymapKeymapSpec
  desc = "Leap backward",
  rhs = my.keymap.ESC .. "<Plug>(leap-backward)",
}
M.keymaps.jump_backward_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Leap backward",
  rhs = "<Plug>(leap-backward)",
}
M.keymaps.jump_backward_till_i_ = { ---@type MyKeymapKeymapSpec
  desc = "Leap backward till",
  rhs = my.keymap.ESC .. "<Plug>(leap-backward-till)",
}
M.keymaps.jump_backward_till_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Leap backward till",
  rhs = "<Plug>(leap-backward-till)",
}
M.keymaps.jump_forward_i_ = { ---@type MyKeymapKeymapSpec
  desc = "Leap forward",
  rhs = my.keymap.ESC .. "<Plug>(leap-forward)",
}
M.keymaps.jump_forward_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Leap forward",
  rhs = "<Plug>(leap-forward)",
}
M.keymaps.jump_forward_till_i_ = { ---@type MyKeymapKeymapSpec
  desc = "Leap forward till",
  rhs = my.keymap.ESC .. "<Plug>(leap-forward-till)",
}
M.keymaps.jump_forward_till_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Leap forward till",
  rhs = "<Plug>(leap-forward-till)",
}
M.keymaps.jump_from_window = { ---@type MyKeymapKeymapSpec
  desc = "Leap from window",
  rhs = my.keymap.ESC .. "<Plug>(leap-from-window)",
}
M.keymaps.jump_in_window_i_ = { ---@type MyKeymapKeymapSpec
  desc = "Leap in window",
  rhs = my.keymap.ESC .. "<Plug>(leap)",
}
M.keymaps.jump_in_window_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Leap in window",
  rhs = "<Plug>(leap)",
}
M.keymaps.jump_omniwhere = { ---@type MyKeymapKeymapSpec
  desc = "Leap omniwhere",
  rhs = my.keymap.ESC .. "<Plug>(leap-anywhere)",
}

return M
