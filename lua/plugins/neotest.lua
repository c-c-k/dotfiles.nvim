---@type LazyPluginSpec
local spec_neotest = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    -- "antoinemadec/FixCursorHold.nvim", -- redundant as of NVIM v0.8.0
    "nvim-treesitter/nvim-treesitter",
  },
  opts = function(_, opts)
    opts.floating = { border = "rounded" }
    if vim.g.icons_enabled == false then
      opts.icons = {
        failed = "X",
        notify = "!",
        passed = "O",
        running = "*",
        skipped = "-",
        unknown = "?",
        watching = "W",
      }
    end
  end,
  config = function(_, opts)
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, vim.api.nvim_create_namespace "neotest")
    require("neotest").setup(opts)
  end,
}

---@type LazyPluginSpec
local spec_neotest__astrocore = {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    local my = require "my"
    local astrocore = require "astrocore"
    local maps, map = my.keymap.get_astrocore_mapper()

    local get_file_path = function() return vim.fn.expand "%" end
    local get_project_path = function() return vim.fn.getcwd() end

    map("n", "<LEADER>tt", {
      function() require("neotest").run.run() end,
      desc = "Run test",
    })
    map("n", "<LEADER>td", {
      function() require("neotest").run.run { strategy = "dap" } end,
      desc = "Debug test",
    })
    map("n", "<LEADER>tf", {
      function() require("neotest").run.run(get_file_path()) end,
      desc = "Run all tests in file",
    })
    map("n", "<LEADER>tp", {
      function() require("neotest").run.run(get_project_path()) end,
      desc = "Run all tests in project",
    })
    map("n", "<LEADER>t<CR>", {
      function() require("neotest").summary.toggle() end,
      desc = "Toggle Test Summary",
    })
    map("n", "<LEADER>th", {
      function() require("neotest").output.open() end,
      desc = "Test Output hover",
    })
    map("n", "<LEADER>to", {
      function()
        require("neotest").output.open {
          open_win = function()
            vim.cmd.tabnew()
            vim.opt.number = false
            vim.opt.relativenumber = false
            vim.opt.signcolumn = "no"
          end,
          auto_close = true,
          enter = true,
          last_run = false,
          short = false,
        }
      end,
      desc = "Test Output to new tab",
    })
    map("n", "<LEADER>tO", {
      function() require("neotest").output_panel.toggle() end,
      desc = "Toggle Test Output Panel",
    })
    map("n", "]T", {
      function() require("neotest").jump.next() end,
      desc = "Next test",
    })
    map("n", "[T", {
      function() require("neotest").jump.prev() end,
      desc = "Previous test",
    })

    map("n", "<LEADER>twt", {
      function() require("neotest").watch.toggle() end,
      desc = "Toggle watch test",
    })
    map("n", "<LEADER>twf", {
      function() require("neotest").watch.toggle(get_file_path()) end,
      desc = "Toggle watch all test in file",
    })
    map("n", "<LEADER>twp", {
      function() require("neotest").watch.toggle(get_project_path()) end,
      desc = "Toggle watch all tests in project",
    })
    map("n", "<LEADER>twS", {
      function()
        --- NOTE: The proper type of the argument is missing in the documentation
        ---@see https://github.com/nvim-neotest/neotest/blob/master/doc/neotest.txt#L626-L632
        ---@diagnostic disable-next-line: missing-parameter
        require("neotest").watch.stop()
      end,
      desc = "Stop all watches",
    })
    --

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

---@type LazyPluginSpec
local spec_neotest__lazydev_nvim = {
  "folke/lazydev.nvim",
  opts = function(_, opts) opts.library = require("astrocore").extend_tbl(opts.library or {}, { "neotest" }) end,
}

spec_neotest.specs = {
  spec_neotest__astrocore,
  spec_neotest__lazydev_nvim,
}

---@type LazyPluginSpec[]
return {
  spec_neotest,
}
