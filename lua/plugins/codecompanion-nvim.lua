local my = require "my"

---@type LazyPluginSpec
local spec_codecompanion_nvim = {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
  },
  opts = function(_, opts)
    local astrocore = require "astrocore"
    -- local new_opts = {
    return my.tbl.merge("dDFn", opts, {
      adapters = { http = my.codecompanion.adapters },
      strategies = {
        chat = {
          adapter = "gemini",
        },
        inline = {
          adapter = "gemini",
        },
        agent = {
          adapter = "gemini",
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
        -- ---@param opts table
        -- ---@return string
        -- system_prompt = function(opts)
        --   local system_prompts = my.codecompanion.system_prompts
        --   if system_prompts[opts.adapter.name] then return system_prompts[opts.adapter.name] end
        --
        --   vim.notify(
        --     ("system prompt not found for '%s' in %s"):format(
        --       vim.inspect(opts),
        --       vim.inspect(vim.tbl_keys(system_prompts))
        --     ),
        --     vim.log.levels.WARN,
        --     {}
        --   )
        --   return [[You will return the message "Error: System prompt missing, double check nvim codecompanion plugin config file and $NVIM_CODECOMPANION_MODEL_PARAMS !" to all queries]]
        -- end,
      },
    })
  end,
}

---@type LazyPluginSpec
local spec_codecompanion_nvim__astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local maps, map = my.keymap.get_astrocore_mapper()

    map({ "n", "v" }, "<LEADER>oan", "<CMD>CodeCompanionChat<CR>", { desc = "Open new AI chat" })
    map({ "n", "v" }, "<LEADER>oaN", ":CodeCompanionChat ", { desc = "Open new AI chat (CMD)" })
    map({ "n", "v" }, "<LEADER>oaa", "<CMD>CodeCompanionChat Toggle<CR>", { desc = "Toggle AI chat" })
    map("v", "ga", "<CMD>CodeCompanionChat Add<CR>", { desc = "Add to AI chat" })
    map("n", "<LEADER>aa", ":CodeCompanion ", { desc = "AI inline (CMD)" })
    map("v", "<LEADER>aa", ":'<,'>CodeCompanion ", { desc = "AI inline (CMD)" })
    map("n", "<LEADER>fa", "<CMD>CodeCompanionActions<CR>", { desc = "Find AI actions" })
    map("v", "<LEADER>fa", ":'<,'>CodeCompanionActions<CR>", { desc = "Find AI actions" })

    opts.mappings = my.tbl.merge("dDFn", opts.mappings, maps)
  end,
}
spec_codecompanion_nvim.specs = {
  spec_codecompanion_nvim__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_codecompanion_nvim,
}
