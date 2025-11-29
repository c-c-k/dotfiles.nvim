---@type LazyPluginSpec
local spec_vim_fugitive = {
  "tpope/vim-fugitive",
}

---@type LazyPluginSpec
local spec_vim_fugitive__astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local my = require "my"
    local astrocore = require "astrocore"

    local function get_buf_dir_path() return vim.trim(vim.fn.execute "Git rev-parse --show-toplevel") end

    local aug_my_fugitive_buf_core_config = my.autocmd.get_augroup {
      name = "aug_my_fugitive_buf_core_config",
      clear = true,
    }
    my.autocmd.add_autocmd {
      group = aug_my_fugitive_buf_core_config,
      event = { "FileType" },
      pattern = "fugitive,git",
      desc = 'Set options, vars and mappings for the "fugitive,git" filetypes',
      callback = function(args)
        if vim.b[args.buf].did_ftplugin_my_fugitive then return end
        vim.b[args.buf].did_ftplugin_my_fugitive = true

        vim.b[args.buf].my_get_buf_dir_path = get_buf_dir_path

        local maps, map = my.keymap.get_astrocore_mapper()

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
