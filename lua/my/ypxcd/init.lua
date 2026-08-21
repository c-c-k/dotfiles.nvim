---@class MyYpxcd
local M = {}
M.init = { no_init = true, recurse = false } ---@type MyModuleInit

local my = require "my"

M.keymaps = {}

M.keymaps.black_hole_change = { ---@type MyKeymapKeymapSpec
  desc = "black hole change",
  rhs = '"_c',
}
M.keymaps.black_hole_change_to_end = { ---@type MyKeymapKeymapSpec
  desc = "black hole Change",
  rhs = '"_C',
}
M.keymaps.black_hole_delete = { ---@type MyKeymapKeymapSpec
  desc = "black hole delete",
  rhs = '"_d',
}
M.keymaps.black_hole_delete_to_end = { ---@type MyKeymapKeymapSpec
  desc = "black hole Delete",
  rhs = '"_D',
}
M.keymaps.choose_register = { ---@type MyKeymapKeymapSpec
  desc = 'alternate " (choose register)',
  rhs = '"',
}
M.keymaps.paste_ask_register_i_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (ask register)",
  expr = true,
  rhs = "'<C-R>'.nr2char(getchar())",
}
M.keymaps.paste_ask_register_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (ask register)",
  expr = true,
  rhs = "'a<C-R>'.nr2char(getchar()).'<ESC>'",
}
M.keymaps.paste_ask_register_t_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (ask register)",
  expr = true,
  rhs = my.keymap.ESC .. "'\"'.nr2char(getchar()).'pi'",
}
M.keymaps.paste_ask_register_x_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (ask register)",
  expr = true,
  rhs = "'c<C-R>'.nr2char(getchar()).'<ESC>'",
}
M.keymaps.paste_clipboard_i_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (clipboard)",
  rhs = "<C-R>+",
}
M.keymaps.paste_clipboard_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (clipboard)",
  rhs = "a<C-R>+<ESC>",
}
M.keymaps.paste_clipboard_t_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (clipboard)",
  rhs = my.keymap.ESC .. '"+pi',
}
M.keymaps.paste_clipboard_x_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (clipboard)",
  rhs = "c<C-R>+<ESC>",
}
M.keymaps.paste_indented_after = { ---@type MyKeymapKeymapSpec
  desc = "Paste indented after",
  rhs = "]p",
}
M.keymaps.paste_indented_before = { ---@type MyKeymapKeymapSpec
  desc = "Paste indented before",
  rhs = "[p",
}
M.keymaps.paste_selection_i_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (selection)",
  rhs = "<C-R>*",
}
M.keymaps.paste_selection_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (selection)",
  rhs = "a<C-R>*<ESC>",
}
M.keymaps.paste_selection_t_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (selection)",
  rhs = my.keymap.ESC .. '"*pi',
}
M.keymaps.paste_selection_x_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (selection)",
  rhs = "c<C-R>*<ESC>",
}
M.keymaps.paste_unnamed_i_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (unnamed)",
  rhs = '<C-R>"',
}
M.keymaps.paste_unnamed_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (unnamed)",
  rhs = 'a<C-R>"<ESC>',
}
M.keymaps.paste_unnamed_t_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (unnamed)",
  rhs = my.keymap.ESC .. '""pi',
}
M.keymaps.paste_unnamed_x_ = { ---@type MyKeymapKeymapSpec
  desc = "Paste (unnamed)",
  rhs = '"_c<C-R>"<ESC>',
}
M.keymaps.prepend_alt_buf_dir_reg = { ---@type MyKeymapKeymapSpec
  desc = "prepend alt buf dir reg",
  rhs = "\"=expand('#:h')<CR>",
}
M.keymaps.prepend_alt_buf_name_reg = { ---@type MyKeymapKeymapSpec
  desc = "prepend alt buf name reg",
  rhs = '"#',
}
M.keymaps.prepend_buf_dir_reg = { ---@type MyKeymapKeymapSpec
  desc = "prepend buf dir reg",
  rhs = "\"=expand('%:h')<CR>",
}
M.keymaps.prepend_buf_name_reg = { ---@type MyKeymapKeymapSpec
  desc = "prepend buf name reg",
  rhs = '"%',
}
M.keymaps.prepend_clipboard_reg = { ---@type MyKeymapKeymapSpec
  desc = "prepend clipboard reg",
  rhs = '"+',
}
M.keymaps.prepend_expr_reg = { ---@type MyKeymapKeymapSpec
  desc = "prepend expr reg",
  rhs = '"=',
}
M.keymaps.prepend_selection_reg = { ---@type MyKeymapKeymapSpec
  desc = "prepend selection reg",
  rhs = '"*',
}

return M
