local my = require "my"
---@class my.term
local M = {}

--- Open a terminal.
---
--- Toggles off windows with fixed buffer [[see: my.win.get_on_buf_change_win_toggler]].
---
---@param start_in "BUF" | "ROOT" | string? # The initial directory to start the terminal in,
---if omitted the terminal is started in the currently active PWD.
M.open_term = function(start_in)
  if start_in == "BUF" then
    my.path.cd("Local", false)
  elseif start_in == "ROOT" then
    my.path.cd("Local", true)
  elseif type(start_in) == "string" then
    my.path.cd("Local", false, start_in)
  end

  my.win.get_on_buf_change_win_toggler()()
  vim.cmd.terminal()
  vim.cmd.startinsert()
end

M.keymaps = {}

M.keymaps.exec_in_shell = { ---@type my.keymap.keymap_spec
  desc = "Exec in shell",
  rhs = ":!",
}
M.keymaps.exec_single_normal_command = { ---@type my.keymap.keymap_spec
  desc = "do norm cmd",
  rhs = "<C-\\><C-O>",
}
M.keymaps.filter_in_shell = { ---@type my.keymap.keymap_spec
  desc = "Filter in shell",
  rhs = ":'<,'>!",
}
M.keymaps.open_term_buf = { ---@type my.keymap.keymap_spec
  desc = "Open tErminal (buffer dir)",
  rhs = function() return M.open_term "BUF" end,
}
M.keymaps.open_term_exec_cmd = { ---@type my.keymap.keymap_spec
  desc = "Open tErminal (exec cmd)",
  rhs = ":term ",
}
M.keymaps.open_term_pwd = { ---@type my.keymap.keymap_spec
  desc = "Open tErminal (PWD)",
  rhs = function() return M.open_term() end,
}
M.keymaps.open_term_root = { ---@type my.keymap.keymap_spec
  desc = "Open tErminal (root dir)",
  rhs = function() return M.open_term "ROOT" end,
}
M.keymaps.read_from_shell = { ---@type my.keymap.keymap_spec
  desc = "read from shell",
  rhs = ":read !",
}
M.keymaps.write_to_shell = { ---@type my.keymap.keymap_spec
  desc = "write to shell",
  rhs = ":write !",
}

return M
