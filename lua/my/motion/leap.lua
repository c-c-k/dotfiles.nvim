local my = require "my"
---@class my.motion.leap
local M = {}

M.opts = {}
M.opts.general = function(_, opts) ---@cast opts MyNoOptsSpec
  return my.tbl.merge_dicts_into_last(opts, {
    safe_labels = "",
    labels = [==[fnjklhodwembuyvrgtaqpcxz;'/[]FNJKLHODWEMBUYVRGTAQPCXZ:"?{}]==],
    keys = {
      next_target = { "s", "i" },
      prev_target = { "S", "I" },
      next_group = "<SPACE>",
      prev_group = "BACKSPACE",
    },
  } --[[@as MyNoOptsSpec]])
end
M.opts.core_integration = function() --
  -- -- https://github.com/ggandor/leap.nvim/issues/70#issuecomment-1521177534
  -- local aug_my_leap_cursor_fix = mycore.get_augroup {
  --   name = "aug_my_leap_cursor_fix",
  --   clear = true,
  -- }
  -- mycore.add_autocmd {
  --   group = aug_my_leap_cursor_fix,
  --   event = "User",
  --   pattern = "LeapEnter",
  --   callback = function()
  --     vim.cmd.hi("Cursor", "blend=100")
  --     vim.opt.guicursor:append { "a:Cursor/lCursor" }
  --   end,
  -- }
  -- mycore.add_autocmd {
  --   group = aug_my_leap_cursor_fix,
  --   event = "User",
  --   pattern = "LeapLeave",
  --   callback = function()
  --     vim.cmd.hi("Cursor", "blend=0")
  --     vim.opt.guicursor:remove { "a:Cursor/lCursor" }
  --   end,
  -- }

  my.keymap.queue_km_group_load(my.config.keymaps.g_leap____)
end

M.keymaps = {}

M.keymaps.esc_and_remote_action = { ---@type my.keymap.keymap_spec
  desc = "Leap remote action",
  rhs = function()
    my.keymap.force_normal_mode()
    return require("leap.remote").action()
  end,
}
M.keymaps.jump_backward_i_ = { ---@type my.keymap.keymap_spec
  desc = "Leap backward",
  rhs = my.keymap.ESC .. "<Plug>(leap-backward)",
}
M.keymaps.jump_backward_n_ = { ---@type my.keymap.keymap_spec
  desc = "Leap backward",
  rhs = "<Plug>(leap-backward)",
}
M.keymaps.jump_backward_till_i_ = { ---@type my.keymap.keymap_spec
  desc = "Leap backward till",
  rhs = my.keymap.ESC .. "<Plug>(leap-backward-till)",
}
M.keymaps.jump_backward_till_n_ = { ---@type my.keymap.keymap_spec
  desc = "Leap backward till",
  rhs = "<Plug>(leap-backward-till)",
}
M.keymaps.jump_forward_i_ = { ---@type my.keymap.keymap_spec
  desc = "Leap forward",
  rhs = my.keymap.ESC .. "<Plug>(leap-forward)",
}
M.keymaps.jump_forward_n_ = { ---@type my.keymap.keymap_spec
  desc = "Leap forward",
  rhs = "<Plug>(leap-forward)",
}
M.keymaps.jump_forward_till_i_ = { ---@type my.keymap.keymap_spec
  desc = "Leap forward till",
  rhs = my.keymap.ESC .. "<Plug>(leap-forward-till)",
}
M.keymaps.jump_forward_till_n_ = { ---@type my.keymap.keymap_spec
  desc = "Leap forward till",
  rhs = "<Plug>(leap-forward-till)",
}
M.keymaps.jump_from_window = { ---@type my.keymap.keymap_spec
  desc = "Leap from window",
  rhs = my.keymap.ESC .. "<Plug>(leap-from-window)",
}
M.keymaps.jump_in_window_i_ = { ---@type my.keymap.keymap_spec
  desc = "Leap in window",
  rhs = "my.keymap.ESC .. <Plug>(leap)",
}
M.keymaps.jump_in_window_n_ = { ---@type my.keymap.keymap_spec
  desc = "Leap in window",
  rhs = "<Plug>(leap)",
}
M.keymaps.jump_omniwhere = { ---@type my.keymap.keymap_spec
  desc = "Leap omniwhere",
  rhs = my.keymap.ESC .. "<Plug>(leap-anywhere)",
}

return M
