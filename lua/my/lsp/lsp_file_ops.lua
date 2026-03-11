local my = require "my"
---@class my.lsp.lsp_file_ops
local M = {}

M.opts = {}
M.opts.config = function()
  require("lsp-file-operations").setup {
    -- used to see debug logs in file `vim.fn.stdpath("cache") .. lsp-file-operations.log`
    debug = false,
    timeout_ms = my.g.lsp_file_ops_timeout_ms,
  }
end
M.opts.lspconfig_extend_default_capabilities = function()
  local lspconfig = require "lspconfig"
  local lsp_file_ops = require "lsp-file-operations"

  -- Set global defaults for all servers
  -- NOTE: Possibly outdated due to lspconfig partial deprecation.
  lspconfig.util.default_config = my.tbl.merge_dicts_into_first(lspconfig.util.default_config, {
    capabilities = my.tbl.merge_dicts_into_first(
      vim.lsp.protocol.make_client_capabilities(),
      lsp_file_ops.default_capabilities()
    ),
  })
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
