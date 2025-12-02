local my = require "my"

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

    local function fugitive_open_with_command(cmd) --
      if vim.bo.filetype ~= "fugitive" and vim.bo.filetype ~= "git" then
        my.path.cd("Local", false)
        my.win.get_on_buf_change_win_toggler()()
      end

      my.win.open_cmd_in_current_win(cmd)
    end

    local function fugitive_open_from_buf() --
      fugitive_open_with_command ":Git"
    end

    local function fugitive_open_log_from_buf() --
      fugitive_open_with_command ":Git log --oneline"
    end

    local function fugitive_get_buf_dir_path() --
      return vim.trim(vim.fn.execute "Git rev-parse --show-toplevel")
    end

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

        vim.b[args.buf].my_get_buf_dir_path = fugitive_get_buf_dir_path
      end,
    }

    local maps, map = my.keymap.get_astrocore_mapper()

    map("n", "<LEADER>ogg", {
      function() fugitive_open_from_buf() end,
      desc = "Open fugitive git status",
    })
    map("n", "<LEADER>ogl", {
      function() fugitive_open_log_from_buf() end,
      desc = "Open fugitive git `log --oneline`",
    })

    opts.mappings = my.tbl.merge("dDFn", opts.mappings, maps)
  end,
}

spec_vim_fugitive.specs = {
  spec_vim_fugitive__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_vim_fugitive,
}
