local my = require "my"

---@type LazyPluginSpec
local spec_mini_files = {
  "nvim-mini/mini.files",
  opts = {
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
      -- close = 'q',
      close = "", -- set in aucmd buffer mappings
      go_in = "l",
      -- go_in_plus  = 'L',
      go_in_plus = "<CR>",
      go_out = "h",
      -- go_out_plus = 'H',
      go_out_plus = "<BS>",
      -- reset       = '<BS>',
      -- reveal_cwd  = '@',
      show_help = "g?",
      -- synchronize = '=',
      synchronize = "", -- set in aucmd buffer mappings
      trim_left = "<",
      trim_right = ">",
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
  },
}

---@type LazyPluginSpec
local spec_mini_files__astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local minifiles = require "mini.files"

    local function minifiles_toggle()
      if not minifiles.close() then minifiles.open(minifiles.get_latest_path()) end
    end

    local function minifiles_open_from_input()
      local path = vim.fn.input("Path: ", "", "file")
      minifiles.open(path)
    end

    local function minifiles_open_from_buf()
      if
        (vim.b.my_get_buf_file_path and pcall(minifiles.open, vim.b.my_get_buf_file_path()))
        or (vim.b.my_get_buf_dir_path and pcall(minifiles.open, vim.b.my_get_buf_dir_path()))
        or pcall(minifiles.open, vim.api.nvim_buf_get_name(0))
      then
        return
      end

      local _msg = string.format("Can't open mini.files for: %s", vim.api.nvim_buf_get_name(0))
      vim.api.nvim_echo({ { _msg } }, true, { err = true })
    end

    local function minifiles_goto_file() --
      minifiles.go_in( {close_on_file = true})
    end

    local function minifiles_goto_external() --
      my.goto.do_external_open(minifiles.get_fs_entry().path)
    end

    local function minifiles_get_buf_file_path() --
      return minifiles.get_fs_entry().path
    end

    local function minifiles_get_buf_dir_path()
      local state = minifiles.get_explorer_state()
      return state and state.branch[state.depth_focus]
    end

    local aug_my_mini_files_lsp_file_actions = my.autocmd.get_augroup {
      name = "aug_my_mini_files_lsp_file_actions",
      clear = true,
    }
    my.autocmd.add_autocmd {
      group = aug_my_mini_files_lsp_file_actions,
      event = "User",
      pattern = { "MiniFilesActionCreate" },
      desc = "trigger `workspace/didCreateFiles` after creating files",
      callback = function(args) require("astrolsp.file_operations").didCreateFiles(args.data.to) end,
    }
    my.autocmd.add_autocmd {
      group = aug_my_mini_files_lsp_file_actions,
      event = "User",
      pattern = { "MiniFilesActionDelete" },
      desc = "trigger `workspace/didDeleteFiles` after deleting files",
      callback = function(args) require("astrolsp.file_operations").didDeleteFiles(args.data.from) end,
    }
    my.autocmd.add_autocmd {
      group = aug_my_mini_files_lsp_file_actions,
      event = "User",
      pattern = { "MiniFilesActionRename", "MiniFilesActionMove" },
      desc = "trigger `workspace/didRenameFiles` after renaming or moving files",
      callback = function(args) require("astrolsp.file_operations").didRenameFiles(args.data) end,
    }

    local aug_my_mini_files_buf_core_config = my.autocmd.get_augroup {
      name = "aug_my_mini_files_buf_core_config",
      clear = true,
    }
    my.autocmd.add_autocmd {
      group = aug_my_mini_files_buf_core_config,
      event = "FileType",
      pattern = "minifiles",
      desc = 'Set options, vars and mappings for the "minifiles" filetype',
      callback = function(args)
        if vim.b[args.buf].did_ftplugin_my_minifiles then return end
        vim.b[args.buf].did_ftplugin_my_minifiles = true

        vim.b[args.buf].my_goto_file = minifiles_goto_file
        vim.b[args.buf].my_goto_external = minifiles_goto_external
        vim.b[args.buf].my_get_buf_file_path = minifiles_get_buf_file_path
        vim.b[args.buf].my_get_buf_dir_path = minifiles_get_buf_dir_path
        vim.b[args.buf].my_close_buf = minifiles_toggle
        vim.b[args.buf].my_close_buf_win = minifiles_toggle
        vim.b[args.buf].my_sync_buf_win = minifiles.synchronize
        vim.b[args.buf].my_do_toggle_win = minifiles_toggle
        vim.b[args.buf].my_is_toggle_win_before_buf_change = true
      end,
    }
    my.autocmd.add_autocmd {
      group = aug_my_mini_files_buf_core_config,
      event = "User",
      pattern = "MiniFilesBufferCreate",
      desc = "Set options, vars and mappings for a mini.files popup window",
      callback = function(args)
        local maps, map = my.keymap.get_astrocore_mapper()

        map("n", "H", "h", { desc = "Cursor left" })
        map("n", "L", "l", { desc = "Cursor right" })

        astrocore.set_mappings(maps, { buffer = args.data.buf_id })
      end,
      -- },
    } --)

    local maps, map = my.keymap.get_astrocore_mapper()

    map("n", "<LEADER>off", function() minifiles_toggle() end, { desc = "Toggle mini.files" })
    map("n", "<LEADER>oF", function() minifiles_open_from_input() end, { desc = "Open mini.files (input)" })
    map(
      "n",
      "<LEADER>ofs",
      function() minifiles_open_from_buf() end,
      { desc = "Open mini.files (Select current file)" }
    )
    map("n", "<LEADER>ofc", function() minifiles.open(nil, false) end, { desc = "Open mini.files (CWD)" })

    opts.mappings = my.tbl.merge("dDFn", opts.mappings, maps)
  end,
}

spec_mini_files.specs = {
  spec_mini_files__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_mini_files,
}
