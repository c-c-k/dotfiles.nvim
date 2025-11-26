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
    local my = require "my"
    local astrocore = require "astrocore"
    local minifiles = require "mini.files"

    local function minifiles_toggle()
      if not minifiles.close() then minifiles.open(minifiles.get_latest_path()) end
    end

    local function get_buf_dir_path()
      -- -- Works only if cursor is on the valid file system entry
      -- local current_entry_path = minifiles.get_fs_entry().path
      -- return vim.fs.dirname(current_entry_path)

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

        vim.b[args.buf].my_get_buf_dir_path = get_buf_dir_path
        vim.b[args.buf].my_do_toggle_win = minifiles_toggle
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
        map("n", "<LEADER>wy", function() minifiles.synchronize() end, { desc = "sync mini.files actions" })
        map("n", "<LEADER>wx", function() minifiles.close() end, { desc = "Close mini.files popup" })
        map("n", "<LEADER>xw", { copy = { "n", "<LEADER>wx" } })
        map("n", "<LEADER>xx", { copy = { "n", "<LEADER>wx" } })

        -- fugitive integration
        map("n", "<LEADER>ogg", function()
          local current_entry_path = minifiles.get_fs_entry().path
          local current_dir = vim.fs.dirname(current_entry_path)
          minifiles.close()
          local temp_path = current_dir .. "/~temp" .. vim.fn.rand()
          vim.cmd.edit(temp_path)
          vim.cmd "Git"
          vim.cmd.bwipeout(temp_path)
        end, { desc = "Open fugitive git manager" })
        map("n", "<LEADER>ogl", function()
          local current_entry_path = minifiles.get_fs_entry().path
          local current_dir = vim.fs.dirname(current_entry_path)
          minifiles.close()
          local temp_path = current_dir .. "/~temp" .. vim.fn.rand()
          vim.cmd.edit(temp_path)
          vim.cmd "Git log --oneline"
          vim.cmd.bwipeout(temp_path)
        end, { desc = "Open fugitive git `log --oneline`" })

        -- oil.nvim integration
        map("n", "<LEADER>ofo", function()
          local has_oil, oil = pcall(require, "oil")
          if has_oil then
            local current_entry_path = minifiles.get_fs_entry().path
            local current_dir = vim.fs.dirname(current_entry_path)
            minifiles.close()
            oil.open(current_dir)
          else
            vim.print "oil.nvim plugin not present"
          end
        end, { desc = "Open oil.nvim (current dir)" })

        -- terminal integration
        map("n", "<LEADER>otl", function()
          local cur_entry_path = minifiles.get_fs_entry().path
          local cur_directory = vim.fs.dirname(cur_entry_path)
          minifiles.close()
          vim.cmd.lcd(cur_directory)
          vim.cmd.terminal()
          vim.cmd.startinsert()
        end, { desc = "Open terminal (buffer dir)" })
        map("n", "<LEADER>ott", function()
          minifiles.close()
          vim.cmd.terminal()
          vim.cmd.startinsert()
        end, { desc = "Open terminal (PWD)" })

        astrocore.set_mappings(maps, { buffer = args.data.buf_id })
      end,
      -- },
    } --)

    local maps, map = my.keymap.get_astrocore_mapper()

    map("n", "<LEADER>off", function() minifiles_toggle() end, { desc = "Toggle mini.files" })
    map("n", "<LEADER>oF", function()
      local path = vim.fn.input("Path: ", "", "file")
      minifiles.open(path)
    end, { desc = "Open mini.files (input)" })
    map("n", "<LEADER>ofs", function()
      local success, _ = pcall(minifiles.open, vim.api.nvim_buf_get_name(0))
      if not success then
        success, error = pcall(minifiles.open, vim.api.nvim_buf_get_name(0), false)
        if not success then vim.print(error) end
      end
    end, { desc = "Open mini.files (Select current file)" })
    map("n", "<LEADER>ofc", function() minifiles.open(nil, false) end, { desc = "Open mini.files (CWD)" })

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

spec_mini_files.specs = {
  spec_mini_files__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_mini_files,
}
