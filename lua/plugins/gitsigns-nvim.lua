-- =============
-- GITSIGNS.NVIM
-- =============

-- repo url: <https://github.com/lewis6991/gitsigns.nvim>
-- nvim help: `:help gitsigns`

return {
  "lewis6991/gitsigns.nvim",
  opts = function(_, opts)
    local astro_on_attach = opts.on_attach

    opts.on_attach = function(bufnr)
      astro_on_attach(bufnr)

      local astrocore = require "astrocore"

      local maps, map = require("cck.utils.config").get_astrocore_mapper()

      map("n", "<LEADER>gl", function() require("gitsigns").blame_line() end, { desc = "View Git blame" })
      map(
        "n",
        "<LEADER>gL",
        function() require("gitsigns").blame_line { full = true } end,
        { desc = "View full Git blame" }
      )
      map("n", "<LEADER>gp", function() require("gitsigns").preview_hunk_inline() end, { desc = "Preview Git hunk" })
      map("n", "<LEADER>gr", function() require("gitsigns").reset_hunk() end, { desc = "Reset Git hunk" })
      map(
        "v",
        "<LEADER>gr",
        function() require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" } end,
        { desc = "Reset Git hunk" }
      )
      map("n", "<LEADER>gR", function() require("gitsigns").reset_buffer() end, { desc = "Reset Git buffer" })
      map("n", "<LEADER>gs", function() require("gitsigns").stage_hunk() end, { desc = "Stage Git hunk" })
      map(
        "v",
        "<LEADER>gs",
        function() require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" } end,
        { desc = "Stage Git hunk" }
      )
      map("n", "<LEADER>gS", function() require("gitsigns").stage_buffer() end, { desc = "Stage Git buffer" })
      map("n", "<LEADER>gu", function() require("gitsigns").undo_stage_hunk() end, { desc = "Unstage Git hunk" })
      map("n", "<LEADER>gd", function() require("gitsigns").diffthis() end, { desc = "View Git diff" })

      astrocore.set_mappings(maps, { buffer = bufnr })
    end
  end,
}
