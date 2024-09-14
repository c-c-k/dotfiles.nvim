-- =======
-- FZF-VIM
-- =======

-- repo url: <https://github.com/junegunn/fzf.vim>
-- nvim help: `:help fzf-vim`

return {
  "junegunn/fzf.vim",
  name = "fzf-vim",
  init = function()
    vim.g["fzf_buffers_jump"] = 0
    vim.g["fzf_command_prefix"] = "Fzf"
  end,
}
