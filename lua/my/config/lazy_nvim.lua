local my = require "my"
---@class my.config.lazy_nvim
local M = {}

local NULL_PLUGIN_DIR = vim.fn.stdpath "config"
local NULL_PLUGIN_NAME = "my"

--- Start the Lazy.nvim plugin manager and load the plugins
function M.setup()
  local main_specs = require "my.config._plugins_manifest"
  local file_type_specs = my.ft.get_lazy_nvim_filetype_specs()
  require("lazy").setup {
    spec = {
      main_specs,
      file_type_specs,
    },
    install = { colorscheme = { "habamax" } },
    ui = { backdrop = 100 },
    performance = {
      rtp = {
        -- disable some rtp plugins, add more to your liking
        disabled_plugins = {
          "gzip",
          -- "matchit",
          "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          -- "tutor",
          "zipPlugin",
        },
      },
    },
  }
end

--- Bootstrap the installation of Lazy.nvim.
function M.bootstrap()
  local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

  if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
    if vim.v.shell_error ~= 0 then
    -- stylua: ignore
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
      vim.fn.getchar()
      vim.cmd.quit()
    end
  end

  vim.opt.rtp:prepend(lazypath)

  -- validate that lazy is available
  if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

--- empty config function for plugins that do not use `<plug_name>.setup()`
--- or any other setup function that would usually go into the plugin lazy
--- spec `config` field.
function M.no_setup() --
end

---@param spec LazyPluginSpec
function M.null_spec(spec)
  spec.dir = NULL_PLUGIN_DIR
  spec.name = NULL_PLUGIN_NAME
  return spec
end

return M
