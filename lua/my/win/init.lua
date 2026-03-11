local my = require "my"
---@class my.win: my.win._submodules
local M = {}

M.winbar_expr = function() --
  return vim.api.nvim_buf_get_name(0)
end

M.close_win = function()
  if my.b[0].lose_buf_win then
    my.b[0].lose_buf_win()
    return
  end
  vim.api.nvim_win_close(0, false)
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
---@return my.win.get_on_buf_change_win_toggler.ret # Function to toggle stack of buffer fixed windows.
M.get_on_buf_change_win_toggler = function()
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

--- Opens a buffer from a command in the current window.
-- *\(.*\)\n\(.*\n\)\?---.param silent.*\nfunction M\.\(\w\+\)(\(.*\)silent)\n\(\%\(.*\n\)\{-\}\)end\nahis function is a wrapper around `open_in_current_win`, specifically
-- designed for Neovim commands that open new windows.
--
-- @param command string The Neovim command to execute (e.g., ":split filename").
M.open_cmd_in_current_win = function(command)
  M.open_in_current_win(function() vim.cmd(command) end, "No new window opened by command: " .. command)
end

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
M.open_in_current_win = function(func, err_msg)
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

--- Opens a utility buffer in the current window based on provided options.
-- *\(.*\)\n\(.*\n\)\?---.param silent.*\nfunction M\.\(\w\+\)(\(.*\)silent)\n\(\%\(.*\n\)\{-\}\)end\nhis function offers a flexible way to open and interact with utility buffers (e.g., help, manpages, git) within the current window.
--
-- @param opts table The options table for customization:
--  - init: string or function | An optional command string or function to initialize the buffer (opened conditionally).
--  - ft: string | An optional filetype to check before initialization (if the current buffer has this type, initialization is skipped).
--  - cond: function | An optional function returning a boolean to determine whether to initialize the buffer.
--  - prompt_cmd: string | An optional command string to execute after initialization (using `nvim_feedkeys` for user interaction).
--  - post: string or function | An optional command string or function to execute after initialization (executed directly).
M.open_util_in_current_win = function(opts)
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

--- Syncs current window (write+read+preserve folds)
---
--- Uses `vim.b.my_sync_buf_win` if exists.
M.sync_current_win = function()
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

M.keymaps = {}

M.keymaps.close_current = { ---@type my.keymap.keymap_spec
  desc = "Close current window",
  rhs = "<CMD>close<CR>",
}
M.keymaps.close_location_list = { ---@type my.keymap.keymap_spec
  desc = "Close location list",
  rhs = "<CMD>lclose<CR>",
}
M.keymaps.close_quickfix_list = { ---@type my.keymap.keymap_spec
  desc = "Close quickfix list",
  rhs = "<CMD>cclose<CR>",
}
M.keymaps.grow_win_x = { ---@type my.keymap.keymap_spec
  desc = "resize win X+",
  rhs = "<CMD>vertical resize +<CR>",
}
M.keymaps.grow_win_y = { ---@type my.keymap.keymap_spec
  desc = "resize win Y+",
  rhs = "<CMD>resize -<CR>",
}
M.keymaps.move_down = { ---@type my.keymap.keymap_spec
  desc = "Move window (down)",
  rhs = "<CMD>wincmd J<CR>",
}
M.keymaps.move_left = { ---@type my.keymap.keymap_spec
  desc = "Move window (left)",
  rhs = "<CMD>wincmd H<CR>",
}
M.keymaps.move_right = { ---@type my.keymap.keymap_spec
  desc = "Move window (right)",
  rhs = "<CMD>wincmd L<CR>",
}
M.keymaps.move_to_tab_next = { ---@type my.keymap.keymap_spec
  desc = "Move window (tab-next)",
  rhs = "<CMD>wincmd T<CR>",
}
M.keymaps.move_to_tab_previous = { ---@type my.keymap.keymap_spec
  desc = "Move window (tab-previous)",
  rhs = "<CMD>wincmd T|-tabmove<CR>",
}
M.keymaps.move_up = { ---@type my.keymap.keymap_spec
  desc = "Move window (up)",
  rhs = "<CMD>wincmd K<CR>",
}
M.keymaps.navigate_down = { ---@type my.keymap.keymap_spec
  desc = "Go to window (down)",
  rhs = my.keymap.ESC .. "<CMD>wincmd j<CR>",
}
M.keymaps.navigate_left = { ---@type my.keymap.keymap_spec
  desc = "Go to window (left)",
  rhs = my.keymap.ESC .. "<CMD>wincmd h<CR>",
}
M.keymaps.navigate_right = { ---@type my.keymap.keymap_spec
  desc = "Go to window (right)",
  rhs = my.keymap.ESC .. "<CMD>wincmd l<CR>",
}
M.keymaps.navigate_up = { ---@type my.keymap.keymap_spec
  desc = "Go to window (up)",
  rhs = my.keymap.ESC .. "<CMD>wincmd k<CR>",
}
M.keymaps.open_cmd_win = { ---@type my.keymap.keymap_spec
  desc = "win open (cmd)",
  rhs = "q:",
}
M.keymaps.open_location_list = { ---@type my.keymap.keymap_spec
  desc = "Open location list",
  rhs = "<CMD>lopen<CR>",
}
M.keymaps.open_new_down_inner = { ---@type my.keymap.keymap_spec
  desc = "Open new window (down-inner)",
  rhs = "<CMD>rightbelow new<CR>",
}
M.keymaps.open_new_down_outer = { ---@type my.keymap.keymap_spec
  desc = "Open new window (down-outer)",
  rhs = "<CMD>botright new<CR>",
}
M.keymaps.open_new_left_inner = { ---@type my.keymap.keymap_spec
  desc = "Open new window (left-inner)",
  rhs = "<CMD>leftabove vertical new<CR>",
}
M.keymaps.open_new_left_outer = { ---@type my.keymap.keymap_spec
  desc = "Open new window (left-outer)",
  rhs = "<CMD>topleft vertical new<CR>",
}
M.keymaps.open_new_right_inner = { ---@type my.keymap.keymap_spec
  desc = "Open new window (right-inner)",
  rhs = "<CMD>rightbelow vertical new<CR>",
}
M.keymaps.open_new_right_outer = { ---@type my.keymap.keymap_spec
  desc = "Open new window (right-outer)",
  rhs = "<CMD>botright vertical new<CR>",
}
M.keymaps.open_new_up_inner = { ---@type my.keymap.keymap_spec
  desc = "Open new window (up-inner)",
  rhs = "<CMD>leftabove new<CR>",
}
M.keymaps.open_new_up_outer = { ---@type my.keymap.keymap_spec
  desc = "Open new window (up-outer)",
  rhs = "<CMD>topleft new<CR>",
}
M.keymaps.open_quickfix_list = { ---@type my.keymap.keymap_spec
  desc = "Open quickfix list",
  rhs = "<CMD>copen<CR>",
}
M.keymaps.open_search_backword = { ---@type my.keymap.keymap_spec
  desc = "win open (search backword)",
  rhs = "q?",
}
M.keymaps.open_search_forward = { ---@type my.keymap.keymap_spec
  desc = "win open (search forward)",
  rhs = "q/",
}
M.keymaps.shrink_win_x = { ---@type my.keymap.keymap_spec
  desc = "resize win X-",
  rhs = "<CMD>vertical resize -<CR>",
}
M.keymaps.shrink_win_y = { ---@type my.keymap.keymap_spec
  desc = "resize win Y-",
  rhs = "<CMD>resize -<CR>",
}
M.keymaps.split_down_inner = { ---@type my.keymap.keymap_spec
  desc = "Split window (down-inner)",
  rhs = "<CMD>rightbelow split<CR>",
}
M.keymaps.split_down_outer = { ---@type my.keymap.keymap_spec
  desc = "Split window (down-outer)",
  rhs = "<CMD>botright split<CR>",
}
M.keymaps.split_left_inner = { ---@type my.keymap.keymap_spec
  desc = "Split window (left-inner)",
  rhs = "<CMD>leftabove vertical split<CR>",
}
M.keymaps.split_left_outer = { ---@type my.keymap.keymap_spec
  desc = "Split window (left-outer)",
  rhs = "<CMD>topleft vertical split<CR>",
}
M.keymaps.split_right_inner = { ---@type my.keymap.keymap_spec
  desc = "Split window (right-inner)",
  rhs = "<CMD>rightbelow vertical split<CR>",
}
M.keymaps.split_right_outer = { ---@type my.keymap.keymap_spec
  desc = "Split window (right-outer)",
  rhs = "<CMD>botright vertical split<CR>",
}
M.keymaps.split_to_tab_first = { ---@type my.keymap.keymap_spec
  desc = "Split to tab (first)",
  rhs = "<CMD>split|wincmd T|0tabmove<CR>",
}
M.keymaps.split_to_tab_last = { ---@type my.keymap.keymap_spec
  desc = "Split to tab (last)",
  rhs = "<CMD>split|wincmd T|$tabmove<CR>",
}
M.keymaps.split_to_tab_left = { ---@type my.keymap.keymap_spec
  desc = "Split to tab (left)",
  rhs = "<CMD>split|wincmd T|-tabmove<CR>",
}
M.keymaps.split_to_tab_right = { ---@type my.keymap.keymap_spec
  desc = "Split to tab (right)",
  rhs = "<CMD>split|wincmd T<CR>",
}
M.keymaps.split_up_inner = { ---@type my.keymap.keymap_spec
  desc = "Split window (up-inner)",
  rhs = "<CMD>leftabove split<CR>",
}
M.keymaps.split_up_outer = { ---@type my.keymap.keymap_spec
  desc = "Split window (up-outer)",
  rhs = "<CMD>topleft split<CR>",
}
M.keymaps.switch_to_alternate = { ---@type my.keymap.keymap_spec
  desc = "Go to window (alternate)",
  rhs = my.keymap.ESC .. "<CMD>wincmd p<CR>",
}
M.keymaps.sync_current_win = { ---@type my.keymap.keymap_spec
  desc = "Sync window",
  rhs = M.sync_current_win,
}

return M
