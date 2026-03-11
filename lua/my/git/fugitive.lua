local my = require "my"
---@class my.git.fugitive
local M = {}

M.opts = {}

M.opts.core_integration = function()
  my.autocmd.add_autocmd {
    group = "my.git.fugitive.git_buf_setup",
    event = { "FileType" },
    pattern = "fugitive,git",
    desc = 'Set options, vars and mappings for the "fugitive,git" filetypes',
    callback = function(args)
      if vim.b[args.buf].did_ftplugin_my_fugitive then return end
      vim.b[args.buf].did_ftplugin_my_fugitive = true

      vim.b[args.buf].my_get_buf_dir_path = M.get_buf_dir_path
    end,
  }

  my.keymap.queue_km_group_load(my.config.keymaps.g_fugitive)
end

M.get_buf_dir_path = function() --
  return vim.trim(vim.fn.execute "Git rev-parse --show-toplevel")
end

function M.open_with_command(cmd) --
  if vim.bo.filetype ~= "fugitive" and vim.bo.filetype ~= "git" then
    my.fs.cd.cd("Local", false)
    my.win.get_on_buf_change_win_toggler()()
  end

  my.win.open_cmd_in_current_win(cmd)
end

M.keymaps = {}

M.keymaps.open_git_win_from_buf = { ---@type my.keymap.keymap_spec
  desc = "Open git win",
  rhs = function() M.open_with_command ":Git" end,
}
M.keymaps.open_log_from_buf = { ---@type my.keymap.keymap_spec
  desc = "Open git `log --oneline`",
  rhs = function() M.open_with_command ":Git log --oneline" end,
}
return M
