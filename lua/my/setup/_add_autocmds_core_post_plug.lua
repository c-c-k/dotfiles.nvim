local my = require "my"

-- TODO: Remove when sure this is redundant
--
-- my.autocmd.add_autocmd {
--   desc = "Disable VIM regex highlighting for buffers that have a treesitter parser",
--   group = "my.syntax.regex.disable_when_treesitter",
--   event = "BufEnter",
--   callback = function(args)
--     if my.syntax.ts.buf_has_parser() then my.syntax.regex.syntax_hl_toggle_buf(false, args.buf) end
--   end,
-- }

my.autocmd.add_autocmd {
  desc = "Highlight yanked text",
  group = "my.text_yank_hl",
  event = "TextYankPost",
  pattern = "*",
  callback = function() --
    vim.hl.on_yank()
  end,
}

my.autocmd.add_autocmd {
  desc = "Unlist quickfix buffers",
  group = "my.unlist_quickfix",
  event = "FileType",
  pattern = "qf",
  callback = function() --
    vim.opt_local.buflisted = false
  end,
}

my.autocmd.add_autocmd {
  desc = "Restore last cursor position when opening a file",
  group = "my.restore_cursor",
  event = "BufReadPost",
  callback = function(args) --
    local buf_id = args.buf
    if my.config.last_loc_restored_buf[buf_id] or vim.tbl_contains({ "gitcommit" }, vim.bo[buf_id].filetype) then
      return
    end
    my.config.last_loc_restored_buf[buf_id] = true
    local mark = vim.api.nvim_buf_get_mark(buf_id, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(buf_id) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
}

my.autocmd.add_autocmd {
  desc = "Check if buffers changed when leaving terminal buffer",
  group = "my.check_m_time_after_term",
  event = { "TermClose", "TermLeave" },
  command = "checktime",
}
