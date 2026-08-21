---@class MyTerm
local M = {}
M.init = { no_init = true, recurse = false } ---@type MyModuleInit

local my = require "my"

--- Open a terminal.
---
--- Toggles off buffer fixed windows [[see: my.win.get_on_buf_change_win_toggler]].
---
---@param start_in "BUF" | "ROOT" | string? # The initial directory to start the terminal in,
---if omitted the terminal is started in the currently active PWD.
M.open_term = function(start_in)
  if start_in == "BUF" then
    my.fs.cd.cd("Local", false)
  elseif start_in == "ROOT" then
    my.fs.cd.cd("Local", true)
  elseif type(start_in) == "string" then
    my.fs.cd.cd("Local", false, start_in)
  end

  local close_buf_fixed_win = my.win.get_buf_fixed_win_toggler(true)
  close_buf_fixed_win()

  vim.cmd.terminal()
  vim.cmd.startinsert()
end

M.keymaps = {}

M.keymaps.exec_in_shell = { ---@type MyKeymapKeymapSpec
  desc = "Exec in shell",
  rhs = ":!",
}
M.keymaps.exec_single_normal_command = { ---@type MyKeymapKeymapSpec
  desc = "do norm cmd",
  rhs = "<C-\\><C-O>",
}
M.keymaps.filter_in_shell = { ---@type MyKeymapKeymapSpec
  desc = "Filter in shell",
  rhs = ":'<,'>!",
}
M.keymaps.open_term_buf = { ---@type MyKeymapKeymapSpec
  desc = "Open tErminal (buffer dir)",
  rhs = function() return M.open_term "BUF" end,
}
M.keymaps.open_term_exec_cmd = { ---@type MyKeymapKeymapSpec
  desc = "Open tErminal (exec cmd)",
  rhs = ":term ",
}
M.keymaps.open_term_pwd = { ---@type MyKeymapKeymapSpec
  desc = "Open tErminal (PWD)",
  rhs = function() return M.open_term() end,
}
M.keymaps.open_term_root = { ---@type MyKeymapKeymapSpec
  desc = "Open tErminal (root dir)",
  rhs = function() return M.open_term "ROOT" end,
}
M.keymaps.read_from_shell = { ---@type MyKeymapKeymapSpec
  desc = "read from shell",
  rhs = ":read !",
}
M.keymaps.write_to_shell = { ---@type MyKeymapKeymapSpec
  desc = "write to shell",
  rhs = ":write !",
}

return M
