---@class MyFtRust
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.filetypes = function()
  -- local autocmds = my.config.setup_filetype_autocmds
  local lsp = my.config.setup_lsp_configs
  local mason_ensure_installed = my.config.mason_ensure_installed
  -- local null_ls = my.config.null_ls_sources
  local specks = my.config.lzsetup_plugin_specs
  local ts_ensure_installed = my.config.ts_ensure_installed

  ts_ensure_installed["rust"] = true

  -- mason_ensure_installed["rust-analyzer"] = true
  -- NOTE(MEMO): Installing codelldb via Mise requires adding an extra Mise plugin.
  mason_ensure_installed["codelldb"] = true
  -- NOTE(MEMO): Disabled but not commented out in favor of `rustaceanvim`
  --       which has it's own internal `rust-analyzer` server but honors
  --       the configuration in `vim.lsp.cofig.rust_analyzer`.
  lsp[#lsp + 1] = { M._lspconfig_rust_analyzer, false }
  specks[#specks + 1] = M._spec_crates_nvim
  specks[#specks + 1] = M._spec_rustacenvim
end

M.setup = {}

M._lspconfig_rust_analyzer = function(enable)
  local config_name = "rust_analyzer"
  local server_name = "rust-analyzer"

  local server_settings = {
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

  -- local old_config = vim.lsp.config[config_name]
  local new_config = { ---@type vim.lsp.Config
    name = config_name,
    settings = { [server_name] = server_settings },
  }

  my.lsp.lspconfig.apply_lsp_config(new_config, enable)
end

M._spec_crates_nvim = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["crates.nvim"],
    lazy = true,
    event = { "BufRead Cargo.toml" },
    opts = {
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
    },
    dependencies = { make_lzspec(plugins["nvim-lspconfig"]) },
  }
  return spec
end

M._spec_rustacenvim = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["rustaceanvim"],
    init = function()
      local config = {} ---@type rustaceanvim.Opts
      -- local codelldb = require("mason-registry").get_package "codelldb"
      local config_utils = require "rustaceanvim.config"

      -- if codelldb:is_installed() then
      if require("mason-registry").is_installed "codelldb" then
        local mason_root = vim.fs.normalize "$MASON"
        local codelldb_path = vim.fs.joinpath(mason_root, "bin/lldb")
        local liblldb_path = vim.fs.joinpath(mason_root, "opt/lldb/lib/liblldb.so")
        local adapter = config_utils.get_codelldb_adapter(codelldb_path, liblldb_path)
        config.dap = { adapter = adapter }
      else
        local msg = "`codelldb` missing, rustacenvim DAP integration disabled"
        my.notify.warn(msg, { title = "LSP setup" })
      end

      vim.api.nvim_set_var("rustacenvim", config)
    end,
    dependencies = { make_lzspec(plugins["nvim-lspconfig"]) },
  }
  return spec
end

return M
