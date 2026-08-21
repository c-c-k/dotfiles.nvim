---@class MyCmp
---@field autopairs MyCmpAutopairs
---@field blink MyCmpBlink
---@field luasnip MyCmpLuasnip
---@field friendly_snippets MyCmpFriendlySnippets
---@field surround MyCmpSurround
local M = {}
M.init = { no_init = true, recurse = true } ---@type MyModuleInit

M.keymaps = {}
M.keymaps.add_blank_line_above = { ---@type MyKeymapKeymapSpec
  desc = "Add Blank line above",
  rhs = "O<ESC>0D",
}
M.keymaps.add_blank_line_below = { ---@type MyKeymapKeymapSpec
  desc = "Add Blank line below",
  rhs = "o<ESC>0D",
}
M.keymaps.cmd_history_next = { ---@type MyKeymapKeymapSpec
  desc = "cmd history next",
  rhs = "<DOWN>",
}
M.keymaps.cmd_history_prev = { ---@type MyKeymapKeymapSpec
  desc = "cmd history prev",
  rhs = "<UP>",
}
M.keymaps.insert_digraph = { ---@type MyKeymapKeymapSpec
  desc = "Insert digraph",
  rhs = "<C-K>",
}
M.keymaps.join_lines_i_ = { ---@type MyKeymapKeymapSpec
  desc = "Join Lines",
  rhs = "<C-O>J",
}
M.keymaps.join_lines_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Join Lines",
  rhs = "J",
}

return M
