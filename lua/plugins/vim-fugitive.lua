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
    local mycore = require "my.core"

    local function get_buf_dir_path() return vim.trim(vim.fn.execute "Git rev-parse --show-toplevel") end

    local aug_my_fugitive_buf_core_config = mycore.get_augroup {
      name = "aug_my_fugitive_buf_core_config",
      clear = true,
    }
    mycore.add_autocmd {
      group = aug_my_fugitive_buf_core_config,
      event = { "FileType" },
      pattern = "fugitive,git",
      desc = 'Set options, vars and mappings for the "fugitive,git" filetypes',
      callback = function(args)
        if vim.b[args.buf].did_ftplugin_my_fugitive then return end
        vim.b[args.buf].did_ftplugin_my_fugitive = true

        vim.b[args.buf].my_get_buf_dir_path = get_buf_dir_path

        local maps, map = require("my.core.keymaps").get_astrocore_mapper()

        -- mini.files integration
        map("n", "<LEADER>ofs", function()
          local current_dir = get_buf_dir_path()
          local success, error = pcall(require("mini.files").open, current_dir, false)
          if not success then vim.print(error) end
        end, { desc = "Open mini.files (git dir)" })

        -- oil.nvim integration
        map("n", "<LEADER>ofo", function()
          local has_oil, oil = pcall(require, "oil")
          if has_oil then
            local current_dir = get_buf_dir_path()
            oil.open(current_dir)
          else
            vim.print "oil.nvim plugin not present"
          end
        end, { desc = "Open oil.nvim (git dir)" })

        -- terminal integration
        map("n", "<LEADER>otl", function()
          local cur_directory = get_buf_dir_path()
          vim.cmd.lcd(cur_directory)
          vim.cmd.terminal()
          vim.cmd.startinsert()
        end, { desc = "Open terminal (git dir)" })

        astrocore.set_mappings(maps, { buffer = args.buf })
      end,
    }
  end,
}

spec_vim_fugitive.specs = {
  spec_vim_fugitive__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_vim_fugitive,
}
