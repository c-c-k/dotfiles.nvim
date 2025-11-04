local is_aarch64 = vim.loop.os_uname().machine == "aarch64"

local lsp_settings_lua_ls = {
  Lua = {
    hint = {
      enable = true,
      arrayIndex = "Disable",
    },
  },
}

---@type LazyPluginSpec
local spec_astrolsp = {
  "AstroNvim/astrolsp",
  optional = true,
  opts = {
    config = {
      lua_ls = {
        settings = lsp_settings_lua_ls,
      },
    },
  },
}

---@type LazyPluginSpec
local spec_nvim_treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = function(_, opts)
    if opts.ensure_installed ~= "all" then
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "lua", "luap" })
    end
  end,
}

---@type LazyPluginSpec
local spec_mason_tool_installer_nvim = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  optional = true,
  opts = function(_, opts)
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "lua-language-server",
      "stylua",
      (not is_aarch64 and "selene") or nil,
    })
  end,
}

---@type LazyPluginSpec
local spec_neotest = {
  "nvim-neotest/neotest",
  optional = true,
  dependencies = { "nvim-neotest/neotest-plenary", config = function() end },
  opts = function(_, opts)
    if not opts.adapters then opts.adapters = {} end
    table.insert(opts.adapters, require "neotest-plenary"(require("astrocore").plugin_opts "neotest-plenary"))
  end,
}

---@type LazyPluginSpec
local spec_neogen = {
  "danymat/neogen",
  optional = true,
  opts = function(_, opts)
    opts.languages = require("astrocore").extend_tbl(opts.languages or {}, {
      -- lua = { template = { annotation_convention = "ldoc" } },
      lua = { template = { annotation_convention = "emmylua" } },
    })
  end,
}

---@type LazyPluginSpec[]
return {
  spec_astrolsp,
  spec_nvim_treesitter,
  spec_mason_tool_installer_nvim,
  spec_neotest,
  spec_neogen,
}
