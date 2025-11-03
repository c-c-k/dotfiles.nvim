---@type LazyPluginSpec
local spec_astrolsp = {
  "AstroNvim/astrolsp",
  opts = {
    config = {
      bashls = {
        filetypes = { "sh", "bash", "zsh" },
      },
    },
  },
}

---@type LazyPluginSpec
local spec_nvim_treesitter = {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    if opts.ensure_installed ~= "all" then
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "bash" })
    end
  end,
}

---@type LazyPluginSpec
local spec_mason_tool_installer_nvim = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = function(_, opts)
    opts.ensure_installed = require("astrocore").list_insert_unique(
      opts.ensure_installed,
      { "bash-language-server", "shellcheck", "shfmt", "bash-debug-adapter" }
    )
  end,
}

---@type LazyPluginSpec[]
return {
  spec_astrolsp,
  spec_nvim_treesitter,
  spec_mason_tool_installer_nvim,
}
