local my = require "my"
---@class my.ft.nvim_help
local M = {}

M.a0_init = function()
  local setups = my.g.filetype_setup_autocmds
  setups[#setups + 1] = M.autocmds.filetype_setup
end

M.autocmds = {}
M.autocmds.filetype_setup = function()
  my.autocmd.add_autocmd {
    desc = 'Set options, vars and mappings for the "help" filetype',
    group = { "my.filetypes", false },
    event = "FileType",
    pattern = "help",
    callback = function(args)
      -- Override NVIM defaults.
      -- Needs to be done before the `did_ftplugin` check due to lazy.nvim emitting
      -- filetype autocommands multiple times and NVIM executing the default filetype
      -- config each time, see:
      --  * https://github.com/folke/lazy.nvim/issues/1993
      vim.opt_local.conceallevel = 0

      if vim.b[args.buf].did_ftplugin_my_help then return end
      vim.b[args.buf].did_ftplugin_my_help = true
    end,
  }
end

M.keymaps = {}

M.keymaps.help = { ---@type my.keymap.keymap_spec
  desc = "Open nvim help (tag)",
  rhs = function() my.win.open_util_in_current_win { init = ":help", ft = "help", prompt_cmd = ":help " } end,
}
M.keymaps.helpgrep = { ---@type my.keymap.keymap_spec
  desc = "Open nvim help (grep)",
  rhs = function() my.win.open_util_in_current_win { init = ":help", ft = "help", prompt_cmd = ":helpgrep " } end,
}

return M
