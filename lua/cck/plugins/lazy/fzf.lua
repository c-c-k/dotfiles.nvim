-- ===
-- FZF
-- ===

-- repo url: <https://github.com/junegunn/fzf>
-- nvim help: `:help fzf`

return {
  build = ":call fzf#install()",
  'junegunn/fzf',
}
