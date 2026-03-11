local my = require "my"
---@class my.ft.markdown
local M = {}

M.a0_init = function()
  local setups = my.g.filetype_setup_autocmds
  setups[#setups + 1] = M.autocmds.filetype_setup

  local specks = my.g.lazy_filetype_specs
  specks[#specks + 1] = {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = M.opts.treesitter_integration,
  }
  specks[#specks + 1] = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = M.opts.mason_tool_installer_integration,
  }
  specks[#specks + 1] = {
    "tadmccorkle/markdown.nvim",
    optional = true,
    opts = M.opts.markdown_nvim_general,
  }
end

M.autocmds = {}
M.autocmds.filetype_setup = function()
  my.autocmd.add_autocmd {
    group = { "my.filetypes", false },
    event = "FileType",
    pattern = "markdown",
    desc = 'Set options, vars and mappings for the "markdown" filetype',
    callback = function(args)
      -- Override NVIM defaults.
      -- Needs to be done before the `did_ftplugin` check due to lazy.nvim emitting
      -- filetype autocommands multiple times and NVIM executing the default filetype
      -- config each time, see:
      --  * https://github.com/folke/lazy.nvim/issues/1993
      vim.opt_local.formatoptions = "tcroqwn2l1j"

      if vim.b[args.buf].did_ftplugin_my_markdown then return end
      vim.b[args.buf].did_ftplugin_my_markdown = true

      vim.b[args.buf].my_goto_file = M.goto_file
      vim.b[args.buf].my_goto_external = M.goto_external
    end,
  }
end

M.opts = {}
M.opts.markdown_nvim_general = function(_, opts)
  return my.tbl.merge_dicts_into_last(opts, {
    mappings = false,
    inline_surround = {
      emphasis = {
        key = "i",
        txt = "*",
      },
      strong = {
        key = "b",
        txt = "**",
      },
      strikethrough = {
        key = "s",
        txt = "~~",
      },
      code = {
        key = "c",
        txt = "`",
      },
    },
    link = {
      paste = {
        enable = true,
      },
    },
    toc = {
      omit_heading = "toc omit heading",
      omit_section = "toc omit section",
      markers = { "-" },
    },
    hooks = {
      follow_link = nil,
    },
    on_attach = function(bufnr) --
      my.keymap.load_km_group(my.config.keymaps.b_md_nvim_, { buffer = bufnr })
    end,
  })
end
M.opts.mason_tool_installer_integration = function(_, opts)
  opts.ensure_installed = my.tbl.merge_lists_into_first(opts.ensure_installed, { "marksman", "mdformat" })
end
M.opts.treesitter_integration = function(_, opts)
  if opts.ensure_installed ~= "all" then
    opts.ensure_installed = my.tbl.merge_lists_into_first(opts.ensure_installed, { "markdown", "markdown_inline" })
  end
end

function M.goto_external() --
  vim.cmd "MyGoToEx"
end

function M.goto_file() --
  vim.cmd "MyGoToFile"
end

function M.insert_list_item_above() --
  return require("markdown_nvim.list").insert_list_item_above()
end

function M.insert_list_item_below()
  local add_indent = vim.fn.getline("."):find ":%s*$"
  local did_insert = require("markdown_nvim.list").insert_list_item_below()
  return did_insert and not (add_indent and my.keymap.feed_termcodes_no_remap "<C-T>")
end

M.keymaps = {}

M.keymaps.change_emphasis = { ---@type my.keymap.keymap_spec
  desc = "md change emphasis",
  rhs = "<Plug>(markdown_change_emphasis)",
}
M.keymaps.current_heading = { ---@type my.keymap.keymap_spec
  desc = "MD current heading",
  rhs = "<Plug>(markdown_go_current_heading)",
}
M.keymaps.delete_emphasis = { ---@type my.keymap.keymap_spec
  desc = "md delete emphasis",
  rhs = "<Plug>(markdown_delete_emphasis)",
}
M.keymaps.next_heading = { ---@type my.keymap.keymap_spec
  desc = "MD next heading",
  rhs = "<Plug>(markdown_go_next_heading)",
}
M.keymaps.parent_heading = { ---@type my.keymap.keymap_spec
  desc = "MD parent heading",
  rhs = "<Plug>(markdown_go_parent_heading)",
}
M.keymaps.prev_heading = { ---@type my.keymap.keymap_spec
  desc = "MD prev heading",
  rhs = "<Plug>(markdown_go_prev_heading)",
}
M.keymaps.super_newline_above_n_ = { ---@type my.keymap.keymap_spec
  desc = "MD super NL above",
  expr = true,
  rhs = function() return M.insert_list_item_above() and "" or "O" end,
}
M.keymaps.super_newline_below_n_ = { ---@type my.keymap.keymap_spec
  desc = "MD super NL below",
  expr = true,
  rhs = function() return M.insert_list_item_below() and "" or "o" end,
}
M.keymaps.super_newline_below_i_ = { ---@type my.keymap.keymap_spec
  desc = "MD super NL below",
  expr = true,
  rhs = function() return M.insert_list_item_below() and "" or "<CR>" end,
}
M.keymaps.toggle_checkbox_n_ = { ---@type my.keymap.keymap_spec
  desc = "Toggle MD checkbox",
  rhs = "<Cmd>MDTaskToggle<CR>",
}
M.keymaps.toggle_checkbox_x_ = { ---@type my.keymap.keymap_spec
  desc = "Toggle MD checkbox",
  rhs = ":MDTaskToggle<CR>",
}
M.keymaps.toggle_emphasis_line = { ---@type my.keymap.keymap_spec
  desc = "md toggle emphasis line",
  rhs = "<Plug>(markdown_toggle_emphasis_line)",
}
M.keymaps.toggle_emphasis_n_ = { ---@type my.keymap.keymap_spec
  desc = "md toggle emphasis",
  rhs = "<Plug>(markdown_toggle_emphasis)",
}
M.keymaps.toggle_emphasis_x_ = { ---@type my.keymap.keymap_spec
  desc = "md toggle emphasis",
  rhs = "<Plug>(markdown_toggle_emphasis_visual)",
}

return M
