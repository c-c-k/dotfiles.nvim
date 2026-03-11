local my = require "my"
---@class my.ft: my.ft._submodules
local M = {}

local FILETYPE_ROOT_PATH = vim.fs.joinpath(vim.fn.stdpath "config", "lua/my/ft")
local FILETYPE_MODULE_PREFIX = "my.ft."

M.opts = {}

function M.enable_lsp_clients() --
  local lsp_enable = my.g.lsp_enable
  my.g.lsp_enable = nil
  for name, enable in pairs(lsp_enable) do
    vim.lsp.enable(name, enable)
  end
end

function M.get_lazy_nvim_filetype_specs() --
  local specs = my.g.lazy_filetype_specs
  my.g.lazy_filetype_specs = nil
  return specs
end

function M.init_filetypes() --
  my.g.lsp_enable = {}
  my.g.lazy_filetype_specs = {}
  my.g.filetype_setup_autocmds = {}
  for fname, _ in vim.iter(vim.fs.dir(FILETYPE_ROOT_PATH)) do
    ---@cast fname string
    -- ---@cast ftype string
    if fname:sub(1, 1) ~= "_" and fname ~= "init.lua" then
      local valid_module, module = pcall(require, FILETYPE_MODULE_PREFIX .. fname:gsub(".lua$", ""))
      if valid_module then
        local ft_init_func = module.a0_init
        if ft_init_func and type(ft_init_func) == "function" then
          ft_init_func()
        else
          local msg = string.format(
            "Filetype module does not have init function: %s",
            FILETYPE_MODULE_PREFIX .. fname:gsub(".lua$", "")
          )
          my.notify.warn(msg, { title = "Filetype setup" })
        end
      else
        local msg = string.format("Invalid filetype module: %s", vim.fs.joinpath(FILETYPE_ROOT_PATH, fname))
        my.notify.warn(msg, { title = "Filetype setup" })
      end
    end
  end
end

function M.setup_filetype_autocmds() --
  local filetype_setup_autocmds = my.g.filetype_setup_autocmds
  my.g.filetype_setup_autocmds = nil
  my.autocmd.get_augroup("my.filetypes", true)
  for _, filetype_setup_func in ipairs(filetype_setup_autocmds) do
    vim.validate("filetype_setup_func", filetype_setup_func, "callable")
    filetype_setup_func()
  end
end

return M
