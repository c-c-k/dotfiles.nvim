local my = require "my"
---@class my.ai.coco: my.ai.coco._submodules
local M = {}

M.opts = {}
M.opts.general = function(_, opts) ---@cast opts MyNoOptsSpec
  return my.tbl.merge_dicts_into_last(opts, {
    adapters = { http = my.ai.coco.adapters },
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
  } --[[@as MyNoOptsSpec]])
end
M.opts.core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_coco_ai_)
end

M.keymaps = {}

M.keymaps.add_to_chat = { ---@type my.keymap.keymap_spec
  desc = "Add to AI chat",
  rhs = "<CMD>CodeCompanionChat Add<CR>",
}
M.keymaps.find_ai_actions_n_ = { ---@type my.keymap.keymap_spec
  desc = "Find AI actions",
  rhs = "<CMD>CodeCompanionActions<CR>",
}
M.keymaps.find_ai_actions_x_ = { ---@type my.keymap.keymap_spec
  desc = "Find AI actions",
  rhs = ":'<,'>CodeCompanionActions<CR>",
}
M.keymaps.inline_cmd_n_ = { ---@type my.keymap.keymap_spec
  desc = "AI inline (CMD)",
  rhs = ":CodeCompanion ",
}
M.keymaps.inline_cmd_x_ = { ---@type my.keymap.keymap_spec
  desc = "AI inline (CMD)",
  rhs = ":'<,'>CodeCompanion ",
}
M.keymaps.open_new_chat = { ---@type my.keymap.keymap_spec
  desc = "Open new AI chat",
  rhs = "<CMD>CodeCompanionChat<CR>",
}
M.keymaps.open_new_chat_prompt = { ---@type my.keymap.keymap_spec
  desc = "Open new AI chat (CMD)",
  rhs = ":CodeCompanionChat ",
}
M.keymaps.toggle_chat = { ---@type my.keymap.keymap_spec
  desc = "Toggle AI chat",
  rhs = "<CMD>CodeCompanionChat Toggle<CR>",
}

return M
