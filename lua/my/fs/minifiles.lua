local my = require "my"
---@class my.fs.minifiles
local M = {}

M.opts = {}
M.opts.general = function(_, opts) ---@cast opts MyNoOptsSpec
  return my.tbl.merge_dicts_into_last(opts, {
    -- Customization of shown content
    content = {
      -- Predicate for which file system entries to show
      filter = nil,
      -- What prefix to show to the left of file system entry
      prefix = nil,
      -- In which order to show file system entries
      sort = nil,
    },

    mappings = {
      close = "",
      go_in = "",
      go_in_plus = "",
      go_out = "",
      go_out_plus = "",
      reset = "",
      reveal_cwd = "",
      show_help = "",
      synchronize = "",
      trim_left = "",
      trim_right = "",
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
  } --[[@as MyNoOptsSpec]])
end
M.opts.core_integration = function()
  local augroup = my.autocmd.get_augroup("my.fs.minifiles.lsp_file_ops", true)
  my.autocmd.add_autocmd {
    group = augroup,
    event = "User",
    pattern = { "MiniFilesActionCreate" },
    desc = "trigger `workspace/didCreateFiles` after creating files",
    callback = function(args) my.lsp.lsp_file_ops.files_did_create(args.data.to) end,
  }
  my.autocmd.add_autocmd {
    group = augroup,
    event = "User",
    pattern = { "MiniFilesActionDelete" },
    desc = "trigger `workspace/didDeleteFiles` after deleting files",
    callback = function(args) my.lsp.lsp_file_ops.files_did_delete(args.data.from) end,
  }
  my.autocmd.add_autocmd {
    group = augroup,
    event = "User",
    pattern = { "MiniFilesActionRename", "MiniFilesActionMove" },
    desc = "trigger `workspace/didRenameFiles` after renaming or moving files",
    callback = function(args) my.lsp.lsp_file_ops.files_did_rename(args.data.from, args.data.to) end,
  }

  my.autocmd.add_autocmd {
    group = "my.fs.minifiles.float_win_setup",
    event = "FileType",
    pattern = "minifiles",
    desc = 'Set options, vars and mappings for the "minifiles" filetype',
    callback = function(args)
      if vim.b[args.buf].did_ftplugin_my_minifiles then return end
      vim.b[args.buf].did_ftplugin_my_minifiles = true

      vim.b[args.buf].my_goto_file = M.goto_file
      vim.b[args.buf].my_goto_external = M.goto_external
      vim.b[args.buf].my_get_buf_file_path = M.get_buf_file_path
      vim.b[args.buf].my_get_buf_dir_path = M.get_buf_dir_path
      vim.b[args.buf].my_close_buf = M.toggle
      vim.b[args.buf].my_close_buf_win = M.toggle
      vim.b[args.buf].my_sync_buf_win = M.synchronize
      vim.b[args.buf].my_do_toggle_win = M.toggle
      vim.b[args.buf].my_is_toggle_win_before_buf_change = true

      my.keymap.load_km_group(my.config.keymaps.b_minfiles, { buffer = args.buf })
    end,
  }

  my.keymap.queue_km_group_load(my.config.keymaps.g_minfiles)
end

function M.close() --
  require("mini.files").close()
end

function M.get_buf_dir_path() --
  local state = require("mini.files").get_explorer_state()
  return state and state.branch[state.depth_focus]
end

function M.get_buf_file_path() --
  return require("mini.files").get_fs_entry().path
end

function M.goto_external() --
  local minifiles = require "mini.files"
  my.go_to.do_external_open(minifiles.get_fs_entry().path)
end

function M.goto_file() --
  require("mini.files").go_in { close_on_file = true }
end

function M.synchronize() --
  require("mini.files").synchronize()
end

function M.toggle() --
  local minifiles = require "mini.files"
  if not minifiles.close() then minifiles.open(minifiles.get_latest_path()) end
end

M.keymaps = {}

M.keymaps.go_in = { ---@type my.keymap.keymap_spec
  desc = "Cursor right",
  rhs = function() require("mini.files").go_in() end,
}
M.keymaps.go_in_plus = { ---@type my.keymap.keymap_spec
  desc = "Cursor right",
  rhs = function() require("mini.files").go_in_plus() end,
}
M.keymaps.go_out = { ---@type my.keymap.keymap_spec
  desc = "Cursor right",
  rhs = function() require("mini.files").go_out() end,
}
M.keymaps.go_out_plus = { ---@type my.keymap.keymap_spec
  desc = "Cursor right",
  rhs = function()
    local minifiles = require "mini.files"
    minifiles.go_out()
    minifiles.trim_right()
  end,
}
M.keymaps.open_from_buf = { ---@type my.keymap.keymap_spec
  desc = "Open mini.files (current file)",
  rhs = function()
    local minifiles = require "mini.files"
    if
      (vim.b.my_get_buf_file_path and pcall(minifiles.open, vim.b.my_get_buf_file_path()))
      or (vim.b.my_get_buf_dir_path and pcall(minifiles.open, vim.b.my_get_buf_dir_path()))
      or pcall(minifiles.open, vim.api.nvim_buf_get_name(0))
    then
      return
    end
    local _msg = string.format("Can't open mini.files for: %s", vim.api.nvim_buf_get_name(0))
    my.notify.error(_msg)
  end,
}
M.keymaps.open_from_input = { ---@type my.keymap.keymap_spec
  desc = "Open mini.files (input)",
  rhs = function()
    local path = vim.fn.input("Path: ", "", "file")
    require("mini.files").open(path)
  end,
}
M.keymaps.open_pwd = { ---@type my.keymap.keymap_spec
  desc = "Open mini.files (CWD)",
  rhs = function() require("mini.files").open(nil, false) end,
}
M.keymaps.show_help = { ---@type my.keymap.keymap_spec
  desc = "Cursor right",
  rhs = function() require("mini.files").show_help() end,
}
M.keymaps.toggle = { ---@type my.keymap.keymap_spec
  desc = "Toggle mini.files",
  rhs = M.toggle,
}
M.keymaps.trim_left = { ---@type my.keymap.keymap_spec
  desc = "Cursor right",
  rhs = function() require("mini.files").trim_left() end,
}
M.keymaps.trim_right = { ---@type my.keymap.keymap_spec
  desc = "Cursor right",
  rhs = function() require("mini.files").trim_right() end,
}

return M
