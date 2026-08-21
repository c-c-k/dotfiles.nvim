---@class MySetup
---@field utils MySetupUtils
---@field lazy_nvim MySetupLazyNvim
---@field keymaps MyKeymapLoaderGroups
---@field toggles MySetupToggles
local M = {}
M.init = { no_init = true, recurse = false } ---@type MyModuleInit

local my = require "my"

function M.after_add_autodmds_autostart() --
  require "my.setup._add_autocmds_autostart"
end

function M.after_add_autodmds_core() --
  require "my.setup._add_autocmds_core_post_plug"
end

function M.after_add_autocmds_filetypes()
  my.autocmd.get_augroup("my.filetypes", true)
  for _, filetype_setup_func in ipairs(my.config.setup_filetype_autocmds) do
    vim.validate("filetype_setup_func", filetype_setup_func, "callable")
    filetype_setup_func()
  end
end

function M.after_add_autocmds_projects()
  for _, project_setup_func in ipairs(my.config.setup_project_autocmds) do
    vim.validate("project_setup_func", project_setup_func, "callable")
    project_setup_func()
  end
end

function M.after_add_keymaps()
  require "my.keymap._auto_nohlsearch"
  my.keymap.load_km_group(my.config.keymaps.g_core____)
  my.keymap.load_queued_km_groups()
end

function M.after_apply_lsp_configs()
  local configs = my.config.setup_lsp_configs
  for _, config in ipairs(configs) do
    local config_func, enable = unpack(config)
    config_func(enable)
  end
  my.config.setup_lsp_configs = my.setup.utils.removed_after_use "my.config.setup_lsp_configs"
end

function M.collect_my_inits() --
  local MY_ROOT_PATH = vim.fs.joinpath(vim.fn.stdpath "config", "lua/my")
  local MY_ROOT_MODULE_PREFIX = "my"

  my.config.setup_init_lists = my.setup.utils.blank_init_lists
  my.setup.utils.blank_init_lists = my.setup.utils.removed_after_use "blank_init_lists"
  my.setup.utils.collect_inits(MY_ROOT_PATH, MY_ROOT_MODULE_PREFIX)
end

function M.init_filetypes() --
  my.setup.utils.run_funcs_list("filetype init funcs", my.config.setup_init_lists.filetypes)
end

function M.init_keymap_groups() --
  require "my.setup._init_keymap_groups"
end

function M.init_my_config() --
  require "my.setup._init_my_config"
end

function M.init_lzplugin_manifest() --
  require "my.setup.__plugins_manifest"
end

function M.init_plugins() --
  require "my.setup.__plugins_manifest"
  my.setup.utils.run_funcs_list("plugin init funcs", my.config.setup_init_lists.plugins)
end

function M.init_workspaces() --
  my.setup.utils.run_funcs_list("workspaces init funcs", my.config.setup_init_lists.workspaces)
end

function M.lazy_nvim_bootstrap() --
  require("my.setup.lazy_nvim").bootstrap()
end

function M.lazy_nvim_load_plugins() --
  local specs = my.config.lzsetup_plugin_specs
  for index, spec in ipairs(specs) do
    if type(spec) == "function" then specs[index] = spec() end
  end
  require("my.setup.lazy_nvim").setup(specs)
end

function M.load_keymaps_table() --
  require "my.setup.__keymaps"
end

function M.load_my_rs() --
  require "my.setup._load_my_rs"
end

function M.set_my_config_opts() --
  require "my.setup.__config"
end

function M.set_nvim_opts_and_vars() --
  require "my.setup.__nvim_opts_and_vars"
end

return M
