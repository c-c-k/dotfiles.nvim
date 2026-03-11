local my = require "my"
---@class my.ui.picker.snacks
local M = {}

M.opts = {}

M.opts.snacks_picker_core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_snkkbuf_)
  my.keymap.queue_km_group_load(my.config.keymaps.g_snkkfs__)
  my.keymap.queue_km_group_load(my.config.keymaps.g_snkkgit_)
  my.keymap.queue_km_group_load(my.config.keymaps.g_snkklsp_)
  my.keymap.queue_km_group_load(my.config.keymaps.g_snkknvim)
  my.keymap.queue_km_group_load(my.config.keymaps.g_snkkrg__)
end

M.keymaps = {}

M.keymaps.find_a_dirsession = { ---@type my.keymap.keymap_spec
  desc = "Find a dirsession",
  rhs = function() require("resession").load(nil, { dir = "dirsession" }) end,
}
M.keymaps.find_buffers = { ---@type my.keymap.keymap_spec
  desc = "Find buffers",
  rhs = function() require("snacks").picker.buffers() end,
}
M.keymaps.find_buffers_recent_files = { ---@type my.keymap.keymap_spec
  desc = "Find all (buffers/recent/files)",
  rhs = function() require("snacks").picker.smart() end,
}
M.keymaps.find_commands = { ---@type my.keymap.keymap_spec
  desc = "Find commands",
  rhs = function() require("snacks").picker.commands() end,
}
M.keymaps.find_diagnostics = { ---@type my.keymap.keymap_spec
  desc = "Search diagnostics",
  rhs = function() require("snacks").picker.diagnostics() end,
}
M.keymaps.find_files_pwdall = { ---@type my.keymap.keymap_spec
  desc = "Find files (PWD-all)",
  rhs = function() require("snacks").picker.files { hidden = true, ignored = true } end,
}
M.keymaps.find_files_pwdnoall = { ---@type my.keymap.keymap_spec
  desc = "Find files (PWD-noall)",
  rhs = function()
    require("snacks").picker.files {
      hidden = vim.tbl_get(vim.uv.fs_stat ".git" or {}, "type") == "directory",
    }
  end,
}
M.keymaps.find_git_branches = { ---@type my.keymap.keymap_spec
  desc = "Git branches",
  rhs = function() require("snacks").picker.git_branches() end,
}
M.keymaps.find_git_commits_current_file = { ---@type my.keymap.keymap_spec
  desc = "Git commits (current file)",
  rhs = function() require("snacks").picker.git_log { current_file = true, follow = true } end,
}
M.keymaps.find_git_commits_repository = { ---@type my.keymap.keymap_spec
  desc = "Git commits (repository)",
  rhs = function() require("snacks").picker.git_log() end,
}
M.keymaps.find_git_files = { ---@type my.keymap.keymap_spec
  desc = "Find git files",
  rhs = function() require("snacks").picker.git_files() end,
}
M.keymaps.find_git_stash = { ---@type my.keymap.keymap_spec
  desc = "Git stash",
  rhs = function() require("snacks").picker.git_stash() end,
}
M.keymaps.find_git_status = { ---@type my.keymap.keymap_spec
  desc = "Git status",
  rhs = function() require("snacks").picker.git_status() end,
}
M.keymaps.find_help = { ---@type my.keymap.keymap_spec
  desc = "Find help",
  rhs = function() require("snacks").picker.marks() end,
}
M.keymaps.find_keymaps = { ---@type my.keymap.keymap_spec
  desc = "Find keymaps",
  rhs = function() require("snacks").picker.keymaps() end,
}
M.keymaps.find_lines_in_buffer = { ---@type my.keymap.keymap_spec
  desc = "Find lines in buffer",
  rhs = function() require("snacks").picker.lines() end,
}
M.keymaps.find_man = { ---@type my.keymap.keymap_spec
  desc = "Find man",
  rhs = function() require("snacks").picker.man() end,
}
M.keymaps.find_marks = { ---@type my.keymap.keymap_spec
  desc = "Find marks",
  rhs = function() require("snacks").picker.marks() end,
}
M.keymaps.find_notifications = { ---@type my.keymap.keymap_spec
  desc = "Find notifications",
  rhs = function() require("snacks").picker.notifications() end,
}
M.keymaps.find_nvim_config_files = { ---@type my.keymap.keymap_spec
  desc = "Find nvim config files",
  rhs = function() require("snacks").picker.files { dirs = { vim.fn.stdpath "config" }, desc = "Config Files" } end,
}
M.keymaps.find_projects = { ---@type my.keymap.keymap_spec
  desc = "Find projects",
  rhs = function() require("snacks").picker.projects() end,
}
M.keymaps.find_recent_files = { ---@type my.keymap.keymap_spec
  desc = "Find recent files",
  rhs = function() require("snacks").picker.recent() end,
}
M.keymaps.find_recent_files_pwd = { ---@type my.keymap.keymap_spec
  desc = "Find recent files (PWD)",
  rhs = function() require("snacks").picker.recent { filter = { cwd = true } } end,
}
M.keymaps.find_registers = { ---@type my.keymap.keymap_spec
  desc = "Find registers",
  rhs = function() require("snacks").picker.registers() end,
}
M.keymaps.find_ripgrep_pwdall = { ---@type my.keymap.keymap_spec
  desc = "Ripgrep (PWD-all)",
  rhs = function() require("snacks").picker.grep { hidden = true, ignored = true } end,
}
M.keymaps.find_ripgrep_pwdnoall = { ---@type my.keymap.keymap_spec
  desc = "Ripgrep (PWD-noall)",
  rhs = function() require("snacks").picker.grep() end,
}
M.keymaps.find_sessions = { ---@type my.keymap.keymap_spec
  desc = "find a session",
  rhs = function() require("snacks").picker.grep() end,
}
M.keymaps.find_symbols = { ---@type my.keymap.keymap_spec
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
M.keymaps.find_themes = { ---@type my.keymap.keymap_spec
  desc = "Find themes",
  rhs = function() require("snacks").picker.colorschemes() end,
}
M.keymaps.find_undo_history = { ---@type my.keymap.keymap_spec
  desc = "Find undo history",
  rhs = function() require("snacks").picker.undo() end,
}
M.keymaps.find_word_under_cursor_pwd = { ---@type my.keymap.keymap_spec
  desc = "Find word under cursor (PWD)",
  rhs = function() require("snacks").picker.grep_word() end,
}
M.keymaps.resume_previous_search = { ---@type my.keymap.keymap_spec
  desc = "Resume previous search",
  rhs = function() require("snacks").picker.resume() end,
}

return M
