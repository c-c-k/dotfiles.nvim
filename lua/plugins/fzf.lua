-- ===
-- FZF
-- ===

-- repo url: <https://github.com/junegunn/fzf>
-- nvim help: `:help fzf`

return {
  "junegunn/fzf",
  build = ":call fzf#install()",
}
