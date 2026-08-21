---@class MyUiColorscheme
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_solarized_osaka
end

M._spec_solarized_osaka = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["solarized-osaka.nvim"],
    lazy = true,
    opts = {
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      dim_inactive = false,
      on_highlights = function(highlights, colors)
        -- Avoid dimming text in inactive windows, `dim_inactive` only affects the background
        highlights.NormalNC = { fg = colors.base0 } -- normal text in non-current windows
        -- Make cursor line a bit more visible
        highlights.CursorLine = { bg = colors.base02, sp = colors.base1 } -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
      end,
      -- plugins = ... -- MEMO: If switching away from the lazy.nvim plugin manager check docs and src about this option and decide what to do...
    },
    config = function(_, opts) --
      require("solarized-osaka").setup(opts)
    end,
  }
  return spec
end

return M
