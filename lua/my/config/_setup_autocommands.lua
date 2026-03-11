local my = require "my"

my.vars.autocmds.setup_handles_delete()
my.tab.autocmds.my_tab_closed()
my.config.setup_core_autocmds()
my.lsp.setup_lsp_autocmds()
my.ft.enable_lsp_clients()
my.ft.setup_filetype_autocmds()

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
    local bufnr = args.buf
    if vim.b[bufnr].last_loc_restored or vim.tbl_contains({ "gitcommit" }, vim.bo[bufnr].filetype) then return end
    vim.b[bufnr].last_loc_restored = true
    local mark = vim.api.nvim_buf_get_mark(bufnr, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(bufnr) then
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
