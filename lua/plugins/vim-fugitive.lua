---@type LazyPluginSpec
local spec_vim_fugitive = {
  "tpope/vim-fugitive",
}

---@type LazyPluginSpec
local spec_vim_fugitive__astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    opts.autocmds = astrocore.extend_tbl(opts.autocmds, {
      setfugitivemappings = {
        {
          event = { "FileType" },
          pattern = "fugitive,git",
          desc = "Set mappings for git and fugitive buffers",
          callback = function(args)
            local maps, map = require("cck.utils.config").get_astrocore_mapper()

            local function get_git_dir() return vim.trim(vim.fn.execute "Git rev-parse --show-toplevel") end

            local fscd = function(scope)
              local current_dir = get_git_dir()

              require("cck.utils.editor").schdir(current_dir, scope)
            end

            map("n", "<LEADER>qppp", function() fscd "a" end, { desc = "Set PWD to git dir(active-scope)" })
            map("n", "<LEADER>qppg", function() fscd "g" end, { desc = "Set PWD to git dir(global-scope)" })
            map("n", "<LEADER>qppt", function() fscd "t" end, { desc = "Set PWD to git dir(tab-scope)" })
            map("n", "<LEADER>qppw", function() fscd "w" end, { desc = "Set PWD to git dir(win-scope)" })
            map("n", "<LEADER>qpr", { desc = "Disabled in git window" })
            map("n", "<LEADER>qprr", "", { desc = "Disabled in git window" })
            map("n", "<LEADER>qprg", "", { desc = "Disabled in git window" })
            map("n", "<LEADER>qprw", "", { desc = "Disabled in git window" })
            map("n", "<LEADER>qprt", "", { desc = "Disabled in git window" })

            -- mini.files integration
            map("n", "<LEADER>ofs", function()
              local current_dir = get_git_dir()
              local success, error = pcall(MiniFiles.open, current_dir, false)
              if not success then vim.print(error) end
            end, { desc = "Open mini.files (git dir)" })

            -- oil.nvim integration
            map("n", "<LEADER>ofo", function()
              local has_oil, oil = pcall(require, "oil")
              if has_oil then
                local current_dir = get_git_dir()
                oil.open(current_dir)
              else
                vim.print "oil.nvim plugin not present"
              end
            end, { desc = "Open oil.nvim (git dir)" })

            -- terminal integration
            map("n", "<LEADER>otl", function()
              local cur_directory = get_git_dir()
              vim.cmd.lcd(cur_directory)
              vim.cmd.terminal()
              vim.cmd.startinsert()
            end, { desc = "Open terminal (git dir)" })

            astrocore.set_mappings(maps, { buffer = args.buf })
          end,
        },
      },
    })
  end,
}

spec_vim_fugitive.specs = {
  spec_vim_fugitive__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_vim_fugitive,
}
