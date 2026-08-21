---@class MyKeymap
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_whichkey
end

M._spec_whichkey = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["which-key.nvim"],
    opts = {
      delay = 0,
      triggers = {},
      win = {
        no_overlap = false,
      },
    },
    config = function(_, opts)
      require("which-key").setup(opts)

      my.keymap.queue_km_group_load(my.config.keymaps.g_wkey____)
    end,
    dependencies = { make_lzspec { source = plugins["mini.icons"], optional = false } },
  }
  return spec
end

local _mapper = require "my.keymap._mapper"

M.ESC = "<C-\\><C-N>"

--- Sends input-keys to NVIM replacing termcodes and ignoring keymaps.
---@param keys string
M.feed_termcodes_no_remap = function(keys)
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end

M.force_normal_mode = function() --
  return M.feed_termcodes_no_remap(M.ESC)
end

M.delete_by_km_group = _mapper.delete_by_km_group

M.load_km_group = _mapper.load_km_group

M.load_queued_km_groups = _mapper.load_queued_km_groups

M.queue_km_group_load = _mapper.queue_km_group_load

M.keymaps = {}

M.keymaps.force_normal_mode = { ---@type MyKeymapKeymapSpec
  desc = "Force normal mode",
  rhs = M.ESC,
  noremap = true,
}

M.keymaps.no_remap_cr = { ---@type MyKeymapKeymapSpec
  desc = "No remap <CR>",
  rhs = "<CR>",
  noremap = true,
}

M.keymaps.whichkey_show_loop = { ---@type MyKeymapKeymapSpec
  desc = "Show Which-key menu (loop)",
  rhs = function()
    require("which-key").show {
      loop = true, -- this will keep the popup open until you hit <esc>
    }
  end,
}

M.keymaps.whichkey_show_once = { ---@type MyKeymapKeymapSpec
  desc = "Show Which-key menu",
  rhs = function() require("which-key").show() end,
}

return M
