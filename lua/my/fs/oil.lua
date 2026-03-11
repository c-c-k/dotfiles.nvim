local my = require "my"
---@class my.fs.oil
local M = {}

M.opts = {}
M.opts.general = function(_, opts) ---@cast opts MyNoOptsSpec
  return my.tbl.merge_dicts_into_last(opts, {
    columns = {
      "icon",
      "type",
      "permissions",
      "size",
      "mtime",
    },
    win_options = {
      winbar = "%!v:lua.require'my.fs.oil'.winbar_expr()",
    },
    lsp_file_methods = {
      timeout_ms = my.g.lsp_file_ops_timeout_ms,
    },
    watch_for_changes = true,
    use_default_keymaps = false,
    view_options = {
      show_hidden = true,
      case_insensitive = true,
    },
  } --[[@as MyNoOptsSpec]])
end
M.opts.core_integration = function()
  my.autocmd.add_autocmd {
    group = "my.fs.oil.oil_buf_setup",
    event = "FileType",
    pattern = "oil",
    desc = 'Set options, vars and mappings for the "oil" filetype',
    callback = function(args)
      if vim.b[args.buf].did_ftplugin_my_oil then return end
      vim.b[args.buf].did_ftplugin_my_oil = true

      vim.b[args.buf].my_close_buf = my.fs.oil.close
      vim.b[args.buf].my_sync_buf_win = my.fs.oil.sync_buf_win
      vim.b[args.buf].my_goto_file = my.fs.oil.goto_file
      vim.b[args.buf].my_goto_external = my.fs.oil.goto_external
      vim.b[args.buf].my_get_buf_file_path = my.fs.oil.get_buf_file_path
      vim.b[args.buf].my_get_buf_dir_path = my.fs.oil.get_current_dir

      my.keymap.load_km_group(my.config.keymaps.b_oil_____, { buffer = args.buf })
    end,
  }

  my.keymap.queue_km_group_load(my.config.keymaps.g_oil_____)
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
  require("oil.actions").open_external()
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
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    return vim.api.nvim_buf_get_name(0)
  end
end

local function open_from_buf()
  local dir_path = (
    (vim.b.my_get_buf_file_path and vim.fs.dirname(vim.b.my_get_buf_file_path()))
    or (vim.b.my_get_buf_dir_path and vim.b.my_get_buf_dir_path())
    or vim.fs.dirname(vim.api.nvim_buf_get_name(0) or ".")
  )
  local base_name = (
    (vim.b.my_get_buf_file_path and vim.fs.basename(vim.b.my_get_buf_file_path()))
    or vim.fs.basename(vim.api.nvim_buf_get_name(0))
  )
  local cb = base_name and function() --
    vim.fn.search(string.format("\\<%s$", base_name), "cw")
  end

  my.win.get_on_buf_change_win_toggler()()
  require("oil").open(dir_path, nil, cb)
end

M.keymaps = {}

M.keymaps.change_sort = { ---@type my.keymap.keymap_spec
  desc = "Open oil.nvim (current file dir)",
  rhs = function() require("oil.actions").change_sort() end,
}
M.keymaps.open_from_buf = { ---@type my.keymap.keymap_spec
  desc = "Open oil.nvim (current file dir)",
  rhs = open_from_buf,
}
M.keymaps.open_from_input = { ---@type my.keymap.keymap_spec
  desc = "Open oil.nvim (input)",
  rhs = ":Oil ",
}
M.keymaps.parent = { ---@type my.keymap.keymap_spec
  desc = "Open oil.nvim (current file dir)",
  rhs = function() require("oil.actions").parent() end,
}
M.keymaps.preview = { ---@type my.keymap.keymap_spec
  desc = "Open oil.nvim (current file dir)",
  rhs = function() require("oil.actions").preview() end,
}
M.keymaps.select = { ---@type my.keymap.keymap_spec
  desc = "Open oil.nvim (current file dir)",
  rhs = function() require("oil.actions").select() end,
}
M.keymaps.show_help = { ---@type my.keymap.keymap_spec
  desc = "Open oil.nvim (current file dir)",
  rhs = function() require("oil.actions").show_help() end,
}
M.keymaps.toggle_hidden = { ---@type my.keymap.keymap_spec
  desc = "Open oil.nvim (current file dir)",
  rhs = function() require("oil.actions").toggle_hidden() end,
}

return M
