-- =======
-- ZK-NVIM
-- =======

-- repo url: <https://github.com/zk-org/zk-nvim>
-- nvim help: `:help zk-zk-nvim`

return {
  "zk-org/zk-nvim",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local astrocore = require "astrocore"
        local maps, map = require("cck.utils.config").get_astrocore_mapper()

        map({ "n", "v" }, "<LEADER>on", { desc = "Open Note" })
        map(
          "n",
          "<LEADER>onn",
          "<Cmd>ZkNew { dir = vim.fn.input('Dir: '), title = vim.fn.input('Title: ') }<CR>",
          { desc = "Open Note (zk-default)" }
        )
        map(
          "n",
          "<LEADER>onj",
          "<Cmd>ZkNew { group = 'journal', dir = 'journal' }<CR>",
          { desc = "Open Note (zk-journal)" }
        )
        map("v", "<LEADER>ont", ":'<,'>ZkNewFromTitleSelection<CR>", { desc = "Open Note (zk-title-select)" })
        map("n", "<LEADER>fn", { desc = "Find Note" })
        map(
          "n",
          "<LEADER>fnN",
          "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
          { desc = "Find Note (all-title-input)" }
        )
        map("n", "<LEADER>fnn", "<Cmd>ZkNotes<CR>", { desc = "Find Note (all-title)" })
        map("n", "<LEADER>fnt", "<Cmd>ZkTags<CR>", { desc = "Find Note (all-tags)" })
        map("n", "<LEADER>fnl", "<Cmd>ZkLinks<CR>", { desc = "Find Note Links" })
        map("n", "<LEADER>fnb", "<Cmd>ZkBacklinks<CR>", { desc = "Find Note Backlinks" })
        map("n", "<LEADER>il", { desc = "Insert Link" })
        map("n", "<LEADER>ill", "<Cmd>ZkInsertLink<CR>", { desc = "Insert Link (zk-default)" })

        opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
      end,
    },
  },
  opts = {
    -- can be "telescope", "fzf", "fzf_lua", "minipick", or "select" (`vim.ui.select`)
    -- it's recommended to use "telescope", "fzf", "fzf_lua", or "minipick"
    picker = "telescope",

    lsp = {
      -- `config` is passed to `vim.lsp.start_client(config)`
      config = {
        cmd = { "zk", "lsp" },
        name = "zk",
        -- on_attach = ...
        -- etc, see `:h vim.lsp.start_client()`
      },

      -- automatically attach buffers in a zk notebook that match the give filetypes
      auto_attach = {
        enabled = true,
        filetypes = { "markdown" },
      },
    },
  },
  config = function(_, opts) require("zk").setup(opts) end,
}
