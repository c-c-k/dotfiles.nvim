local my = require "my"
---@class MyTab
local M = {}
M.init = { no_init = true, recurse = false } ---@type MyModuleInit

local jump_label_to_tab_num = vim.iter(my.config.tab_labels:gmatch "."):enumerate():fold({}, function(acc, index, label)
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
  my.config.name_tab[tab_id] = name:len() > 0 and name or nil
end

M.tabline_expr = require("my.tab._tabline_expr").tabline_expression

M.keymaps = {}
M.keymaps.close_current = { ---@type MyKeymapKeymapSpec
  desc = "Close current tab",
  rhs = "<CMD>tabclose<CR>",
}
M.keymaps.goto_alt = { ---@type MyKeymapKeymapSpec
  desc = "Go to tab (alt)",
  rhs = my.keymap.ESC .. "<CMD>tabnext #<CR>",
}
M.keymaps.goto_first = { ---@type MyKeymapKeymapSpec
  desc = "Go to tab (first)",
  rhs = my.keymap.ESC .. "<CMD>tabfirst<CR>",
}
M.keymaps.goto_last = { ---@type MyKeymapKeymapSpec
  desc = "Go to tab (last)",
  rhs = my.keymap.ESC .. "<CMD>tablast<CR>",
}
M.keymaps.goto_left = { ---@type MyKeymapKeymapSpec
  desc = "Go to tab (left)",
  rhs = my.keymap.ESC .. "<CMD>tabprevious<CR>",
}
M.keymaps.goto_right = { ---@type MyKeymapKeymapSpec
  desc = "Go to tab (right)",
  rhs = my.keymap.ESC .. "<CMD>tabnext<CR>",
}
M.keymaps.jump_by_label = { ---@type MyKeymapKeymapSpec
  desc = "jump to tab by label",
  rhs = jump_by_label,
}
M.keymaps.move_alt = { ---@type MyKeymapKeymapSpec
  desc = "Move tab (alt)",
  rhs = "<CMD>tabmove #<CR>",
}
M.keymaps.move_first = { ---@type MyKeymapKeymapSpec
  desc = "Move tab (first)",
  rhs = "<CMD>0tabmove<CR>",
}
M.keymaps.move_last = { ---@type MyKeymapKeymapSpec
  desc = "Move tab (last)",
  rhs = "<CMD>$tabmove<CR>",
}
M.keymaps.move_left = { ---@type MyKeymapKeymapSpec
  desc = "Move tab (left)",
  rhs = "<CMD>-tabmove<CR>",
}
M.keymaps.move_right = { ---@type MyKeymapKeymapSpec
  desc = "Move tab (right)",
  rhs = "<CMD>+tabmove<CR>",
}
M.keymaps.open_new_first = { ---@type MyKeymapKeymapSpec
  desc = "Open new tab (first)",
  rhs = "<CMD>0tabedit<CR>",
}
M.keymaps.open_new_last = { ---@type MyKeymapKeymapSpec
  desc = "Open new tab (last)",
  rhs = "<CMD>$tabedit<CR>",
}
M.keymaps.open_new_left = { ---@type MyKeymapKeymapSpec
  desc = "Open new tab (left)",
  rhs = "<CMD>-tabedit<CR>",
}
M.keymaps.open_new_right = { ---@type MyKeymapKeymapSpec
  desc = "Open new tab (right)",
  rhs = "<CMD>tabedit<CR>",
}
M.keymaps.set_name = { ---@type MyKeymapKeymapSpec
  desc = "set tab name",
  rhs = set_name,
}

return M
