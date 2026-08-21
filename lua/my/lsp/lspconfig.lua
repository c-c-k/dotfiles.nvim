---@class MyLspLspconfig
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_lspconfig
end

M._spec_lspconfig = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["nvim-lspconfig"],
    lazy = false,
    config = function() --
      M._autocmd_lsp_attach()
    end,
  }
  return spec
end

M._autocmd_lsp_attach = function()
  my.autocmd.add_autocmd {
    group = "my.lsp_attach.lspconfig",
    event = "LspAttach",
    desc = "LSP on_attach setup for nvim-lspconfig",
    callback = function(ev) --
      my.keymap.load_km_group(my.config.keymaps.b_lspconfg, { ev = ev })
    end,
  }
end

--- Define or modify a LSP configuration and set auto attach for it.
---@param new_config vim.lsp.Config
---@param enable boolean
---@param base_config vim.lsp.Config?
function M.apply_lsp_config(new_config, enable, base_config)
  local config_name = new_config.name

  if config_name == nil then
    local _msg = "configuration missing name field: " .. vim.inspect(new_config)
    error(_msg)
  end

  if base_config == nil then
    -- Reuse `base_config` table since it's getting replaced anyway.
    base_config = vim.lsp.config[config_name]
    vim.lsp.config[config_name] = my.tbl.merge("dDfF", base_config, new_config)
  else
    -- Deep copy `base_config` into `new_config` since `new_config` is a separate configuration.
    vim.lsp.config[config_name] = my.tbl.merge("dDkF", new_config, base_config)
  end

  vim.lsp.enable(config_name, enable)
end

--- Generate a fallback `vim.lsp.Config.root_dir` to catch buffers
--- that do not belong to a workspace.
---@param base_config vim.lsp.Config
---@return fun(bufnr: integer, on_dir:fun(root_dir?:string))
function M.root_dir_gen_fallback_func(base_config)
  return function(buf_id, on_dir)
    local ws_buf_info = my.ws.buf_get_ws_info(buf_id)
    if ws_buf_info then return end

    local root_dir = base_config.root_dir
    if type(root_dir) == "string" then
      on_dir(root_dir)
      return
    elseif type(root_dir) == "function" then
      root_dir(buf_id, on_dir)
      return
    elseif root_dir ~= nil then
      local _msg = string.format("invalid `root_dir` in config: %s", vim.inspect(base_config))
      error(_msg)
    end

    local root_markers = base_config.root_markers or my.config.root_markers
    root_dir = vim.fs.root(buf_id, root_markers)
    if root_dir then
      on_dir(root_dir)
      return
    end

    local _msg = string.format("failed to resolve `root_dir` for config: %s", vim.inspect(base_config))
    my.notify.warn(_msg)
  end
end

--- Generate a workspace `vim.lsp.Config.root_dir` to catch buffers
--- that belong to the workspace.
---@param ws_name string
---@return fun(bufnr: integer, on_dir:fun(root_dir?:string))
function M.root_dir_gen_ws_func(ws_name)
  return function(buf_id, on_dir)
    local ws_buf_info = my.ws.buf_get_ws_info(buf_id)
    if ws_buf_info and ws_buf_info.name == ws_name then on_dir(ws_buf_info.root_dir_path) end
  end
end

M.keymaps = {}

M.keymaps.lsp_information = { ---@type MyKeymapKeymapSpec
  desc = "LSP information",
  rhs = "<Cmd>checkhealth vim.lsp<CR>",
}

return M
