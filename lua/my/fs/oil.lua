---@class MyFsOil
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_oil
end

M._spec_oil = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["oil.nvim"],
    lazy = false,
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
        "type",
        "permissions",
        "size",
        "mtime",
      },
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      win_options = {
        winbar = "%!v:lua.require'my.fs.oil'.winbar_expr()",
      },
      lsp_file_methods = {
        timeout_ms = my.config.lsp_file_ops_timeout_ms,
      },
      watch_for_changes = true,
      use_default_keymaps = false,
      view_options = {
        show_hidden = true,
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)

      M._autocmd_filetype()

      my.keymap.queue_km_group_load(my.config.keymaps.g_oil_____)
    end,
    dependencies = make_lzspec(plugins["mini.icons"]),
  }
  return spec
end

M._autocmd_filetype = function()
  my.autocmd.add_autocmd {
    group = "my.fs.oil.oil_buf_setup",
    event = "FileType",
    pattern = "oil",
    desc = 'Set options, vars and mappings for the "oil" filetype',
    callback = function(args)
      local buf_id = args.buf
      -- local did_ftplugin = my.config.did_ftplugin_buf[buf_id]
      -- if did_ftplugin == "oil" then return end
      -- my.config.did_ftplugin_buf[buf_id] = "oil"

      my.config.close_buf[buf_id] = M.close
      my.config.sync_buf[buf_id] = M.sync_buf_win
      my.config.goto_file_buf[buf_id] = M.goto_file
      my.config.goto_external_buf[buf_id] = M.goto_external
      my.config.get_file_path_func_buf[buf_id] = M.get_buf_file_path
      my.config.get_dir_path_func_buf[buf_id] = M.get_current_dir

      my.keymap.load_km_group(my.config.keymaps.b_oil_____, { buffer = buf_id })
    end,
  }
end

function M.close() --
  require("oil").close()
end

function M.get_buf_file_path() --
  local oil = require "oil"
  local entry = oil.get_cursor_entry()
  if entry and entry.id then return vim.fs.joinpath(oil.get_current_dir(), entry.name) end
end

function M.get_current_dir() --
  return require("oil").get_current_dir()
end

function M.goto_external() --
  require("oil.actions").open_external.callback()
end

function M.goto_file() --
  require("oil").select { close = true }
end

function M.sync_buf_win() --
  return require("oil").save({ confirm = true }, function(err)
    if err and err ~= "Canceled" then vim.notify(err, vim.log.levels.ERROR) end
    vim.schedule(vim.cmd.edit)
  end)
end

function M.winbar_expr() --
  local statusline_winid = vim.api.nvim_get_var "statusline_winid"
  local bufnr = vim.api.nvim_win_get_buf(statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    return vim.api.nvim_buf_get_name(0)
  end
end

local function open_from_buf()
  local buf_id = vim.api.nvim_get_current_buf()
  local get_dir_path_func = my.config.get_dir_path_func_buf[buf_id]
  local get_file_path_func = my.config.get_file_path_func_buf[buf_id]
  local file_path = get_file_path_func and get_file_path_func() or vim.api.nvim_buf_get_name(buf_id)
  local base_name = vim.fs.basename(file_path)
  local dir_path = get_dir_path_func and get_dir_path_func() or vim.fs.dirname(file_path or ".")
  local callback = base_name and function() --
    vim.fn.search(string.format("\\<%s$", base_name), "cw")
  end

  local close_buf_fixed_win = my.win.get_buf_fixed_win_toggler(true)
  close_buf_fixed_win()

  require("oil").open(dir_path, nil, callback)
end

M.keymaps = {}

M.keymaps.change_sort = { ---@type MyKeymapKeymapSpec
  desc = "Open oil.nvim (current file dir)",
  rhs = function() require("oil.actions").change_sort.callback() end,
}
M.keymaps.open_from_buf = { ---@type MyKeymapKeymapSpec
  desc = "Open oil.nvim (current file dir)",
  rhs = open_from_buf,
}
M.keymaps.open_from_input = { ---@type MyKeymapKeymapSpec
  desc = "Open oil.nvim (input)",
  rhs = ":Oil ",
}
M.keymaps.parent = { ---@type MyKeymapKeymapSpec
  desc = "Open oil.nvim (current file dir)",
  rhs = function() require("oil").open() end,
}
M.keymaps.preview = { ---@type MyKeymapKeymapSpec
  desc = "Open oil.nvim (current file dir)",
  rhs = function() require("oil.actions").preview.callback { vertical = true, split = "belowright" } end,
}
M.keymaps.select = { ---@type MyKeymapKeymapSpec
  desc = "Open oil.nvim (current file dir)",
  rhs = function() require("oil").select() end,
}
M.keymaps.toggle_hidden = { ---@type MyKeymapKeymapSpec
  desc = "Open oil.nvim (current file dir)",
  rhs = function() require("oil").toggle_hidden() end,
}

return M
