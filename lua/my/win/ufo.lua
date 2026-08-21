---@class MyWinUfo
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_ufo
end

M._spec_ufo = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["nvim-ufo"],
    opts = {
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
    },
    config = function(_, opts)
      require("ufo").setup(opts)

      M._autocmd_ufo_buf_enter()

      my.keymap.queue_km_group_load(my.config.keymaps.g_ufo_____)
    end,
    dependencies = { make_lzspec { source = plugins["promise-async"], optional = false } },
  }
  return spec
end

M.opts = {}
M._autocmd_ufo_buf_enter = function()
  my.autocmd.add_autocmd {
    group = "my.win.ufo.float_win_setup",
    event = "BufEnter",
    pattern = "UfoPreviewFloatWin",
    desc = 'Set options, vars and mappings for a "UfoPreviewFloatWin"',
    callback = function(ev)
      local buf_id = ev.buf
      local did_ftplugin = my.config.did_ftplugin_buf[buf_id]
      if did_ftplugin == "ufo_preview" then return end
      my.config.did_ftplugin_buf[buf_id] = "ufo_preview"

      my.keymap.load_km_group(my.config.keymaps.b_ufo_____, { buffer = ev.buf })
    end,
  }
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

M.keymaps.closeAllFolds = { ---@type MyKeymapKeymapSpec
  desc = "Close All Folds",
  rhs = function() require("ufo").closeAllFolds() end,
}
M.keymaps.closeFoldsWith = { ---@type MyKeymapKeymapSpec
  desc = "Close More Folds",
  rhs = function() require("ufo").closeFoldsWith() end,
}
M.keymaps.goNextClosedFold = { ---@type MyKeymapKeymapSpec
  desc = "Next closed fold",
  rhs = function() require("ufo").goNextClosedFold() end,
}
M.keymaps.goPreviousClosedFold = { ---@type MyKeymapKeymapSpec
  desc = "Prev closed fold",
  rhs = function() require("ufo").goPreviousClosedFold() end,
}
M.keymaps.openAllFolds = { ---@type MyKeymapKeymapSpec
  desc = "Open All Folds",
  rhs = function() require("ufo").openAllFolds() end,
}
M.keymaps.openFoldsExceptKinds = { ---@type MyKeymapKeymapSpec
  desc = "Open More Folds",
  rhs = function() require("ufo").openFoldsExceptKinds() end,
}
M.keymaps.peek_fold = { ---@type MyKeymapKeymapSpec
  desc = "peek at fold",
  rhs = function() require("ufo").peekFoldedLinesUnderCursor() end,
}
M.keymaps.preview_win_close = { ---@type MyKeymapKeymapSpec
  desc = "close fold preview",
  rhs = function() _preview_emmit "close" end,
}
M.keymaps.preview_win_jumpBot = { ---@type MyKeymapKeymapSpec
  desc = "jump to bottom",
  rhs = function() _preview_emmit "jumpBot" end,
}
M.keymaps.preview_win_jumpTop = { ---@type MyKeymapKeymapSpec
  desc = "jump to top",
  rhs = function() _preview_emmit "jumpTop" end,
}
M.keymaps.preview_win_scrollB = { ---@type MyKeymapKeymapSpec
  desc = "scroll screen up",
  rhs = function() _preview_emmit "scrollB" end,
}
M.keymaps.preview_win_scrollD = { ---@type MyKeymapKeymapSpec
  desc = "scroll 1/2screen down",
  rhs = function() _preview_emmit "scrollD" end,
}
M.keymaps.preview_win_scrollE = { ---@type MyKeymapKeymapSpec
  desc = "scroll line down",
  rhs = function() _preview_emmit "scrollE" end,
}
M.keymaps.preview_win_scrollF = { ---@type MyKeymapKeymapSpec
  desc = "scroll screen down",
  rhs = function() _preview_emmit "scrollF" end,
}
M.keymaps.preview_win_scrollU = { ---@type MyKeymapKeymapSpec
  desc = "scroll 1/2screen up",
  rhs = function() _preview_emmit "scrollU" end,
}
M.keymaps.preview_win_scrollY = { ---@type MyKeymapKeymapSpec
  desc = "scroll line up",
  rhs = function() _preview_emmit "scrollY" end,
}
M.keymaps.preview_win_switch = { ---@type MyKeymapKeymapSpec
  desc = "switch to/from fold preview",
  rhs = function() _preview_emmit "switch" end,
}
M.keymaps.preview_win_trace = { ---@type MyKeymapKeymapSpec
  desc = "trace fold start",
  rhs = function() _preview_emmit "trace" end,
}

return M
