local my = require "my"

local M = {}

---@alias my.term.enum.start_pwd
---| '"BUF"' # Parent directory of the current buffer
---| '"ROOT"' # Root directory of the current buffer

--- Open a terminal.
---
--- Toggles off windows with fixed buffer [[see: my.win.get_on_buf_change_win_toggler]].
---
---@param start_in my.term.enum.start_pwd? # The initial directory to start the terminal in,
---if omitted the terminal is started in the currently active PWD.
function M.open_term(start_in)
  if start_in == "BUF" then
    my.path.cd("Local", false)
  elseif start_in == "ROOT" then
    my.path.cd("Local", true)
  end

  my.win.get_on_buf_change_win_toggler()()
  vim.cmd.terminal()
  vim.cmd.startinsert()
end

return M
