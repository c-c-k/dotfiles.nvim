-- ===================
-- CODE COMPANION NVIM
-- ===================

-- repo url: <https://github.com/olimorris/codecompanion.nvim>
-- nvim help: `:help codecompanion.txt`

---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      { "stevearc/dressing.nvim", opts = {} },
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local astrocore = require "astrocore"
          local maps, map = require("cck.utils.config").get_astrocore_mapper()

          map({ "n", "v" }, "<LEADER>oan", "<CMD>CodeCompanionChat<CR>", { desc = "Open new AI chat" })
          map({ "n", "v" }, "<LEADER>oaN", ":CodeCompanionChat ", { desc = "Open new AI chat (CMD)" })
          map({ "n", "v" }, "<LEADER>oaa", "<CMD>CodeCompanionChat Toggle<CR>", { desc = "Toggle AI chat" })
          map("v", "ga", "<CMD>CodeCompanionChat Add<CR>", { desc = "Add to AI chat" })
          map("n", "<LEADER>aa", ":CodeCompanion ", { desc = "AI inline (CMD)" })
          map("v", "<LEADER>aa", ":'<,'>CodeCompanion ", { desc = "AI inline (CMD)" })
          map("n", "<LEADER>fa", "<CMD>CodeCompanionActions<CR>", { desc = "Find AI actions" })
          map("v", "<LEADER>fa", ":'<,'>CodeCompanionActions<CR>", { desc = "Find AI actions" })

          opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
        end,
      },
    },
    opts = {
      adapters = require "cck.codecompanion.adapters",
      strategies = {
        chat = {
          adapter = "gemini_codecompanion",
        },
        inline = {
          adapter = "gemini_codecompanion",
        },
        agent = {
          adapter = "gemini_codecompanion",
        },
      },
      display = {
        chat = {
          window = {
            layout = "buffer",
            opts = {
              cursorline = true,
              spell = true,
            },
          },
        },
        inline = {
          layout = "buffer",
        },
      },
      opts = {
        ---@param adapter CodeCompanion.Adapter
        ---@return string
        system_prompt = function(adapter)
          local system_prompts = require "cck.codecompanion.system_prompts"
          if system_prompts[adapter.name] then return system_prompts[adapter.name] end

          return [[You will return the message "Error: System prompt missing, double check nvim codecompanion plugin config file and $NVIM_CODECOMPANION_MODEL_PARAMS !" to all queries]]
        end,
      },
    },
  },
}
