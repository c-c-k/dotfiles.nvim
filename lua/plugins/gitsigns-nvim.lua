---@type LazyPluginSpec
local spec_gitsigns_nvim = {
  "lewis6991/gitsigns.nvim",
  opts = function(_, opts)
    -- local astro_on_attach = opts.on_attach
    local my = require "my"
    local astrocore = require "astrocore"
    local gitsigns = require "gitsigns"

    local function gitsigns_first_hunk_unstaged() --
      gitsigns.nav_hunk("first", { target = "unstaged" })
    end

    local function gitsigns_prev_hunk_unstaged()
      if vim.wo.diff then
        vim.cmd.normal { "]c", bang = true }
      else
        gitsigns.nav_hunk("prev", { target = "unstaged" })
      end
    end

    local function gitsigns_next_hunk_unstaged()
      if vim.wo.diff then
        vim.cmd.normal { "[c", bang = true }
      else
        gitsigns.nav_hunk("next", { target = "unstaged" })
      end
    end

    local function gitsigns_last_hunk_unstaged() --
      gitsigns.nav_hunk("last", { target = "unstaged" })
    end

    local function gitsigns_first_hunk_staged() --
      gitsigns.nav_hunk("first", { target = "staged" })
    end

    local function gitsigns_prev_hunk_staged() --
      gitsigns.nav_hunk("prev", { target = "staged" })
    end

    local function gitsigns_next_hunk_staged() --
      gitsigns.nav_hunk("next", { target = "staged" })
    end

    local function gitsigns_last_hunk_staged() --
      gitsigns.nav_hunk("last", { target = "staged" })
    end

    local function gitsigns_first_hunk_all() --
      gitsigns.nav_hunk("first", { target = "all" })
    end

    local function gitsigns_prev_hunk_all() --
      gitsigns.nav_hunk("prev", { target = "all" })
    end

    local function gitsigns_next_hunk_all() --
      gitsigns.nav_hunk("next", { target = "all" })
    end

    local function gitsigns_last_hunk_all() --
      gitsigns.nav_hunk("last", { target = "all" })
    end

    local function gitsigns_blame_line_full() --
      gitsigns.blame_line { full = true }
    end

    local function gitsigns_reset_hunk_visual() --
      gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
    end

    local function gitsigns_stage_hunk_visual() --
      gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
    end

    local function gitsigns_setqflist_all() --
      gitsigns.setqflist "all"
    end

    local function gitsigns_setloclist_all() --
      gitsigns.setloclist(0, "all")
    end

    opts.signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    }
    opts.signs_staged = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    }
    opts.attach_to_untracked = true

    opts.on_attach = function(bufnr)
      -- astro_on_attach(bufnr)

      local maps, map = my.keymap.get_astrocore_mapper()

      map("n", "[C", gitsigns_first_hunk_unstaged, { desc = "First Git Change (unstaged hunks)" })
      map("n", "[c", gitsigns_prev_hunk_unstaged, { desc = "Previos Git Change (unstaged hunks)" })
      map("n", "]c", gitsigns_next_hunk_unstaged, { desc = "Next Git Change (unstaged hunks)" })
      map("n", "]C", gitsigns_last_hunk_unstaged, { desc = "Last Git Change (unstaged hunks)" })
      map("n", "[U", gitsigns_first_hunk_staged, { desc = "First Git Undo (staged hunks)" })
      map("n", "[u", gitsigns_prev_hunk_staged, { desc = "Previos Git Undo (staged hunks)" })
      map("n", "]u", gitsigns_next_hunk_staged, { desc = "Next Git Undo (staged hunks)" })
      map("n", "]U", gitsigns_last_hunk_staged, { desc = "Last Git Undo (staged hunks)" })
      map("n", "[G", gitsigns_first_hunk_all, { desc = "First Git hunk (all hunks)" })
      map("n", "[g", gitsigns_prev_hunk_all, { desc = "Previos Git hunk (all hunks)" })
      map("n", "]g", gitsigns_next_hunk_all, { desc = "Next Git hunk (all hunks)" })
      map("n", "]G", gitsigns_last_hunk_all, { desc = "Last Git hunk (all hunks)" })
      map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "inner Git hunk" })
      map("n", "<LEADER>gb", gitsigns.blame_line, { desc = "View Git blame" })
      map("n", "<LEADER>gB", gitsigns_blame_line_full, { desc = "View full Git blame" })
      map("n", "<LEADER>gp", gitsigns.preview_hunk_inline, { desc = "Preview Git hunk inline" })
      map("n", "<LEADER>gP", gitsigns.preview_hunk, { desc = "Preview Git hunk" })
      map("n", "<LEADER>gr", gitsigns.reset_hunk, { desc = "Reset Git hunk" })
      map("x", "<LEADER>gr", gitsigns_reset_hunk_visual, { desc = "Reset Git hunk" })
      map("n", "<LEADER>gR", gitsigns.reset_buffer, { desc = "Reset Git buffer" })
      map("n", "<LEADER>gs", gitsigns.stage_hunk, { desc = "Stage/Unstage Git hunk" })
      map("x", "<LEADER>gs", gitsigns_stage_hunk_visual, { desc = "Stage/Unstage Git hunk" })
      map("n", "<LEADER>gS", gitsigns.stage_buffer, { desc = "Stage Git buffer" })
      map("n", "<LEADER>gd", gitsigns.diffthis, { desc = "View Git diff" })
      map("n", "<LEADER>gq", gitsigns.setqflist, { desc = "send Git hunks to qf list" })
      map("n", "<LEADER>gQ", gitsigns_setqflist_all, { desc = "send Git hunks from all buffers to qf list" })
      map("n", "<LEADER>gl", gitsigns.setloclist, { desc = "send Git hunks to loc list" })
      map("n", "<LEADER>gL", gitsigns_setloclist_all, { desc = "send Git hunks from all buffers to loc list" })
      map("n", "<LEADER>gD", ":Gitsigns diffthis ~", { desc = "View Git diff" })
      map("n", "<LEADER>ugb", gitsigns.toggle_current_line_blame, { desc = "Git toggle current line blame" })
      map("n", "<LEADER>ugw", gitsigns.toggle_word_diff, { desc = "Git toggle word diff" })
      map("n", "<LEADER>ugl", gitsigns.toggle_linehl, { desc = "Git toggle line highlight" })
      map("n", "<LEADER>ugn", gitsigns.toggle_numhl, { desc = "Git toggle number highlight" })
      map("n", "<LEADER>ugs", gitsigns.toggle_signs, { desc = "Git toggle sign column" })

      astrocore.set_mappings(maps, { buffer = bufnr })
    end
  end,
}

---@type LazyPluginSpec[]
return {
  spec_gitsigns_nvim,
}
