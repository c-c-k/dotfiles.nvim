---@type LazyPluginSpec
local spec_nvim_treesitter = {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    if opts.ensure_installed ~= "all" then
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "markdown", "markdown_inline" })
    end
  end,
}

---@type LazyPluginSpec
local spec_mason_tool_installer_nvim = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = function(_, opts)
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "marksman", "mdformat" })
  end,
}

local spec_my_core_config = {
  dir = vim.fn.stdpath "config",
  opts = function(_)
    local my = require "my"
    local astrocore = require "astrocore"

    local aug_my_markdown_buf_core_config = my.autocmd.get_augroup {
      name = "aug_my_markdown_buf_core_config",
      clear = true,
    }
    my.autocmd.add_autocmd {
      group = aug_my_markdown_buf_core_config,
      event = "FileType",
      pattern = "markdown",
      desc = 'Set options, vars and mappings for the "markdown" filetype',
      callback = function(args)
        -- Override NVIM defaults.
        -- Needs to be done before the `did_ftplugin` check due to lazy.nvim emitting
        -- filetype autocommands multiple times and NVIM executing the default filetype
        -- config each time, see:
        --  * https://github.com/folke/lazy.nvim/issues/1993
        vim.opt_local.formatoptions = "tcroqwn2l1j"

        if vim.b[args.buf].did_ftplugin_my_markdown then return end
        vim.b[args.buf].did_ftplugin_my_markdown = true

        local maps, map = require("my.core.keymaps").get_astrocore_mapper()

        map({ "n", "x" }, "<LEADER>gf", "<CMD>MyGoToFile<CR>", { desc = "goto file" })
        map({ "n", "x" }, "<LEADER>gx", "<CMD>MyGoToEx<CR>", { desc = "goto external" })
        map({ "n", "x" }, "gf", "<CMD>MyGoToFile<CR>", { desc = "goto file" })
        map({ "n", "x" }, "gx", "<CMD>MyGoToEx<CR>", { desc = "goto external" })

        astrocore.set_mappings(maps, { buffer = args.buf })
      end,
    }
  end,
}

---@type LazyPluginSpec[]
return {
  spec_nvim_treesitter,
  spec_mason_tool_installer_nvim,
  spec_my_core_config,
}
