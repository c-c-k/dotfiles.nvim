---@class MyUiPickerSnacks
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_snacks_picker
end

M._spec_snacks_picker = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["snacks-nvim"],
    opts = { ---@type snacks.Config
      picker = {
        config = function() --
          my.keymap.queue_km_group_load(my.config.keymaps.g_snkkbuf_)
          my.keymap.queue_km_group_load(my.config.keymaps.g_snkkfs__)
          my.keymap.queue_km_group_load(my.config.keymaps.g_snkkgit_)
          my.keymap.queue_km_group_load(my.config.keymaps.g_snkklsp_)
          my.keymap.queue_km_group_load(my.config.keymaps.g_snkknvim)
          my.keymap.queue_km_group_load(my.config.keymaps.g_snkkrg__)
        end,
      },
    },
  }
  return spec
end

M.keymaps = {}

M.keymaps.find_a_dirsession = { ---@type MyKeymapKeymapSpec
  desc = "Find a dirsession",
  rhs = function() require("resession").load(nil, { dir = "dirsession" }) end,
}
M.keymaps.find_buffers = { ---@type MyKeymapKeymapSpec
  desc = "Find buffers",
  rhs = function() require("snacks").picker.buffers() end,
}
M.keymaps.find_buffers_recent_files = { ---@type MyKeymapKeymapSpec
  desc = "Find all (buffers/recent/files)",
  rhs = function() require("snacks").picker.smart() end,
}
M.keymaps.find_commands = { ---@type MyKeymapKeymapSpec
  desc = "Find commands",
  rhs = function() require("snacks").picker.commands() end,
}
M.keymaps.find_diagnostics = { ---@type MyKeymapKeymapSpec
  desc = "Search diagnostics",
  rhs = function() require("snacks").picker.diagnostics() end,
}
M.keymaps.find_files_pwdall = { ---@type MyKeymapKeymapSpec
  desc = "Find files (PWD-all)",
  rhs = function() require("snacks").picker.files { hidden = true, ignored = true } end,
}
M.keymaps.find_files_pwdnoall = { ---@type MyKeymapKeymapSpec
  desc = "Find files (PWD-noall)",
  rhs = function()
    require("snacks").picker.files {
      hidden = vim.tbl_get(vim.uv.fs_stat ".git" or {}, "type") == "directory",
    }
  end,
}
M.keymaps.find_git_branches = { ---@type MyKeymapKeymapSpec
  desc = "Git branches",
  rhs = function() require("snacks").picker.git_branches() end,
}
M.keymaps.find_git_commits_current_file = { ---@type MyKeymapKeymapSpec
  desc = "Git commits (current file)",
  rhs = function() require("snacks").picker.git_log { current_file = true, follow = true } end,
}
M.keymaps.find_git_commits_repository = { ---@type MyKeymapKeymapSpec
  desc = "Git commits (repository)",
  rhs = function() require("snacks").picker.git_log() end,
}
M.keymaps.find_git_files = { ---@type MyKeymapKeymapSpec
  desc = "Find git files",
  rhs = function() require("snacks").picker.git_files() end,
}
M.keymaps.find_git_stash = { ---@type MyKeymapKeymapSpec
  desc = "Git stash",
  rhs = function() require("snacks").picker.git_stash() end,
}
M.keymaps.find_git_status = { ---@type MyKeymapKeymapSpec
  desc = "Git status",
  rhs = function() require("snacks").picker.git_status() end,
}
M.keymaps.find_help = { ---@type MyKeymapKeymapSpec
  desc = "Find help",
  rhs = function() require("snacks").picker.help() end,
}
M.keymaps.find_keymaps = { ---@type MyKeymapKeymapSpec
  desc = "Find keymaps",
  rhs = function() require("snacks").picker.keymaps() end,
}
M.keymaps.find_lines_in_buffer = { ---@type MyKeymapKeymapSpec
  desc = "Find lines in buffer",
  rhs = function() require("snacks").picker.lines() end,
}
M.keymaps.find_man = { ---@type MyKeymapKeymapSpec
  desc = "Find man",
  rhs = function() require("snacks").picker.man() end,
}
M.keymaps.find_marks = { ---@type MyKeymapKeymapSpec
  desc = "Find marks",
  rhs = function() require("snacks").picker.marks() end,
}
M.keymaps.find_notifications = { ---@type MyKeymapKeymapSpec
  desc = "Find notifications",
  rhs = function() require("snacks").picker.notifications() end,
}
M.keymaps.find_nvim_config_files = { ---@type MyKeymapKeymapSpec
  desc = "Find nvim config files",
  rhs = function() require("snacks").picker.files { dirs = { vim.fn.stdpath "config" }, desc = "Config Files" } end,
}
M.keymaps.find_projects = { ---@type MyKeymapKeymapSpec
  desc = "Find projects",
  rhs = function() require("snacks").picker.projects() end,
}
M.keymaps.find_recent_files = { ---@type MyKeymapKeymapSpec
  desc = "Find recent files",
  rhs = function() require("snacks").picker.recent() end,
}
M.keymaps.find_recent_files_pwd = { ---@type MyKeymapKeymapSpec
  desc = "Find recent files (PWD)",
  rhs = function() require("snacks").picker.recent { filter = { cwd = true } } end,
}
M.keymaps.find_registers = { ---@type MyKeymapKeymapSpec
  desc = "Find registers",
  rhs = function() require("snacks").picker.registers() end,
}
M.keymaps.find_ripgrep_pwdall = { ---@type MyKeymapKeymapSpec
  desc = "Ripgrep (PWD-all)",
  rhs = function() require("snacks").picker.grep { hidden = true, ignored = true } end,
}
M.keymaps.find_ripgrep_pwdnoall = { ---@type MyKeymapKeymapSpec
  desc = "Ripgrep (PWD-noall)",
  rhs = function() require("snacks").picker.grep() end,
}
M.keymaps.find_sessions = { ---@type MyKeymapKeymapSpec
  desc = "find a session",
  rhs = function() require("resession").load() end,
}
M.keymaps.find_symbols = { ---@type MyKeymapKeymapSpec
  desc = "Search symbols",
  rhs = function()
    local aerial_avail, aerial = pcall(require, "aerial")
    if aerial_avail and aerial.snacks_picker then
      aerial.snacks_picker()
    else
      require("snacks").picker.lsp_symbols()
    end
  end,
}
M.keymaps.find_themes = { ---@type MyKeymapKeymapSpec
  desc = "Find themes",
  rhs = function() require("snacks").picker.colorschemes() end,
}
M.keymaps.find_undo_history = { ---@type MyKeymapKeymapSpec
  desc = "Find undo history",
  rhs = function() require("snacks").picker.undo() end,
}
M.keymaps.find_word_under_cursor_pwd = { ---@type MyKeymapKeymapSpec
  desc = "Find word under cursor (PWD)",
  rhs = function() require("snacks").picker.grep_word() end,
}
M.keymaps.resume_previous_search = { ---@type MyKeymapKeymapSpec
  desc = "Resume previous search",
  rhs = function() require("snacks").picker.resume() end,
}

return M
