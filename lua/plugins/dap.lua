-- ======================
-- NVIM-DAP + NVIM-DAP-UI
-- ======================

-- repo url: <https://github.com/mfussenegger/nvim-dap>
-- repo url: <https://github.com/rcarriga/nvim-dap-ui>
-- nvim help: `:help dap.txt`
-- nvim help: `:help nvim-dap-ui`

return {
  "mfussenegger/nvim-dap",
  lazy = true,
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local astrocore = require "astrocore"
        local astromaps = opts.mappings

        local maps, map = require("cck.utils.config").get_astrocore_mapper()

        map("n", "<LEADER>rb", { copy = { "n", "<Leader>db", source = astromaps } }) -- desc = "Toggle Breakpoint (F9)"
        map("n", "<LEADER>rB", { copy = { "n", "<Leader>dB", source = astromaps } }) -- desc = "Clear Breakpoints"
        map("n", "<LEADER>rc", { copy = { "n", "<Leader>dc", source = astromaps } }) -- desc = "Start/Continue (F5)"
        map("n", "<LEADER>rC", { copy = { "n", "<Leader>dC", source = astromaps } }) -- desc = "Conditional Breakpoint (S-F9)"
        map("n", "<LEADER>ri", { copy = { "n", "<Leader>di", source = astromaps } }) -- desc = "Step Into (F11)"
        map("n", "<LEADER>ro", { copy = { "n", "<Leader>do", source = astromaps } }) -- desc = "Step Over (F10)"
        map("n", "<LEADER>rO", { copy = { "n", "<Leader>dO", source = astromaps } }) -- desc = "Step Out (S-F11)"
        map("n", "<LEADER>rq", { copy = { "n", "<Leader>dq", source = astromaps } }) -- desc = "Close Session"
        map("n", "<LEADER>rQ", { copy = { "n", "<Leader>dQ", source = astromaps } }) -- desc = "Terminate Session (S-F5)"
        map("n", "<LEADER>rp", { copy = { "n", "<Leader>dp", source = astromaps } }) -- desc = "Pause (F6)"
        map("n", "<LEADER>rr", { copy = { "n", "<Leader>dr", source = astromaps } }) -- desc = "Restart (C-F5)"
        map("n", "<LEADER>rR", { copy = { "n", "<Leader>dR", source = astromaps } }) -- desc = "Toggle REPL"
        map("n", "<LEADER>rs", { copy = { "n", "<Leader>ds", source = astromaps } }) -- desc = "Run To Cursor"

        opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
      end,
    },
    {
      "rcarriga/nvim-dap-ui",
      lazy = true,
      dependencies = {
        {
          "AstroNvim/astrocore",
          opts = function(_, opts)
            local astrocore = require "astrocore"
            local astromaps = opts.mappings

            local maps, map = require("cck.utils.config").get_astrocore_mapper()

            map("n", "<LEADER>rE", { copy = { "n", "<Leader>dE", source = astromaps } }) -- desc = "Evaluate Input"
            map("v", "<LEADER>rE", { copy = { "v", "<Leader>dE", source = astromaps } }) -- desc = "Evaluate Input"
            map("n", "<LEADER>ru", { copy = { "n", "<Leader>du", source = astromaps } }) -- desc = "Toggle Debugger UI"
            map("n", "<LEADER>rh", { copy = { "n", "<Leader>dh", source = astromaps } }) -- desc = "Debugger Hover"

            opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
          end,
        },
      },
    },
  },
}
