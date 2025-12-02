local my = require "my"

---@type LazyPluginSpec
local spec_astrocore = {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      -- PLACEHOLDER
    },
    commands = {
      -- PLACEHOLDER
    },
    filetypes = {
      -- PLACEHOLDER
    },
    on_keys = {
      auto_hlsearch = {
        function(char)
          -- Override AstroNvim default auto_hlsearch function
          -- to not trigger hlsearch on <CR>.
          if vim.fn.mode() == "n" then
            local new_hlsearch = vim.tbl_contains({ "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
            if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
          end
        end,
      },
    },
  },
}

---@type LazyPluginSpec[]
return {
  spec_astrocore,
}
