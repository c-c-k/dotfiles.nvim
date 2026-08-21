---@class MyFtNvimHelp
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.filetypes = function()
  local autocmds = my.config.setup_filetype_autocmds
  -- local lsp = my.config.setup_lsp_configs
  -- local mason_ensure_installed = my.config.mason_ensure_installed
  -- local null_ls = my.config.null_ls_sources
  -- local specks = my.config.lzsetup_plugin_specs
  -- local ts_ensure_installed = my.config.ts_ensure_installed

  autocmds[#autocmds + 1] = M._autocmd_filetype_setup
end

M._autocmd_filetype_setup = function()
  my.autocmd.add_autocmd {
    desc = 'Set options, vars and mappings for the "help" filetype',
    group = { "my.filetypes", false },
    event = "FileType",
    pattern = "help",
    callback = function(ev)
      local buf_id = ev.buf
      local did_ftplugin = my.config.did_ftplugin_buf[buf_id]
      -- Override NVIM defaults.
      -- Needs to be done before the `did_ftplugin` check due to lazy.nvim emitting
      -- filetype autocommands multiple times and NVIM executing the default filetype
      -- config each time, see:
      --  * https://github.com/folke/lazy.nvim/issues/1993
      vim.opt_local.conceallevel = 0

      if did_ftplugin == "help" then return end
      my.config.did_ftplugin_buf[buf_id] = "help"
    end,
  }
end

M.keymaps = {}

M.keymaps.help = { ---@type MyKeymapKeymapSpec
  desc = "Open nvim help (tag)",
  rhs = function() my.win.open_util_in_current_win { init = ":help", ft = "help", prompt_cmd = ":help " } end,
}
M.keymaps.helpgrep = { ---@type MyKeymapKeymapSpec
  desc = "Open nvim help (grep)",
  rhs = function() my.win.open_util_in_current_win { init = ":help", ft = "help", prompt_cmd = ":helpgrep " } end,
}

return M
