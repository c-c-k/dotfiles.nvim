---@class MyUiLualine
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_lualine
end

M._spec_lualine = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["lualine.nvim"],
    opts = function(_, opts)
      local winbar_filename = {
        "filename",
        newfile_status = true,
        path = 1,
        shorting_target = 20,
        fmt = function(fname, ctx) --
          local fname_len = string.len(fname)
          local available_len = vim.api.nvim_win_get_width(0) - ctx.options.shorting_target

          if available_len < 2 then return end

          if available_len < fname_len then
            fname = "<" .. string.sub(fname, fname_len - available_len + 2, fname_len)
          end

          return fname
        end,
      }
      return my.tbl.merge("dDkL", opts, {
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "searchcount", "selectioncount" },
          lualine_c = { "diff", "diagnostics" },
          lualine_x = { { "encoding", show_bomb = true }, "fileformat", "filetype" },
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
      })
    end,
    config = function(_, opts) --
      require("lualine").setup(opts)
    end,
    dependencies = {
      make_lzspec {
        source = plugins["mini.icons"],
        opts = {
          -- NOTE: MEMO: If this becomes redundant or if deciding not to use lualine
          --             check if the custom config for *mini.icons* should not be
          --             removed as well.
          mock_nvim_web_devicons = true,
        },
      },
    },
  }
  return spec
end

return M
