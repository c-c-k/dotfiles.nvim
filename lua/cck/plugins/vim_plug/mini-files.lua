-- ===========================================================================
-- MINI.FILES
-- ===========================================================================
-- see: <https://github.com/echasnovski/mini.files>
-- see: `:help mini.files`

require('mini.files').setup({
  -- Customization of shown content
  content = {
    -- Predicate for which file system entries to show
    filter = nil,
    -- What prefix to show to the left of file system entry
    prefix = nil,
    -- In which order to show file system entries
    sort = nil,
  },

  -- Module mappings created only inside explorer.
  -- Use `''` (empty string) to not create one.
  mappings = {
    -- close       = 'q',
    close       = '<LEADER>xd',
    go_in       = 'l',
    -- go_in_plus  = 'L',
    go_in_plus  = '<CR>',
    go_out      = 'h',
    -- go_out_plus = 'H',
    go_out_plus = '<BS>',
    -- reset       = '<BS>',
    -- reveal_cwd  = '@',
    show_help   = 'g?',
    -- synchronize = '=',
    synchronize = '<LEADER>wy',
    trim_left   = '<',
    trim_right  = '>',
  },

  -- General options
  options = {
    -- Whether to delete permanently or move into module-specific trash
    permanent_delete = true,
    -- Whether to use for editing directories
    use_as_default_explorer = false,
  },

  -- Customization of explorer windows
  windows = {
    -- Maximum number of windows to show side by side
    max_number = math.huge,
    -- Whether to show preview of file/directory under cursor
    preview = false,
    -- Width of focused window
    width_focus = 50,
    -- Width of non-focused window
    width_nofocus = 15,
    -- Width of preview window
    width_preview = 25,
  },
})

local minifiles_toggle = function(...)
  if not MiniFiles.close() then MiniFiles.open(...) end
end
 
local files_set_cwd = function(scope)
  -- Works only if cursor is on the valid file system entry
  local current_entry_path = MiniFiles.get_fs_entry().path
  local current_dir = vim.fs.dirname(current_entry_path)

  if scope == "g" then
    vim.cmd.cd(current_dir)
  elseif scope == "t" then
    vim.cmd.tcd(current_dir)
  elseif scope == "l" then
    vim.cmd.lcd(current_dir)
  else
  vim.fn.chdir(current_dir)
  end
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    vim.keymap.set("n", "H", "h", { buffer = args.data.buf_id, desc = "Cursor left" })
    vim.keymap.set("n", "L", "l", { buffer = args.data.buf_id, desc = "Cursor right" })
    vim.keymap.set("n", "<LEADER>upg", function()
      files_set_cwd("g")
    end, { buffer = args.data.buf_id, desc = "Set PWD (global) to current dir" })
    vim.keymap.set("n", "<LEADER>upt", function()
      files_set_cwd("t")
    end, { buffer = args.data.buf_id, desc = "Set PWD (tab) to current dir" })
    vim.keymap.set("n", "<LEADER>upl", function()
      files_set_cwd("l")
    end, { buffer = args.data.buf_id, desc = "Set PWD (local) to current dir" })
    vim.keymap.set("n", "<LEADER>upp", function()
      files_set_cwd()
    end, { buffer = args.data.buf_id, desc = "Set PWD (auto) to current dir" })
  end,
})

vim.keymap.set( "n", "<LEADER>odd", function()
  minifiles_toggle(MiniFiles.get_latest_path())
end , { desc = "Toggle mini.files" } )
vim.keymap.set( "n", "<LEADER>oD", function()
  local path = vim.fn.input("Path: ", "", "file")
  MiniFiles.open(path)
end , { desc = "Open mini.files (input)" } )
vim.keymap.set( "n", "<LEADER>ods", function()
  local success, _ = pcall(MiniFiles.open, vim.api.nvim_buf_get_name(0))
  if not success then
    success, error = pcall(MiniFiles.open, vim.api.nvim_buf_get_name(0), false)
    if not success then
      vim.print(error)
    end
  end
end , { desc = "Open mini.files (Select current file)" } )
vim.keymap.set( "n", "<LEADER>odc", function()
  minifiles_toggle(nil, false)
end , { desc = "Open mini.files (CWD)" } )
