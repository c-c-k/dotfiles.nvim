local my = require "my"

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
  opts = function(_, opts)
    if opts.ensure_installed ~= "all" then
      opts.ensure_installed = my.tbl.merge("lun", opts.ensure_installed, { "lua", "luap" })
    end
  end,
}

---@type LazyPluginSpec
local spec_mason_tool_installer_nvim = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = function(_, opts)
    opts.ensure_installed = my.tbl.merge("lun", opts.ensure_installed, {
      "lua-language-server",
      "stylua",
      (not is_aarch64 and "selene") or nil,
    })
  end,
}

---@type LazyPluginSpec
local spec_neotest = {
  "nvim-neotest/neotest",
  dependencies = { "nvim-neotest/neotest-plenary", config = function() end },
  opts = function(_, opts)
    if not opts.adapters then opts.adapters = {} end
    table.insert(opts.adapters, require "neotest-plenary"(require("astrocore").plugin_opts "neotest-plenary"))
  end,
}

---@type LazyPluginSpec
local spec_neogen = {
  "danymat/neogen",
  opts = function(_, opts)
    opts.languages = my.tbl.merge("dDFn", opts.languages, {
      -- lua = { template = { annotation_convention = "ldoc" } },
      lua = { template = { annotation_convention = "emmylua" } },
    })
  end,
}

local spec_my_core_config = {
  "AstroNvim/astrocore",
  opts = function(_)
    local aug_my_lua_buf_core_config = my.autocmd.get_augroup {
      name = "aug_my_lua_buf_core_config",
      clear = true,
    }
    my.autocmd.add_autocmd {
      group = aug_my_lua_buf_core_config,
      event = "FileType",
      pattern = "lua",
      desc = 'Set options, vars and mappings for the "lua" filetype',
      callback = function(args)
        if vim.b[args.buf].did_ftplugin_my_lua then return end
        vim.b[args.buf].did_ftplugin_my_lua = true

        vim.opt_local.textwidth = 0
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
      end,
    }
  end,
}

---@type LazyPluginSpec[]
return {
  spec_astrolsp,
  spec_nvim_treesitter,
  spec_mason_tool_installer_nvim,
  spec_neotest,
  spec_neogen,
  spec_my_core_config,
}
