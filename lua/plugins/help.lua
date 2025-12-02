local my = require "my"

local spec_my_core_config = {
  dir = vim.fn.stdpath "config",
  opts = function(_)
    local aug_my_help_buf_core_config = my.autocmd.get_augroup {
      name = "aug_my_help_buf_core_config",
      clear = true,
    }
    my.autocmd.add_autocmd {
      group = aug_my_help_buf_core_config,
      event = "FileType",
      pattern = "help",
      desc = 'Set options, vars and mappings for the "help" filetype',
      callback = function(args)
        -- Override NVIM defaults.
        -- Needs to be done before the `did_ftplugin` check due to lazy.nvim emitting
        -- filetype autocommands multiple times and NVIM executing the default filetype
        -- config each time, see:
        --  * https://github.com/folke/lazy.nvim/issues/1993
        vim.opt_local.conceallevel = 0

        if vim.b[args.buf].did_ftplugin_my_help then return end
        vim.b[args.buf].did_ftplugin_my_help = true
      end,
    }
  end,
}

---@type LazyPluginSpec[]
return {
  spec_my_core_config,
}
