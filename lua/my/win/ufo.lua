local my = require "my"
---@class my.win.ufo
local M = {}

M.opts = {}
M.opts.general = function(_, opts) ---@cast opts MyNoOptsSpec
  return my.tbl.merge_dicts_into_last(opts, {
    preview = {
      mappings = {
        scrollB = "",
        scrollF = "",
        scrollU = "",
        scrollD = "",
        scrollE = "",
        scrollY = "",
        jumpTop = "",
        jumpBot = "",
        close = "",
        switch = "",
        trace = "",
      },
    },
    provider_selector = my.win.ufo.provider_selector,
  } --[[@as MyNoOptsSpec]])
end
M.opts.core_integration = function()
  my.autocmd.add_autocmd {
    group = "my.win.ufo.float_win_setup",
    event = "BufEnter",
    pattern = "UfoPreviewFloatWin",
    desc = 'Set options, vars and mappings for a "UfoPreviewFloatWin"',
    callback = function(args)
      if vim.b[args.buf].did_ftplugin_my_ufo_preview_win then return end
      vim.b[args.buf].did_ftplugin_my_ufo_preview_win = true

      my.keymap.load_km_group(my.config.keymaps.b_ufo_____, { buffer = args.buf })
    end,
  }

  my.keymap.queue_km_group_load(my.config.keymaps.g_ufo_____)
end

local function _preview_emmit(msg)
  return function() require("ufo.lib.event"):emit("OnBufRemap", vim.api.nvim_get_current_buf(), msg) end
end

-- selene: allow(unused_variable)
---@diagnostic disable-next-line: unused-local
function M.provider_selector(bufnr, filetype, buftype)
  local has_lsp_fold = false
  local clients = vim.lsp.get_clients { bufnr = bufnr }
  for _, client in ipairs(clients) do
    if client:supports_method("textDocument/foldingRange", bufnr) then
      has_lsp_fold = true
      break
    end
  end
  return { has_lsp_fold and "lsp" or "treesitter", "indent" }
end

M.keymaps = {}

M.keymaps.closeAllFolds = { ---@type my.keymap.keymap_spec
  desc = "Close All Folds",
  rhs = function() require("ufo").closeAllFolds() end,
}
M.keymaps.closeFoldsWith = { ---@type my.keymap.keymap_spec
  desc = "Close More Folds",
  rhs = function() require("ufo").closeFoldsWith() end,
}
M.keymaps.goNextClosedFold = { ---@type my.keymap.keymap_spec
  desc = "Next closed fold",
  rhs = function() require("ufo").goNextClosedFold() end,
}
M.keymaps.goPreviousClosedFold = { ---@type my.keymap.keymap_spec
  desc = "Prev closed fold",
  rhs = function() require("ufo").goPreviousClosedFold() end,
}
M.keymaps.openAllFolds = { ---@type my.keymap.keymap_spec
  desc = "Open All Folds",
  rhs = function() require("ufo").openAllFolds() end,
}
M.keymaps.openFoldsExceptKinds = { ---@type my.keymap.keymap_spec
  desc = "Open More Folds",
  rhs = function() require("ufo").openFoldsExceptKinds() end,
}
M.keymaps.peek_fold = { ---@type my.keymap.keymap_spec
  desc = "peek at fold",
  rhs = function() require("ufo").peekFoldedLinesUnderCursor() end,
}
M.keymaps.preview_win_close = { ---@type my.keymap.keymap_spec
  desc = "close fold preview",
  rhs = function() _preview_emmit "close" end,
}
M.keymaps.preview_win_jumpBot = { ---@type my.keymap.keymap_spec
  desc = "jump to bottom",
  rhs = function() _preview_emmit "jumpBot" end,
}
M.keymaps.preview_win_jumpTop = { ---@type my.keymap.keymap_spec
  desc = "jump to top",
  rhs = function() _preview_emmit "jumpTop" end,
}
M.keymaps.preview_win_scrollB = { ---@type my.keymap.keymap_spec
  desc = "scroll screen up",
  rhs = function() _preview_emmit "scrollB" end,
}
M.keymaps.preview_win_scrollD = { ---@type my.keymap.keymap_spec
  desc = "scroll 1/2screen down",
  rhs = function() _preview_emmit "scrollD" end,
}
M.keymaps.preview_win_scrollE = { ---@type my.keymap.keymap_spec
  desc = "scroll line down",
  rhs = function() _preview_emmit "scrollE" end,
}
M.keymaps.preview_win_scrollF = { ---@type my.keymap.keymap_spec
  desc = "scroll screen down",
  rhs = function() _preview_emmit "scrollF" end,
}
M.keymaps.preview_win_scrollU = { ---@type my.keymap.keymap_spec
  desc = "scroll 1/2screen up",
  rhs = function() _preview_emmit "scrollU" end,
}
M.keymaps.preview_win_scrollY = { ---@type my.keymap.keymap_spec
  desc = "scroll line up",
  rhs = function() _preview_emmit "scrollY" end,
}
M.keymaps.preview_win_switch = { ---@type my.keymap.keymap_spec
  desc = "switch to/from fold preview",
  rhs = function() _preview_emmit "switch" end,
}
M.keymaps.preview_win_trace = { ---@type my.keymap.keymap_spec
  desc = "trace fold start",
  rhs = function() _preview_emmit "trace" end,
}

return M
