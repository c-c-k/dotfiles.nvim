---@class MyLspLspFileOps
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_lsp_file_ops
end

M._spec_lsp_file_ops = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["nvim-lsp-file-operations"],
    lazy = false,
    opts = {
      debug = false,
      timeout_ms = my.config.lsp_file_ops_timeout_ms,
    },
    config = function(_, opts)
      require("lsp-file-operations").setup(opts)

      local lsp_configs = my.config.setup_lsp_configs

      lsp_configs[#lsp_configs + 1] = { M._lspconfig_lsp_file_ops, true }
    end,
    dependencies = {
      make_lzspec { source = plugins["plenary.nvim"], optional = false },
      -- make_lzspec { source = plugins["nvim-tree.lua"] },
      -- make_lzspec { source = plugins["neo-tree.nvim"] },
      -- make_lzspec { source = plugins["triptych.nvim"] },
    },
  }
  return spec
end

M._lspconfig_lsp_file_ops = function(enable)
  if not enable then return end

  local capabilities = vim.lsp.config["*"].capabilities
  if type(capabilities) ~= "table" then
    local _msg = "missing base capabilities during LSP file ops lsp config"
    error(_msg)
  end

  vim.lsp.config["*"].capabilities =
    my.tbl.merge("dDfF", capabilities, require("lsp-file-operations").default_capabilities())
end

function M.files_did_create(fname)
  local lfo_module_name = "lsp-file-operations.did-create"
  local has_lfo_module, lfo_module = pcall(require, lfo_module_name)
  if not has_lfo_module then
    local msg = string.format("missing lsp-file-ops module: %s", lfo_module_name)
    return my.notify.warn(msg, { title = "missing plugin" })
  end
  lfo_module.callback { fname = fname }
end

function M.files_did_delete(fname)
  local lfo_module_name = "lsp-file-operations.did-delete"
  local has_lfo_module, lfo_module = pcall(require, lfo_module_name)
  if not has_lfo_module then
    local msg = string.format("missing lsp-file-ops module: %s", lfo_module_name)
    return my.notify.warn(msg, { title = "missing plugin" })
  end
  lfo_module.callback { fname = fname }
end

function M.files_did_rename(old_name, new_name)
  local lfo_module_name = "lsp-file-operations.did-rename"
  local has_lfo_module, lfo_module = pcall(require, lfo_module_name)
  if not has_lfo_module then
    local msg = string.format("missing lsp-file-ops module: %s", lfo_module_name)
    return my.notify.warn(msg, { title = "missing plugin" })
  end
  lfo_module.callback { old_name = old_name, new_name = new_name }
end
function M.files_will_create(fname)
  local lfo_module_name = "lsp-file-operations.will-create"
  local has_lfo_module, lfo_module = pcall(require, lfo_module_name)
  if not has_lfo_module then
    local msg = string.format("missing lsp-file-ops module: %s", lfo_module_name)
    return my.notify.warn(msg, { title = "missing plugin" })
  end
  lfo_module.callback { fname = fname }
end

return M
