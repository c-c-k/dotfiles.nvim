local my = require "my"
---@class my.config.toggles
local M = {}

M.auto_cd_root = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "auto_cd_root",
      name = "auto cd root",
      get = my.fs.cd.auto_cd_root_is_enabled_global,
      set = my.fs.cd.auto_cd_root_toggle_global,
    }, opts)
  end,
}

M.autopairs = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "autopairs",
      name = "autopairs",
      get = my.cmp.autopairs.autopairs_is_enabled_global,
      set = my.cmp.autopairs.autopairs_toggle_global,
    }, opts)
  end,
}

M.cmp_buf = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "b_cmp",
      name = "Buffer cmp",
      get = my.cmp.blink.cmp_is_enabled_buf,
      set = my.cmp.blink.cmp_toggle_buf,
    }, opts)
  end,
}

M.cmp_global = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "g_cmp",
      name = "Global cmp",
      get = function() return my.bp.cmp_enabled:get(my.vp.GLOBAL_DEFAULT) end,
      set = function(enable) my.bp.cmp_enabled:set(my.vp.GLOBAL_DEFAULT, enable) end,
    }, opts)
  end,
}

M.conceallevel = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    opts = my.tbl.merge_dicts_into_last(opts, { on = 0, off = 2, global = false })
    return require("snacks").toggle.option("conceallevel", opts)
  end,
}

M.diagnostics_buf = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "buf_diagnostics",
      name = "Buffer diagnostics",
      get = function() return vim.diagnostic.is_enabled { bufnr = 0 } end,
      set = function(enable) vim.diagnostic.enable(enable, { bufnr = 0 }) end,
    }, opts)
  end,
}

M.diagnostics_global = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "global_diagnostics",
      name = "Global diagnostics",
      get = vim.diagnostic.is_enabled,
      set = function(state) vim.diagnostic.enable(state) end,
    }, opts)
  end,
}

M.foldcolumn = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    opts = my.tbl.merge_dicts_into_last(opts, { on = vim.o.foldcolumn, off = 0, global = false })
    return require("snacks").toggle.option("foldcolumn", opts)
  end,
}

M.illuminate_freeze_buf = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "b_illuminate_freeze",
      name = "Freeze buffer illuminate <cword>",
      get = my.syntax.illuminate.is_freeze_buf,
      set = my.syntax.illuminate.toggle_freeze_buf,
    }, opts)
  end,
}

M.illuminate_invisible_buf = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "b_illuminate_invisible",
      name = "Invisible buffer illuminate <cword>",
      get = my.syntax.illuminate.is_invisible_buf,
      set = my.syntax.illuminate.toggle_invisible_buf,
    }, opts)
  end,
}

M.illuminate_pause_buf = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "b_illuminate_pause",
      name = "Pause buffer illuminate <cword>",
      get = my.syntax.illuminate.is_pause_buf,
      set = my.syntax.illuminate.toggle_pause_buf,
    }, opts)
  end,
}

M.illuminate_invisible_global = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "g_illuminate_invisible",
      name = "invisible global illuminate <cword>",
      get = my.syntax.illuminate.is_invisible_global,
      set = my.syntax.illuminate.toggle_invisible_global,
    }, opts)
  end,
}

M.illuminate_pause_global = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "g_illuminate_pause",
      name = "Pause global illuminate <cword>",
      get = my.syntax.illuminate.is_pause_global,
      set = my.syntax.illuminate.toggle_pause_global,
    }, opts)
  end,
}

M.indent_buf = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "indent_buffer",
      name = "Indent Guides (Buffer)",
      get = my.syntax.indent.is_enabled_buf,
      set = my.syntax.indent.toggle_buf,
    }, opts)
  end,
}

M.indent_global = { ---@type my.keymap.keymap_spec
  wk_toggle = function()
    local _toggle = require("snacks").toggle.indent()
    _toggle.opts.id = "indent_global"
    _toggle.opts.name = "Indent Guides (Global)"
    return _toggle
  end,
}

M.laststatus = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    opts = my.tbl.merge_dicts_into_last(opts, { on = 0, off = 3, global = true })
    return require("snacks").toggle.option("laststatus", opts)
  end,
}

M.lsp_codelens_buf = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "buf_lsp_codelens",
      name = "buffer LSP codelens",
      get = my.lsp.codelens_is_enabled_buf,
      set = my.lsp.codelens_toggle_buf,
    }, opts)
  end,
}

M.lsp_codelens_global = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "global_lsp_codelens",
      name = "Global LSP codelens",
      get = my.lsp.codelens_is_enabled_global,
      set = my.lsp.codelens_toggle_global,
    }, opts)
  end,
}

M.lsp_format_buf = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "buf_lsp_format",
      name = "buffer LSP formatting",
      get = my.lsp.format_is_enabled_buf,
      set = my.lsp.format_toggle_buf,
    }, opts)
  end,
}

M.lsp_format_global = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "global_lsp_format",
      name = "Global LSP formatting",
      get = my.lsp.format_is_enabled_global,
      set = my.lsp.format_toggle_global,
    }, opts)
  end,
}

M.lsp_format_on_save_buf = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "buf_lsp_format_on_save",
      name = "buffer LSP format on save",
      get = my.lsp.format_on_save_is_enabled_buf,
      set = my.lsp.format_on_save_toggle_buf,
    }, opts)
  end,
}

M.lsp_format_on_save_global = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "global_lsp_format_on_save",
      name = "Global LSP format on save",
      get = my.lsp.format_on_save_is_enabled_global,
      set = my.lsp.format_on_save_toggle_global,
    }, opts)
  end,
}

M.lsp_inlay_hint_buf = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "inlay_hint_buffer",
      name = "LSP Inlay hints (Buffer)",
      get = my.lsp.inlay_hint_is_enabled_buf,
      set = my.lsp.inlay_hint_toggle_buf,
    }, opts)
  end,
}

M.lsp_inlay_hint_global = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "inlay_hint_global",
      name = "LSP Inlay hints (Global)",
      get = my.lsp.inlay_hint_is_enabled_global,
      set = my.lsp.inlay_hint_toggle_global,
    }, opts)
  end,
}

M.number = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts) return require("snacks").toggle.option("number", opts) end,
}

M.relativenumber = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts) return require("snacks").toggle.option("relativenumber", opts) end,
}

M.showtabline = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    opts = my.tbl.merge_dicts_into_last(opts, { on = 0, off = 2, global = true })
    return require("snacks").toggle.option("showtabline", opts)
  end,
}

M.signcolumn = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    opts = my.tbl.merge_dicts_into_last(opts, { on = "auto", off = "no", global = false })
    return require("snacks").toggle.option("signcolumn", opts)
  end,
}

M.spell = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts) return require("snacks").toggle.option("spell", opts) end,
}

M.syntax_hl_full_buf = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "buf_full_hl",
      name = "Toggle syntax/treesitter and LSP highlighting",
      get = my.syntax.syntax_hl_is_enabled_buf,
      set = my.syntax.syntax_hl_toggle_buf,
    }, opts)
  end,
}

M.syntax_hl_lsp_buf = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "buf_lsp_semantic_hl",
      name = "buffer LSP semantic token highlighting",
      get = my.lsp.semantic_hl_is_enabled_buf,
      set = my.lsp.semantic_hl_toggle_buf,
    }, opts)
  end,
}

M.syntax_hl_regex_buf = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "buf_syntax_hl",
      name = "buffer regex syntax highlighting",
      get = my.syntax.regex.syntax_hl_is_enabled_buf,
      set = my.syntax.regex.syntax_hl_toggle_buf,
    }, opts)
  end,
}

M.syntax_hl_ts_buf = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "buf_ts_hl",
      name = "buffer treesitter highlighting",
      get = my.syntax.ts.syntax_hl_is_enabled_buf,
      set = my.syntax.ts.syntax_hl_toggle_buf,
    }, opts)
  end,
}

M.toggle_notify = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    return require("snacks").toggle.new({
      id = "toggle_notify",
      name = "show UI toggle notifications",
      get = my.ui.toggle.notifications_is_enabled,
      set = my.ui.toggle.notifications_toggle,
    }, opts)
  end,
}

M.virtual_lines = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    local previous_virtual_lines
    return require("snacks").toggle.new({
      id = "virtual_lines",
      name = "Toggle diagnostics virtual lines",
      get = function() return vim.diagnostic.config().virtual_lines and true or false end,
      set = function(state)
        local new_virtual_lines = false
        if state then
          new_virtual_lines = previous_virtual_lines or true
          previous_virtual_lines = false
        else
          previous_virtual_lines = vim.diagnostic.config().virtual_lines
        end
        vim.diagnostic.config { virtual_lines = new_virtual_lines }
      end,
    }, opts)
  end,
}

M.virtual_text = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts)
    local previous_virtual_text
    return require("snacks").toggle.new({
      id = "virtual_text",
      name = "Toggle diagnostics virtual text",
      get = function() return vim.diagnostic.config().virtual_text and true or false end,
      set = function(state)
        local new_virtual_text = false
        if state then
          new_virtual_text = previous_virtual_text or true
          previous_virtual_text = false
        else
          previous_virtual_text = vim.diagnostic.config().virtual_text
        end
        vim.diagnostic.config { virtual_text = new_virtual_text }
      end,
    }, opts)
  end,
}

M.wrap = { ---@type my.keymap.keymap_spec
  ---@param opts? snacks.toggle.Config
  wk_toggle = function(opts) return require("snacks").toggle.option("wrap", opts) end,
}

return M
