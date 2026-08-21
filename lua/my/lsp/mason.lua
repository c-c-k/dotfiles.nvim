---@class MyLspMason
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_mason
end

M._spec_mason = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["mason.nvim"],
    lazy = false,
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      log_level = my.config.mason_log_level,
    },
    config = function(_, opts)
      require("mason").setup(opts)

      M._ensure_installed()
      if my.config.mason_clean_on_startup then M._clean() end
    end,
  }
  return spec
end

function M._clean()
  local mason_reg = require "mason-registry"
  local mason_cmd = require "mason.api.command"
  local ensure_installed = my.config.mason_ensure_installed
  local actually_installed = mason_reg.get_installed_package_names()
  local remove_list = {}

  for _, package in ipairs(actually_installed) do
    if not ensure_installed[package] then remove_list[#remove_list + 1] = package end
  end

  if #remove_list > 0 then mason_cmd.MasonUninstall(remove_list) end
end

function M._ensure_installed()
  local mason_reg = require "mason-registry"
  local mason_cmd = require "mason.api.command"
  local ensure_installed = my.config.mason_ensure_installed
  local already_installed = my.tbl.set_from_list(mason_reg.get_installed_package_names())
  local valid_packages = nil
  local intall_list = {}

  for package, install in pairs(ensure_installed) do
    if install and not already_installed[package] then
      if not valid_packages then valid_packages = my.tbl.set_from_list(mason_reg.get_all_package_names()) end
      if not valid_packages[package] then
        local _msg = string.format("invalid mason package name in mason ensure installed: %s", package)
        error(_msg)
      end
      if type(install) == "string" then package = package .. "@" .. install end
      intall_list[#intall_list + 1] = package
    end
  end

  if #intall_list > 0 then mason_cmd.MasonInstall(intall_list) end
end

return M
