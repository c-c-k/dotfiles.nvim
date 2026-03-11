local my = require "my"
---@class my.testing.neotest
local M = {}

M.opts = {}
M.opts.general = function(_, opts) ---@cast opts MyNoOptsSpec
  local icons = nil
  if my.g.icons_enabled == false then
    icons = {
      failed = "X",
      notify = "!",
      passed = "O",
      running = "*",
      skipped = "-",
      unknown = "?",
      watching = "W",
    }
  end
  return my.tbl.merge_dicts_into_last(opts, {
    adapters = {},
    icons = icons,
    floating = { border = "rounded" },
  } --[[@as MyNoOptsSpec]])
end
M.opts.core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_neotest_)
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
        return message
      end,
    },
  }, vim.api.nvim_create_namespace "neotest")
end

local function output_to_new_tab()
  require("neotest").output.open {
    open_win = function()
      vim.cmd.tabnew()
      local win_id = vim.api.nvim_tabpage_get_win(0)
      vim.wo[win_id].number = false
      vim.wo[win_id].relativenumber = false
      vim.wo[win_id].signcolumn = "no"
      return win_id
    end,
    auto_close = false,
    enter = true,
    last_run = false,
    short = false,
  }
end

M.keymaps = {}

M.keymaps.debug_test = { ---@type my.keymap.keymap_spec
  desc = "Debug test",
  rhs = function() require("neotest").run.run_last { strategy = "dap", suite = false } end,
}
M.keymaps.next = { ---@type my.keymap.keymap_spec
  desc = "Next test",
  rhs = function() require("neotest").jump.next() end,
}
M.keymaps.output_hover = { ---@type my.keymap.keymap_spec
  desc = "Test Output hover",
  rhs = function() require("neotest").output.open() end,
}
M.keymaps.output_pannel_toggle = { ---@type my.keymap.keymap_spec
  desc = "Toggle Test Output Panel",
  rhs = function() require("neotest").output_panel.toggle() end,
}
M.keymaps.output_to_new_tab = { ---@type my.keymap.keymap_spec
  desc = "Test Output to new tab",
  rhs = function() return output_to_new_tab() end,
}
M.keymaps.prev = { ---@type my.keymap.keymap_spec
  desc = "Prev test",
  rhs = function() require("neotest").jump.prev() end,
}
M.keymaps.run_file_all = { ---@type my.keymap.keymap_spec
  desc = "Run all tests in file",
  rhs = function() require("neotest").run.run(vim.fn.expand "%") end,
}
M.keymaps.run_pwd_all = { ---@type my.keymap.keymap_spec
  desc = "Run all tests in project",
  rhs = function() require("neotest").run.run(vim.fn.getcwd()) end,
}
M.keymaps.run_test = { ---@type my.keymap.keymap_spec
  desc = "Run test",
  rhs = function() require("neotest").run.run() end,
}
M.keymaps.toggle_summary = { ---@type my.keymap.keymap_spec
  desc = "Toggle Test Summary",
  rhs = function() require("neotest").summary.toggle() end,
}
M.keymaps.watch_stop_all = { ---@type my.keymap.keymap_spec
  desc = "Stop all watches",
  --- NOTE: Bug? the documentation states that argument is effectively optional.
  ---@diagnostic disable-next-line: missing-parameter
  rhs = function() require("neotest").watch.stop() end,
}
M.keymaps.watch_toggle = { ---@type my.keymap.keymap_spec
  desc = "Toggle watch test",
  rhs = function() require("neotest").watch.toggle() end,
}
M.keymaps.watch_toggle_file_all = { ---@type my.keymap.keymap_spec
  desc = "Toggle watch all test in file",
  rhs = function() require("neotest").watch.toggle(vim.fn.expand "%") end,
}
M.keymaps.watch_toggle_pwd_all = { ---@type my.keymap.keymap_spec
  desc = "Toggle watch all tests in project",
  rhs = function() require("neotest").watch.toggle(vim.fn.getcwd()) end,
}

return M
