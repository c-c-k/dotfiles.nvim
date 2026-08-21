local my = require "my"
---@class MySetupToggles
local M = {}

M.auto_cd_root = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "auto_cd_root",
    name = "auto cd root",
    get = my.fs.cd.auto_cd_root_is_enabled_global,
    set = my.fs.cd.auto_cd_root_toggle_global,
  },
}

M.autopairs = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "autopairs",
    name = "autopairs",
    get = my.cmp.autopairs.autopairs_is_enabled_global,
    set = my.cmp.autopairs.autopairs_toggle_global,
  },
}

M.cmp_buf = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "b_cmp",
    name = "Buffer cmp",
    get = my.cmp.blink.cmp_is_enabled_buf,
    set = my.cmp.blink.cmp_toggle_buf,
  },
}

M.cmp_global = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "g_cmp",
    name = "Global cmp",
    get = my.cmp.blink.cmp_is_enabled,
    set = my.cmp.blink.cmp_toggle,
  },
}

M.conceallevel = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "option",
    vim_option = "conceallevel",
    on = 0,
    off = 2,
    global = false,
  },
}

M.foldcolumn = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "option",
    vim_option = "foldcolumn",
    on = vim.o.foldcolumn,
    off = 0,
    global = false,
  },
}

-- NOTE: Gave up on "proper" illuminate.vim toggles as it doesn't
--       expose any variables or functions to check if it's currently
--       active and trying to create a workaround felt like it took
--       too much time for too little gain.

M.illuminate_freeze_buf = { ---@type MyKeymapKeymapSpec
  desc = "Freeze buffer illuminate <cword>",
  rhs = function() require("illuminate").toggle_freeze_buf() end,
}

M.illuminate_invisible_buf = { ---@type MyKeymapKeymapSpec
  desc = "Invisible buffer illuminate <cword>",
  rhs = function() require("illuminate").toggle_visibility_buf() end,
}

M.illuminate_pause_buf = { ---@type MyKeymapKeymapSpec
  desc = "Pause buffer illuminate <cword>",
  rhs = function() require("illuminate").toggle_buf() end,
}

M.illuminate_pause_global = { ---@type MyKeymapKeymapSpec
  desc = "Pause global illuminate <cword>",
  rhs = function() require("illuminate").toggle_pause() end,
}

M.indent_buf = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "indent_buffer",
    name = "Indent Guides (Buffer)",
    get = my.syntax.indent.is_enabled_buf,
    set = my.syntax.indent.toggle_buf,
  },
}

M.indent_global = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "indent_global",
    name = "Indent Guides (Global)",
    get = my.syntax.indent.is_enabled,
    set = my.syntax.indent.toggle,
  },
}

M.laststatus = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "option",
    vim_option = "laststatus",
    on = 0,
    off = 3,
    global = true,
  },
}

M.lsp_codelens_buf = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "buf_lsp_codelens",
    name = "buffer LSP codelens",
    get = my.lsp.codelens_is_enabled_buf,
    set = my.lsp.codelens_toggle_buf,
  },
}

M.lsp_codelens_global = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "global_lsp_codelens",
    name = "Global LSP codelens",
    get = my.lsp.codelens_is_enabled_global,
    set = my.lsp.codelens_toggle_global,
  },
}

M.lsp_diagnostics_buf = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "buf_diagnostics",
    name = "Buffer diagnostics",
    get = function() return vim.diagnostic.is_enabled { bufnr = 0 } end,
    set = function(enable) vim.diagnostic.enable(enable, { bufnr = 0 }) end,
  },
}

M.lsp_diagnostics_global = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "global_diagnostics",
    name = "Global diagnostics",
    get = vim.diagnostic.is_enabled,
    set = function(enable) vim.diagnostic.enable(enable) end,
  },
}

M.lsp_format_buf = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "buf_lsp_format",
    name = "buffer LSP formatting",
    get = my.lsp.format_is_enabled_buf,
    set = my.lsp.format_toggle_buf,
  },
}

M.lsp_format_global = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "global_lsp_format",
    name = "Global LSP formatting",
    get = my.lsp.format_is_enabled_global,
    set = my.lsp.format_toggle_global,
  },
}

M.lsp_format_on_save_buf = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "buf_lsp_format_on_save",
    name = "buffer LSP format on save",
    get = my.lsp.format_on_save_is_enabled_buf,
    set = my.lsp.format_on_save_toggle_buf,
  },
}

M.lsp_format_on_save_global = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "global_lsp_format_on_save",
    name = "Global LSP format on save",
    get = my.lsp.format_on_save_is_enabled_global,
    set = my.lsp.format_on_save_toggle_global,
  },
}

M.lsp_inlay_hint_buf = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "inlay_hint_buffer",
    name = "LSP Inlay hints (Buffer)",
    get = my.lsp.inlay_hint_is_enabled_buf,
    set = my.lsp.inlay_hint_toggle_buf,
  },
}

M.lsp_inlay_hint_global = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "inlay_hint_global",
    name = "LSP Inlay hints (Global)",
    get = my.lsp.inlay_hint_is_enabled_global,
    set = my.lsp.inlay_hint_toggle_global,
  },
}

M.lsp_virtual_lines = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "virtual_lines",
    name = "LSP diagnostics virtual lines",
    get = my.lsp.diagnostics_virtual_lines_is_enabled_global,
    set = my.lsp.diagnostics_virtual_lines_toggle_global,
  },
}

M.lsp_virtual_text = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "virtual_text",
    name = "LSP diagnostics virtual text",
    get = my.lsp.diagnostics_virtual_text_is_enabled_global,
    set = my.lsp.diagnostics_virtual_text_toggle_global,
  },
}

M.number = { ---@type MyKeymapKeymapSpec
  wk_toggle = { type = "option", vim_option = "number" },
}

M.relativenumber = { ---@type MyKeymapKeymapSpec
  wk_toggle = { type = "option", vim_option = "relativenumber" },
}

M.showtabline = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "option",
    vim_option = "showtabline",
    on = 0,
    off = 2,
    global = true,
  },
}

M.signcolumn = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "option",
    vim_option = "signcolumn",
    on = "auto",
    off = "no",
    global = false,
  },
}

M.spell = { ---@type MyKeymapKeymapSpec
  wk_toggle = { type = "option", vim_option = "spell" },
}

M.syntax_hl_full_buf = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "buf_full_hl",
    name = "Toggle syntax/treesitter and LSP highlighting",
    get = my.syntax.syntax_hl_is_enabled_buf,
    set = my.syntax.syntax_hl_toggle_buf,
  },
}

M.syntax_hl_lsp_buf = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "buf_lsp_semantic_hl",
    name = "buffer LSP semantic token highlighting",
    get = my.lsp.semantic_hl_is_enabled_buf,
    set = my.lsp.semantic_hl_toggle_buf,
  },
}

M.syntax_hl_regex_buf = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "buf_syntax_hl",
    name = "buffer regex syntax highlighting",
    get = my.syntax.regex.syntax_hl_is_enabled_buf,
    set = my.syntax.regex.syntax_hl_toggle_buf,
  },
}

M.syntax_hl_ts_buf = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "buf_ts_hl",
    name = "buffer treesitter highlighting",
    get = my.syntax.ts.syntax_hl_is_enabled_buf,
    set = my.syntax.ts.syntax_hl_toggle_buf,
  },
}

M.toggle_notify = { ---@type MyKeymapKeymapSpec
  wk_toggle = {
    type = "basic",
    id = "toggle_notify",
    name = "show UI toggle notifications",
    get = my.ui.toggle.notifications_is_enabled,
    set = my.ui.toggle.notifications_toggle,
  },
}

M.wrap = { ---@type MyKeymapKeymapSpec
  wk_toggle = { type = "option", vim_option = "wrap" },
}

return M
