local my = require "my"

---@type LazyPluginSpec
local spec_astroui = {
  "AstroNvim/astroui",
  opts = function(_, opts)
    return my.tbl.merge("dDFn", opts, {
      folding = {
        -- PLACEHOLDER
      },
      highlights = {
        -- PLACEHOLDER
      },
      icons = {
        -- PLACEHOLDER
      },
      text_icons = {
        -- PLACEHOLDER
      },
      lazygit = {
        -- PLACEHOLDER
      },
    } --[[@as AstroUIOpts]])
  end,
}

---@type LazyPluginSpec
local spec_astroui__astrocore = {
  "AstroNvim/astrocore",
  opts = function()
    local astrocore_buffer = require "astrocore.buffer"
    local astroui_foldexpr = "v:lua.require'astroui.folding'.foldexpr()"

    local aug_persistent_astroui_foldexpr = my.autocmd.get_augroup {
      name = "aug_persistent_astroui_foldexpr",
      clear = true,
    }
    my.autocmd.add_autocmd {
      group = aug_persistent_astroui_foldexpr,
      event = { "FileType" },
      -- pattern = "*",
      desc = "Set `foldexpr` to AstroUI foldexpr for all windows",
      callback = function()
        if astrocore_buffer.is_valid() then
          if vim.wo[0][0].foldexpr ~= astroui_foldexpr and vim.go.foldexpr == astroui_foldexpr then
            vim.wo[0][0].foldexpr = astroui_foldexpr
          end
        end
      end,
    }
  end,
}

spec_astroui.specs = {
  spec_astroui__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_astroui,
}
