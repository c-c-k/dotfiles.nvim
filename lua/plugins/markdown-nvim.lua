---@type LazyPluginSpec
local spec_markdown_nvim = {
  "tadmccorkle/markdown.nvim",
  ft = "markdown",
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local uleader = vim.g.usermapleader
    return astrocore.extend_tbl(opts, {
      mappings = {
        inline_surround_toggle = uleader .. "smm",
        inline_surround_toggle_line = uleader .. "sml",
        inline_surround_delete = uleader .. "smd",
        inline_surround_change = uleader .. "smc",
        link_add = false, -- "gl",
        link_follow = false, -- "gx",
        go_curr_heading = "]c",
        go_parent_heading = "]p",
        go_next_heading = "]]",
        go_prev_heading = "[[",
      },
      inline_surround = {
        emphasis = {
          key = "i",
          txt = "*",
        },
        strong = {
          key = "b",
          txt = "**",
        },
        strikethrough = {
          key = "s",
          txt = "~~",
        },
        code = {
          key = "c",
          txt = "`",
        },
      },
      link = {
        paste = {
          enable = true,
        },
      },
      toc = {
        omit_heading = "toc omit heading",
        omit_section = "toc omit section",
        markers = { "-" },
      },
      hooks = {
        follow_link = nil,
      },
      on_attach = function(bufnr)
        -- selene: allow(shadowing)
        ---@diagnostic disable-next-line: redefined-local
        local maps, map = require("cck.core.keymaps").get_astrocore_mapper()

        -- map({ "n", "i" }, "<M-l><M-o>", "<Cmd>MDListItemBelow<CR>", { desc = "Insert list item below" })
        -- map({ "n", "i" }, "<M-L><M-O>", "<Cmd>MDListItemAbove<CR>", { desc = "Insert list item above" })
        map("n", "<LEADER><CR>", "<Cmd>MDTaskToggle<CR>", { desc = "Toggle MD checkbox" })
        map("x", "<LEADER><CR>", ":MDTaskToggle<CR>", { desc = "Toggle MD checkbox" })
        map("n", "<LEADER>oto", "<Cmd>MDTocAll<CR>", { desc = "Open TOC in loc list" })
        map("n", "<LEADER>otO", ":MDTocAll 2", { desc = "Open TOC in loc list (select max h level)" })

        astrocore.set_mappings(maps, { buffer = bufnr })
      end,
    })
  end,
}

---@type LazyPluginSpec[]
return {
  spec_markdown_nvim,
}
