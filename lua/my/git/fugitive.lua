---@class MyGitFugitive
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_fugitive
end

M._spec_fugitive = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["vim-fugitive"],
    lazy = false,
    config = function(_, _)
      M._autocmd_filetype()

      my.keymap.queue_km_group_load(my.config.keymaps.g_fugitive)
    end,
  }
  return spec
end

M._autocmd_filetype = function()
  my.autocmd.add_autocmd {
    group = "my.git.fugitive.git_buf_setup",
    event = { "FileType" },
    pattern = "fugitive,git",
    desc = 'Set options, vars and mappings for the "fugitive,git" filetypes',
    callback = function(args)
      local buf_id = args.buf

      my.config.syntax_autostart_regex_filetype_buf[buf_id] = true

      local did_ftplugin = my.config.did_ftplugin_buf[buf_id]
      if did_ftplugin == "fugitive" then return end
      my.config.did_ftplugin_buf[buf_id] = "fugitive"

      my.config.get_dir_path_func_buf[buf_id] = M.get_buf_dir_path
    end,
  }
end

M.get_buf_dir_path = function() --
  return vim.trim(vim.fn.execute "Git rev-parse --show-toplevel")
end

function M.open_with_command(cmd) --
  if vim.bo.filetype ~= "fugitive" and vim.bo.filetype ~= "git" then
    my.fs.cd.cd("Local", false)
    local close_buf_fixed_win = my.win.get_buf_fixed_win_toggler(true)
    close_buf_fixed_win()
  end

  my.win.open_cmd_in_current_win(cmd)
end

M.keymaps = {}

M.keymaps.open_git_win_from_buf = { ---@type MyKeymapKeymapSpec
  desc = "Open git win",
  rhs = function() M.open_with_command ":Git" end,
}
M.keymaps.open_log_from_buf = { ---@type MyKeymapKeymapSpec
  desc = "Open git `log --oneline`",
  rhs = function() M.open_with_command ":Git log --oneline" end,
}
return M
