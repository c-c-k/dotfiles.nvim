---@class MySetupLazyNvim
local M = {}

-- local my = require "my"

--- Start the Lazy.nvim plugin manager and load the plugins
---@param specs LazyPluginSpec[]
function M.setup(specs)
  require("lazy").setup {
    -- spec = { , my.config.setup_lazy_specs },
    spec = { specs },
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

---@alias MyLzPluginSpecMaker fun(add: boolean, spec: LazyPluginSpec?): LazyPluginSpec

---@class (exact) MyLazyPluginHeader: LazyPluginBase, LazyPluginRef
---@field main? nil
---@field optional? nil
---@field lazy? nil
---@field priority? nil

---@class (exact) MyLazyPluginBody: LazyPluginSpecHandlers, LazyPluginHooks
---@field source MyLazyPluginHeader
---@field main? string Entry module that has setup & deactivate
---@field optional? boolean If set, then this plugin will not be added unless it is added somewhere else
---@field lazy? boolean
---@field priority? number Only useful for lazy=false plugins to force loading certain plugins first. Default priority is 50
---@field dependencies? string|string[]|LazyPluginSpec[]
---@field specs? string|string[]|LazyPluginSpec[]

--- Create a full lazy-nvim spec from a plugins manifest "header" spec
--- containing [1]/url/dir, enabled, cond (and optionally name, dev and
--- versioning fields) and a "body" spec containing the rest of the fields.
---
--- If `add` is true the spec will be added to the `lazy.nvim.setup` specs list
--- otherwise the spec will only be returned.
---
-- ---@param add boolean
-- ---@param header MyLazyPluginHeader
-- ---@param body MyLazyPluginBody?
---@param spec MyLazyPluginHeader | MyLazyPluginBody
---@return LazyPluginSpec
-- function M.make_spec(add, header, body)
-- function M.make_spec(header, body)
-- function M.make_spec(body)
function M.resolve_spec(spec)
  -- local specs = my.config.setup_lzplugin_specs
  -- local has_spec = my.config.setup_lzplugin_has_spec
  vim.validate("spec", spec, "table")
  ---@cast spec -nil

  local full_spec = spec --[[@as LazyPluginSpec]]
  local source_spec = spec.source
  if not source_spec then
    full_spec = {}
    source_spec = spec --[[@as MyLazyPluginHeader]]
  end

  local short, url, dir = source_spec[1], source_spec.url, source_spec.dir
  if not (short or url or dir) then
    local _msg = string.format("spec missing source info: %s", vim.inspect(spec))
    error(_msg, 2)
  end
  spec.source = nil

  -- local full_spec = source_spec and spec or {} --[[@as LazyPluginSpec]]
  -- ---@type LazyPluginSpec
  -- local spec = spec or {} --[[@as LazyPluginSpec]]
  -- local short, url, dir = spec[1], spec.url, spec.dir

  full_spec[1] = short
  full_spec.url = url
  full_spec.dir = dir
  -- full_spec[1] = source_spec[1]
  -- full_spec.url = source_spec.url
  -- full_spec.dir = source_spec.dir

  -- NOTE(MEMO): Active plugins are determined solely via the header specs
  --             that should be added in `my.setup.init_lzplugin_manifest()`
  --             all other plugin specs are thus added as optional
  --             unless `optional = false` is explicitly added to the body
  --             spec to signify that this is a non-optional dependency spec
  --             for it's parent spec and thus should cause and error if it is
  --             disabled while it's parent spec is enabled.
  if not full_spec.optional == false then full_spec.optional = true end

  -- local source_id = table.concat({ short, url, dir }, ",")
  -- if not has_spec[source_id] then
  --   specs[#specs + 1] = header --[[@as LazyPluginSpec]]
  --   has_spec[source_id] = true
  -- end

  -- if add then specs[#specs + 1] = spec end

  return full_spec
end

--- Bootstrap the installation of Lazy.nvim.
function M.bootstrap()
  local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

  if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
    -- stylua: ignore
    local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", lazypath })
    if vim.v.shell_error ~= 0 then
      -- stylua: ignore
      vim.api.nvim_echo(
        { { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
        true, {})
      vim.fn.getchar()
      vim.cmd.quit()
    end
  end

  vim.opt.rtp:prepend(lazypath)

  -- validate that lazy is available
  if not pcall(require, "lazy") then
    -- stylua: ignore
    vim.api.nvim_echo(
      { { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
      true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

return M
