local my = require "my"
---@class my.keymap
local M = {}

local _mapper = require "my.keymap._mapper"

M.opts = {}
M.opts.which_key_general = function(_, opts) ---@cast opts MyNoOptsSpec
  return my.tbl.merge_dicts_into_last(opts, {
    win = {
      no_overlap = false,
    },
    triggers = {
      { "<auto>", mode = "nxsoi" },
    },
  } --[[@as MyNoOptsSpec]])
end

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

M.keymaps.force_normal_mode = { ---@type my.keymap.keymap_spec
  desc = "Force normal mode",
  rhs = M.ESC,
  noremap = true,
}

M.keymaps.no_remap_cr = { ---@type my.keymap.keymap_spec
  desc = "No remap <CR>",
  rhs = "<CR>",
  noremap = true,
}

return M
