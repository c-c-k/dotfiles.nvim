local my = require "my"
---@class my.tab
local M = {}

local _list_tabpages_before_tab_leave = {}

local jump_label_to_tab_num = vim.iter(my.g.tab_labels:gmatch "."):enumerate():fold({}, function(acc, index, label)
  acc[label] = index
  return acc
end)

local function jump_by_label()
  local jump_label = vim.fn.keytrans(vim.fn.getcharstr(-1, { cursor = "msg", simplify = true }))
  local tab_num = jump_label:upper() == "<TAB>" and vim.fn.tabpagenr "#" or jump_label_to_tab_num[jump_label]
  if tab_num and tab_num <= vim.fn.tabpagenr "$" then
    my.keymap.force_normal_mode()
    vim.cmd.tabnext(tab_num)
  end
end

local function set_name() --
  local tab_id = vim.api.nvim_get_current_tabpage()
  local name = vim.fn.input "Enter tab name: "
  my.t[tab_id].name = name:len() > 0 and name or nil
end

M.tabline_expr = require("my.tab._tabline_expr").tabline_expression

M.autocmds = {}

M.autocmds.my_tab_closed = function()
  -- This is used as a workaround for the "TabClosed" event
  -- firing after the tab has already closed but returning
  -- the tab number rather than the tab id thus leaving no clean way
  -- to get the tab id of the closed tab.
  local augroup = my.autocmd.get_augroup("my.tab.tab_closed_workaround", true)
  my.autocmd.add_autocmd {
    desc = "record the list of tabpages on TabLeave.",
    group = augroup,
    event = "TabLeave",
    callback = function() --
      _list_tabpages_before_tab_leave = vim.api.nvim_list_tabpages()
    end,
  }
  my.autocmd.add_autocmd {
    desc = [[Trigger User("MyTabClosed") with tab id on "TabClosed"]],
    group = augroup,
    event = "TabClosed",
    callback = function(args) --
      local tab_num = tonumber(args.file)
      local tab_id = _list_tabpages_before_tab_leave[tab_num]
      vim.api.nvim_exec_autocmds("User", { pattern = "MyTabClosed", data = { tab_num = tab_num, tab_id = tab_id } })
    end,
  }
end

M.keymaps = {}
M.keymaps.close_current = { ---@type my.keymap.keymap_spec
  desc = "Close current tab",
  rhs = "<CMD>tabclose<CR>",
}
M.keymaps.goto_alt = { ---@type my.keymap.keymap_spec
  desc = "Go to tab (alt)",
  rhs = my.keymap.ESC .. "<CMD>tabnext #<CR>",
}
M.keymaps.goto_first = { ---@type my.keymap.keymap_spec
  desc = "Go to tab (first)",
  rhs = my.keymap.ESC .. "<CMD>tabfirst<CR>",
}
M.keymaps.goto_last = { ---@type my.keymap.keymap_spec
  desc = "Go to tab (last)",
  rhs = my.keymap.ESC .. "<CMD>tablast<CR>",
}
M.keymaps.goto_left = { ---@type my.keymap.keymap_spec
  desc = "Go to tab (left)",
  rhs = my.keymap.ESC .. "<CMD>tabprevious<CR>",
}
M.keymaps.goto_right = { ---@type my.keymap.keymap_spec
  desc = "Go to tab (right)",
  rhs = my.keymap.ESC .. "<CMD>tabnext<CR>",
}
M.keymaps.jump_by_label = { ---@type my.keymap.keymap_spec
  desc = "jump to tab by label",
  rhs = jump_by_label,
}
M.keymaps.move_alt = { ---@type my.keymap.keymap_spec
  desc = "Move tab (alt)",
  rhs = "<CMD>tabmove #<CR>",
}
M.keymaps.move_first = { ---@type my.keymap.keymap_spec
  desc = "Move tab (first)",
  rhs = "<CMD>0tabmove<CR>",
}
M.keymaps.move_last = { ---@type my.keymap.keymap_spec
  desc = "Move tab (last)",
  rhs = "<CMD>$tabmove<CR>",
}
M.keymaps.move_left = { ---@type my.keymap.keymap_spec
  desc = "Move tab (left)",
  rhs = "<CMD>-tabmove<CR>",
}
M.keymaps.move_right = { ---@type my.keymap.keymap_spec
  desc = "Move tab (right)",
  rhs = "<CMD>+tabmove<CR>",
}
M.keymaps.open_new_first = { ---@type my.keymap.keymap_spec
  desc = "Open new tab (first)",
  rhs = "<CMD>0tabedit<CR>",
}
M.keymaps.open_new_last = { ---@type my.keymap.keymap_spec
  desc = "Open new tab (last)",
  rhs = "<CMD>$tabedit<CR>",
}
M.keymaps.open_new_left = { ---@type my.keymap.keymap_spec
  desc = "Open new tab (left)",
  rhs = "<CMD>-tabedit<CR>",
}
M.keymaps.open_new_right = { ---@type my.keymap.keymap_spec
  desc = "Open new tab (right)",
  rhs = "<CMD>tabedit<CR>",
}
M.keymaps.set_name = { ---@type my.keymap.keymap_spec
  desc = "set tab name",
  rhs = set_name,
}

return M
