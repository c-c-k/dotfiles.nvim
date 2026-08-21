---@class MySyntaxIndent
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_snacks_indent
end

M._spec_snacks_indent = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["snacks-nvim"],
    opts = {
      indent = {
        filter = M.is_enabled_buf,
        config = function() --
          my.keymap.queue_km_group_load(my.config.keymaps.g_snkindnt)
        end,
      },
    },
  }
  return spec
end

---@return boolean
function M.is_enabled() --
  return require("snacks").indent.enabled
end

---@param bufnr? integer
---@return boolean
function M.is_enabled_buf(bufnr) --
  return my.buf.is_normal(bufnr) and my.ui.toggle.is_enabled_buf_nil_is_true(my.config.indent_guide_buf[bufnr or 0])
end

---@param enable boolean
function M.toggle(enable) --
  local snacks = require "snacks"
  if enable then
    snacks.indent.enable()
  else
    snacks.indent.disable()
  end
end

---@param enable boolean
function M.toggle_buf(enable) --
  my.config.indent_guide_buf[0] = enable
end

return M
