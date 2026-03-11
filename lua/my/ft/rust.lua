local my = require "my"
---@class my.ft.rust
local M = {}

M.a0_init = function()
  local specks = my.g.lazy_filetype_specs
  specks[#specks + 1] = {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = M.opts.rust_analyzer_setup,
  }
  specks[#specks + 1] = {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = M.opts.treesitter_integration,
  }
  specks[#specks + 1] = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = M.opts.mason_tool_installer_integration,
  }
  specks[#specks + 1] = {
    "Saecki/crates.nvim",
    optional = true,
    dependencies = { "neovim/nvim-lspconfig", optional = true },
    opts = M.opts.crates_nvim_general,
  }
  specks[#specks + 1] = {
    "mrcjkb/rustaceanvim",
    optional = true,
    dependencies = { "neovim/nvim-lspconfig", optional = true },
    init = M.opts.rustacenvim_init,
  }
  specks[#specks + 1] = {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "mrcjkb/rustaceanvim", optional = true },
    opts = M.opts.rustaceanvim_neotest_integration,
  }
end

M.opts = {}
M.opts.crates_nvim_general = function(_, opts) ---@cast opts MyNoOptsSpec
  return my.tbl.merge_dicts_into_last(opts, {
    completion = {
      crates = { enabled = true },
    },
    lsp = {
      enabled = true,
      -- on_attach = error("TODO: better configure crates.nvim"),
      actions = true,
      completion = true,
      hover = true,
    },
  } --[[@as MyNoOptsSpec]])
end
M.opts.mason_tool_installer_integration = function(_, opts) --
  opts.ensure_installed = my.tbl.merge_lists_into_first(opts.ensure_installed, { "codelldb" })
end
M.opts.rustacenvim_init = function()
  my.g.lsp_enable["rust_analyzer"] = false
  my.g.rustaceanvim = M.opts.rustacenvim_var_g_config
end
M.opts.rustaceanvim_neotest_integration = function(_, opts)
  local rustaceanvim_avail, adapter = pcall(require, "rustaceanvim.neotest")
  if rustaceanvim_avail then table.insert(opts.adapters, adapter) end
end
M.opts.rustacenvim_var_g_config = function()
  local config = {} ---@type rustaceanvim.Opts
  local codelldb = require("mason-registry").get_package "codelldb"
  local config_utils = require "rustaceanvim.config"
  if codelldb:is_installed() then
    local mason_root = vim.fs.normalize "$MASON"
    local codelldb_path = vim.fs.joinpath(mason_root, "bin/lldb")
    local liblldb_path = vim.fs.joinpath(mason_root, "opt/lldb/lib/liblldb.so")
    local adapter = config_utils.get_codelldb_adapter(codelldb_path, liblldb_path)
    config.dap = { adapter = adapter }
  else
    local msg = "`codelldb` missing, rustacenvim DAP integration disabled"
    my.notify.warn(msg, { title = "LSP setup" })
  end
  return config
end
M.opts.rust_analyzer_setup = function()
  local rust_analyzer_server_settings = {
    files = {
      excludeDirs = {
        ".direnv",
        ".git",
        "target",
      },
    },
    check = {
      command = "clippy",
      extraArgs = {
        "--no-deps",
      },
    },
  }
  my.g.lsp_enable["rust_analyzer"] = true
  local config = vim.lsp.config["rust_analyzer"] ---@type vim.lsp.Config
  vim.lsp.config["rust_analyzer"] = my.tbl.merge_dicts_into_first(config, {
    settings = { ["rust-analyzer"] = rust_analyzer_server_settings },
  } --[[@as vim.lsp.Config]])
end
M.opts.treesitter_integration = function(_, opts)
  if opts.ensure_installed ~= "all" then
    opts.ensure_installed = my.tbl.merge_lists_into_first(opts.ensure_installed, { "rust" })
  end
end

return M
