-- ==================
-- NVIM-CMP + LUASNIP
-- ==================

-- repo url: <https://github.com/hrsh7th/nvim-cmp>
-- nvim help: `:help nvim-cmp`
-- repo url: <https://github.com/L3MON4D3/LuaSnip>
-- nvim help: `:help luasnip.txt`

return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local luasnip, cmp = require "luasnip", require "cmp"
      if not opts.mappings then opts.mappings = {} end
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if vim.api.nvim_get_mode().mode ~= "c" and luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" })
      opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        if vim.api.nvim_get_mode().mode ~= "c" and luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" })
    end,
  },
  "L3MON4D3/LuaSnip",
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local astrocore = require "astrocore"
      local astromaps = opts.mappings

      local maps, map = require("cck.utils.config").get_astrocore_mapper()

      map("n", "<LEADER>uc", { copy = { "n", "<Leader>uc", source = astromaps } }) -- desc = "Toggle autocompletion (buffer)"
      map("n", "<LEADER>uC", { copy = { "n", "<Leader>uC", source = astromaps } }) -- desc = "Toggle autocompletion (global)"

      opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
    end,
  },
}
