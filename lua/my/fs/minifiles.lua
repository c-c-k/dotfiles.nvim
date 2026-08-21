---@class MyFsMinifiles
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_mini_files
end

M._spec_mini_files = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["mini.files"],
    lazy = false,
    opts = {
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
      options = { --
        use_as_default_explorer = false,
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)

      M._autocmd_lsp_file_actions()
      M._autocmd_filetype()

      my.keymap.queue_km_group_load(my.config.keymaps.g_minfiles)
    end,
  }
  return spec
end

M._autocmd_lsp_file_actions = function()
  local augroup = my.autocmd.get_augroup("my.fs.minifiles.lsp_file_ops", true)
  my.autocmd.add_autocmd {
    group = augroup,
    event = "User",
    pattern = { "MiniFilesActionCreate" },
    desc = "trigger `workspace/didCreateFiles` after creating files",
    callback = function(ev)
      vim.schedule_wrap(function() my.lsp.lsp_file_ops.files_did_create(ev.data.to) end)
    end,
  }
  my.autocmd.add_autocmd {
    group = augroup,
    event = "User",
    pattern = { "MiniFilesActionDelete" },
    desc = "trigger `workspace/didDeleteFiles` after deleting files",
    callback = function(ev)
      vim.schedule_wrap(function() my.lsp.lsp_file_ops.files_did_delete(ev.data.from) end)
    end,
  }
  my.autocmd.add_autocmd {
    group = augroup,
    event = "User",
    pattern = { "MiniFilesActionRename", "MiniFilesActionMove" },
    desc = "trigger `workspace/didRenameFiles` after renaming or moving files",
    callback = function(ev)
      vim.schedule_wrap(function() my.lsp.lsp_file_ops.files_did_rename(ev.data.from, ev.data.to) end)
    end,
  }
end

M._autocmd_filetype = function()
  my.autocmd.add_autocmd {
    group = "my.fs.minifiles.float_win_setup",
    event = "FileType",
    pattern = "minifiles",
    desc = 'Set options, vars and mappings for the "minifiles" filetype',
    callback = function(ev)
      local buf_id = ev.buf
      local did_ftplugin = my.config.did_ftplugin_buf[buf_id]
      if did_ftplugin == "minifiles" then return end
      my.config.did_ftplugin_buf[buf_id] = "minifiles"

      my.config.goto_file_buf[buf_id] = M.goto_file
      my.config.goto_external_buf[buf_id] = M.goto_external
      my.config.get_file_path_func_buf[buf_id] = M.get_buf_file_path
      my.config.get_dir_path_func_buf[buf_id] = M.get_buf_dir_path
      my.config.close_buf[buf_id] = M.toggle
      my.config.close_buf_fixed_win_buf[buf_id] = M.toggle
      my.config.sync_buf[buf_id] = M.synchronize
      my.config.toggle_buf_fixed_win_func_buf[buf_id] = M.toggle
      my.config.toggle_buf_fixed_win_on_cd_buf[buf_id] = true

      my.keymap.load_km_group(my.config.keymaps.b_minfiles, { buffer = buf_id })
    end,
  }
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

M.keymaps.go_in = { ---@type MyKeymapKeymapSpec
  desc = "enter dir / preview file",
  rhs = function()
    local minifiles = require "mini.files"
    for _ = 1, vim.v.count1 do
      minifiles.go_in()
    end
  end,
}
M.keymaps.go_in_plus = { ---@type MyKeymapKeymapSpec
  desc = "enter dir / open file",
  rhs = function()
    local minifiles = require "mini.files"
    for _ = 1, vim.v.count1 do
      minifiles.go_in { close_on_file = true }
    end
  end,
}
M.keymaps.go_out = { ---@type MyKeymapKeymapSpec
  desc = "exit dir",
  rhs = function()
    local minifiles = require "mini.files"
    for _ = 1, vim.v.count1 do
      minifiles.go_out()
    end
  end,
}
M.keymaps.go_out_plus = { ---@type MyKeymapKeymapSpec
  desc = "exit dir and trim right",
  rhs = function()
    local minifiles = require "mini.files"
    for _ = 1, vim.v.count1 do
      minifiles.go_out()
    end
    minifiles.trim_right()
  end,
}
M.keymaps.open_from_buf = { ---@type MyKeymapKeymapSpec
  desc = "Open mini.files (current file)",
  rhs = function()
    local buf_id = vim.api.nvim_get_current_buf()
    local minifiles = require "mini.files"
    local get_file_path = my.config.get_file_path_func_buf[buf_id]
    local get_dir_path = my.config.get_dir_path_func_buf[buf_id]
    if
      (get_file_path and pcall(minifiles.open, get_file_path()))
      or (get_dir_path and pcall(minifiles.open, get_dir_path()))
      or pcall(minifiles.open, vim.api.nvim_buf_get_name(buf_id))
    then
      return
    end
    local _msg = string.format("Can't open mini.files for: %s", vim.api.nvim_buf_get_name(buf_id))
    my.notify.error(_msg)
  end,
}
M.keymaps.open_from_input = { ---@type MyKeymapKeymapSpec
  desc = "Open mini.files (input)",
  rhs = function()
    local path = vim.fn.input("Path: ", "", "file")
    require("mini.files").open(path)
  end,
}
M.keymaps.open_pwd = { ---@type MyKeymapKeymapSpec
  desc = "Open mini.files (CWD)",
  rhs = function() require("mini.files").open(nil, false) end,
}
M.keymaps.show_help = { ---@type MyKeymapKeymapSpec
  desc = "Cursor right",
  rhs = function() require("mini.files").show_help() end,
}
M.keymaps.toggle = { ---@type MyKeymapKeymapSpec
  desc = "Toggle mini.files",
  rhs = M.toggle,
}
M.keymaps.trim_left = { ---@type MyKeymapKeymapSpec
  desc = "Cursor right",
  rhs = function() require("mini.files").trim_left() end,
}
M.keymaps.trim_right = { ---@type MyKeymapKeymapSpec
  desc = "Cursor right",
  rhs = function() require("mini.files").trim_right() end,
}

return M
