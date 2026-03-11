local my = require "my"
---@class my.ui.lualine
local M = {}

M.opts = {}
M.opts.general = function(_, opts) ---@cast opts MyNoOptsSpec
  local winbar_filename = {
    "filename",
    newfile_status = true,
    path = 1,
  }
  return my.tbl.merge_dicts_into_last(opts, {
    -- TODO: Adjust lualine config.
    -- MEMO: lualine has config for winbars and tabline.
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "searchcount", "selectioncount" },
      lualine_c = { "diff", "diagnostics" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "lsp_status" },
      lualine_z = { "filename", "branch" },
    },
    globalstatus = true,
    winbar = {
      lualine_a = { winbar_filename },
      lualine_y = { "location" },
      lualine_z = { "progress" },
    },
    inactive_winbar = {
      lualine_a = { winbar_filename },
      lualine_y = { "location" },
      lualine_z = { "progress" },
    },
    theme = "solarized_dark",
    extensions = {
      "aerial",
      "fugitive",
      "lazy",
      "man",
      "mason",
      -- "nvim-dap-ui",
      "oil",
      "quickfix",
    },
  } --[[@as MyNoOptsSpec]])
end
M.opts.mini_icons_integration = function(_, opts) --
  -- NOTE: MEMO: If this becomes redundant or if deciding not to use lualine
  --             check if the custom config for *mini.icons* should not be
  --             removed as well.
  opts.mock_nvim_web_devicons = true
end

return M
