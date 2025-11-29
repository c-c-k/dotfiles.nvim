local M = {}

---@alias my.win.func.win_toggle fun(): nil

--- Opens a buffer in the current window after executing a function.
-- This function is designed to work with Neovim commands or functions that
-- typically open a buffer in a new window. It executes the provided function,
-- then transfers the opened buffer to the current window and closes the new
-- window.
--
-- If the provided function doesn't open a new window, an optional error message
-- can be displayed.
--
-- @param func function The function to execute, which is expected to open a new window.
-- @param[opt] err_msg string An optional error message to display if no new window is opened.
function M.open_in_current_win(func, err_msg)
  assert(type(func) == "function", "Invalid argument: 'func' must be a function")

  -- Save current window and buffer
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_get_current_buf()

  -- Execute the function
  func()

  -- Get the new window and its buffer
  local new_win = vim.api.nvim_get_current_win()
  local new_buf = vim.api.nvim_get_current_buf()

  -- Check if a new window was opened and it's different from the original
  if new_win == current_win or new_buf == current_buf then
    vim.notify(err_msg or "No new window or buffer opened", vim.log.levels.WARN)
    return
  end

  -- Move the buffer to the original window
  vim.api.nvim_win_set_buf(current_win, new_buf)
  vim.api.nvim_set_current_win(current_win) -- Ensure focus is back on original window

  -- Close the new window
  vim.api.nvim_win_close(new_win, true)
end

--- Opens a buffer from a command in the current window.
-- This function is a wrapper around `open_in_current_win`, specifically
-- designed for Neovim commands that open new windows.
--
-- @param command string The Neovim command to execute (e.g., ":split filename").
function M.open_cmd_in_current_win(command)
  M.open_in_current_win(function() vim.cmd(command) end, "No new window opened by command: " .. command)
end

--- Opens a utility buffer in the current window based on provided options.
-- This function offers a flexible way to open and interact with utility buffers (e.g., help, manpages, git) within the current window.
--
-- @param opts table The options table for customization:
--  - init: string or function | An optional command string or function to initialize the buffer (opened conditionally).
--  - ft: string | An optional filetype to check before initialization (if the current buffer has this type, initialization is skipped).
--  - cond: function | An optional function returning a boolean to determine whether to initialize the buffer.
--  - prompt_cmd: string | An optional command string to execute after initialization (using `nvim_feedkeys` for user interaction).
--  - post: string or function | An optional command string or function to execute after initialization (executed directly).
function M.open_util_in_current_win(opts)
  -- Initialize the buffer if conditions are met
  if opts.init then
    local do_open = true
    if opts.ft then
      local buf = vim.api.nvim_get_current_buf()
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
      do_open = filetype ~= opts.ft
    end
    if do_open and opts.cond then do_open = opts.cond() end
    if do_open then
      if type(opts.init) == "string" then
        M.open_cmd_in_current_win(opts.init)
      elseif type(opts.init) == "function" then
        M.open_in_current_win(opts.init)
      else
        error "`init` parameter must be string or function"
      end
    end
  end

  -- Execute post-initialization actions
  if opts.prompt_cmd and opts.post then
    error "Only one of the `prompt_cmd` and `post` parameters can be supplied"
  elseif opts.prompt_cmd then
    vim.api.nvim_feedkeys(opts.prompt_cmd, "n", false)
  elseif opts.post then
    if type(opts.post) == "string" then
      vim.cmd(opts.post)
    elseif type(opts.post) == "function" then
      opts.post()
    else
      error "`post` parameter must be string or function"
    end
  end
end

function M.close_win()
  if vim.b.my_close_buf_win then
    vim.b.my_close_buf_win()
    return
  end
  vim.api.nvim_win_close(0, false)
end

--- Syncs current window (write+read+preserve folds)
---
--- Uses `vim.b.my_sync_buf_win` if exists.
function M.sync_current_win()
  if vim.b.my_sync_buf_win then
    vim.b.my_sync_buf_win()
    return
  end
  if vim.o.buftype ~= "" or vim.fn.win_gettype() ~= "" then --
    return
  end

  local prev_viewoptions = vim.opt.viewoptions
  local view_file = ("/dev/shm/view_%s.vim"):format(os.date "%s")
  vim.opt.viewoptions = { "cursor", "folds" }
  vim.cmd.mkview(view_file)
  vim.cmd.write()
  vim.cmd.edit()
  vim.cmd.source(view_file)
  os.remove(view_file)
  vim.opt.viewoptions = prev_viewoptions
end

--- Get window toggler for buffer changing actions.
---
--- The returned function toggles windows that have a buffer with:
---   * `vim.b.my_do_toggle_win` set.
---   * `vim.b.my_is_toggle_win_before_buf_change` set.
--- The returned function uses `vim.b.my_do_toggle_win` to toggle the windows.
---
--- This is intended for situations like e.g. using a Mini.Files popup window
--- to pick a directory and then executing a general purpose keymap to open
--- A terminal in the current buffer directory.
---@return my.win.func.win_toggle # Function to toggle stack of buffer fixed windows.
function M.get_on_buf_change_win_toggler()
  local did_toggle = false
  local toggle_funcs = {}
  return function()
    if did_toggle then
      while #toggle_funcs > 0 do
        table.remove(toggle_funcs)()
      end
      did_toggle = false
    else
      did_toggle = true
      while vim.b.my_do_toggle_win and vim.b.my_is_toggle_win_before_buf_change do
        table.insert(toggle_funcs, vim.b.my_do_toggle_win)
        toggle_funcs[#toggle_funcs]()
      end
    end
  end
end

return M
