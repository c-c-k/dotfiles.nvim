local my = require "my"
---@class my.git.gitsigns
local M = {}

M.opts = {}
M.opts.general = function(_, opts) ---@cast opts MyNoOptsSpec
  return my.tbl.merge_dicts_into_last(opts, {
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signs_staged = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    attach_to_untracked = true,
    on_attach = function(bufnr) --
      my.keymap.load_km_group(my.config.keymaps.b_gitsigns, { buffer = bufnr })
    end,
  } --[[@as MyNoOptsSpec]])
end

M.keymaps = {}

M.keymaps.blame_line = { ---@type my.keymap.keymap_spec
  desc = "View Git blame",
  rhs = function() require("gitsigns").blame_line() end,
}
M.keymaps.blame_line_full = { ---@type my.keymap.keymap_spec
  desc = "View full Git blame",
  rhs = function() require("gitsigns").blame_line { full = true } end,
}
M.keymaps.diff_custom = { ---@type my.keymap.keymap_spec
  desc = "View Git diff(custom)",
  rhs = ":Gitsigns diffthis ~",
}
M.keymaps.diff_with_head = { ---@type my.keymap.keymap_spec
  desc = "View Git diff(head)",
  rhs = function() require("gitsigns").diffthis "@" end,
}
M.keymaps.diff_with_index = { ---@type my.keymap.keymap_spec
  desc = "View Git diff(index)",
  rhs = function() require("gitsigns").diffthis() end,
}
M.keymaps.diff_with_last_commit = { ---@type my.keymap.keymap_spec
  desc = "View Git diff(last commit)",
  rhs = function() require("gitsigns").diffthis "~1" end,
}
M.keymaps.first_hunk_all = { ---@type my.keymap.keymap_spec
  desc = "First Git hunk (all hunks)",
  rhs = function() require("gitsigns").nav_hunk("first", { target = "all" }) end,
}
M.keymaps.first_hunk_staged = { ---@type my.keymap.keymap_spec
  desc = "First Git Undo (staged hunks)",
  rhs = function() require("gitsigns").nav_hunk("first", { target = "staged" }) end,
}
M.keymaps.first_hunk_unstaged = { ---@type my.keymap.keymap_spec
  desc = "First Git Change (unstaged hunks)",
  rhs = function() require("gitsigns").nav_hunk("first", { target = "unstaged" }) end,
}
M.keymaps.last_hunk_all = { ---@type my.keymap.keymap_spec
  desc = "Last Git hunk (all hunks)",
  rhs = function() require("gitsigns").nav_hunk("last", { target = "all" }) end,
}
M.keymaps.last_hunk_staged = { ---@type my.keymap.keymap_spec
  desc = "Last Git Undo (staged hunks)",
  rhs = function() require("gitsigns").nav_hunk("last", { target = "staged" }) end,
}
M.keymaps.last_hunk_unstaged = { ---@type my.keymap.keymap_spec
  desc = "Last Git Change (unstaged hunks)",
  rhs = function() require("gitsigns").nav_hunk("last", { target = "unstaged" }) end,
}
M.keymaps.next_hunk_all = { ---@type my.keymap.keymap_spec
  desc = "Next Git hunk (all hunks)",
  rhs = function() require("gitsigns").nav_hunk("next", { target = "all" }) end,
}
M.keymaps.next_hunk_staged = { ---@type my.keymap.keymap_spec
  desc = "Next Git Undo (staged hunks)",
  rhs = function() require("gitsigns").nav_hunk("next", { target = "staged" }) end,
}
M.keymaps.next_hunk_unstaged = { ---@type my.keymap.keymap_spec
  desc = "Next Git Change (unstaged hunks)",
  rhs = function()
    if vim.wo.diff then return vim.cmd "norm! [c" end
    require("gitsigns").nav_hunk("next", { target = "unstaged" })
  end,
}
M.keymaps.prev_hunk_all = { ---@type my.keymap.keymap_spec
  desc = "Previos Git hunk (all hunks)",
  rhs = function() require("gitsigns").nav_hunk("prev", { target = "all" }) end,
}
M.keymaps.prev_hunk_staged = { ---@type my.keymap.keymap_spec
  desc = "Previos Git Undo (staged hunks)",
  rhs = function() require("gitsigns").nav_hunk("prev", { target = "staged" }) end,
}
M.keymaps.prev_hunk_unstaged = { ---@type my.keymap.keymap_spec
  desc = "Previos Git Change (unstaged hunks)",
  rhs = function()
    if vim.wo.diff then return vim.cmd "norm! ]c" end
    require("gitsigns").nav_hunk("prev", { target = "unstaged" })
  end,
}
M.keymaps.preview_hunk = { ---@type my.keymap.keymap_spec
  desc = "Preview Git hunk",
  rhs = function() require("gitsigns").preview_hunk() end,
}
M.keymaps.preview_hunk_inline = { ---@type my.keymap.keymap_spec
  desc = "Preview Git hunk inline",
  rhs = function() require("gitsigns").preview_hunk_inline() end,
}
M.keymaps.reset_buffer = { ---@type my.keymap.keymap_spec
  desc = "Reset Git buffer",
  rhs = function() require("gitsigns").reset_buffer() end,
}
M.keymaps.reset_hunk = { ---@type my.keymap.keymap_spec
  desc = "Reset Git hunk",
  rhs = function() require("gitsigns").reset_hunk() end,
}
M.keymaps.reset_hunk_visual = { ---@type my.keymap.keymap_spec
  desc = "Reset Git hunk",
  rhs = function() require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" } end,
}
M.keymaps.select_hunk = { ---@type my.keymap.keymap_spec
  desc = "inner Git Hunk",
  rhs = function() require("gitsigns").select_hunk() end,
}
M.keymaps.setloclist = { ---@type my.keymap.keymap_spec
  desc = "send Git hunks to loc list",
  rhs = function() require("gitsigns").setloclist(0, 0) end,
}
M.keymaps.setloclist_all = { ---@type my.keymap.keymap_spec
  desc = "send Git hunks from all buffers to loc list",
  rhs = function() require("gitsigns").setloclist(0, "all") end,
}
M.keymaps.setqflist = { ---@type my.keymap.keymap_spec
  desc = "send Git hunks to qf list",
  rhs = function() require("gitsigns").setqflist(0) end,
}
M.keymaps.setqflist_all = { ---@type my.keymap.keymap_spec
  desc = "send Git hunks from all buffers to qf list",
  rhs = function() require("gitsigns").setqflist "all" end,
}
M.keymaps.stage_buffer = { ---@type my.keymap.keymap_spec
  desc = "Stage Git buffer",
  rhs = function() require("gitsigns").stage_buffer() end,
}
M.keymaps.toggle_and_next_hunk = { ---@type my.keymap.keymap_spec
  desc = "Stage/Unstage and next Git hunk",
  rhs = function()
    require("gitsigns").stage_hunk()
    require("gitsigns").nav_hunk("next", { target = "all" })
  end,
}
M.keymaps.toggle_and_prev_hunk = { ---@type my.keymap.keymap_spec
  desc = "Stage/Unstage and prev Git hunk",
  rhs = function()
    require("gitsigns").stage_hunk()
    require("gitsigns").nav_hunk("prev", { target = "all" })
  end,
}
M.keymaps.toggle_current_line_blame = { ---@type my.keymap.keymap_spec
  desc = "Git toggle current line blame",
  rhs = function() require("gitsigns").toggle_current_line_blame() end,
}
M.keymaps.toggle_hunk = { ---@type my.keymap.keymap_spec
  desc = "Stage/Unstage Git hunk",
  rhs = function() require("gitsigns").stage_hunk() end,
}
M.keymaps.toggle_hunk_visual = { ---@type my.keymap.keymap_spec
  desc = "Stage/Unstage Git hunk",
  rhs = function() require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" } end,
}
M.keymaps.toggle_linehl = { ---@type my.keymap.keymap_spec
  desc = "Git toggle line highlight",
  rhs = function() require("gitsigns").toggle_linehl() end,
}
M.keymaps.toggle_numhl = { ---@type my.keymap.keymap_spec
  desc = "Git toggle number highlight",
  rhs = function() require("gitsigns").toggle_numhl() end,
}
M.keymaps.toggle_signs = { ---@type my.keymap.keymap_spec
  desc = "Git toggle sign column",
  rhs = function() require("gitsigns").toggle_signs() end,
}
M.keymaps.toggle_word_diff = { ---@type my.keymap.keymap_spec
  desc = "Git toggle word diff",
  rhs = function() require("gitsigns").toggle_word_diff() end,
}

return M
