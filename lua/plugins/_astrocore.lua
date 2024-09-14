-- ==============================================================
-- ASTRONVIM ASTROCORE (FEATURES, DIAGNOSTICS, ROOTER, SESSIONS)
-- ==============================================================

-- repo url: <https://github.com/AstroNvim/astrocore>
-- nvim help: `:help astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      -- Configure core features of AstroNvim
      -- features = {
      --   -- enable or disable autopairs on start
      --   autopairs = true,
      --   -- enable or disable cmp on start
      --   cmp = true,
      --   -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = off)
      --   diagnostics_mode = 3,
      --   -- enable or disable highlighting of urls on start
      --   highlighturl = true,
      --   -- set global limits for large files for disabling features like treesitter
      --   large_buf = { size = 1024 * 256, lines = 10000 },
      --   -- enable or disable notifications on start
      --   notifications = true,
      -- },

      -- Configure diagnostics options (`:h vim.diagnostic.config()`)
      -- diagnostics = {
      --   virtual_text = true,
      --   underline = true,
      --   update_in_insert = true,
      -- },

      -- Configure project root detection, check status with `:AstroRootInfo`
      -- rooter = {
      --   -- list of detectors in order of prevalence, elements can be:
      --   --   "lsp" : lsp detection
      --   --   string[] : a list of directory patterns to look for
      --   --   fun(bufnr: integer): string|string[] : a function that takes a buffer number and outputs detected roots
      --   detector = {
      --     -- highest priority is getting workspace from running language servers
      --     "lsp",
      --     -- next check for a version controlled parent directory
      --     { ".git", "_darcs", ".hg", ".bzr", ".svn" },
      --     -- lastly check for known project root files
      --     { "lua", "MakeFile", "package.json" },
      --   },

      --   -- ignore things from root detection
      --   ignore = {
      --     -- list of language server names to ignore (Ex. { "efm" })
      --     servers = {},
      --     -- list of directory patterns (Ex. { "~/.cargo/*" })
      --     dirs = {},
      --   },

      --   -- automatically update working directory (update manually with `:AstroRoot`)
      --   autochdir = false,
      --   -- scope of working directory to change ("global"|"tab"|"win")
      --   scope = "global",
      --   -- show notification on every working directory change
      --   notify = false,
      -- },

      -- Configuration table of session options for AstroNvim's session management powered by Resession
      -- sessions = {
      --   -- Configure auto saving
      --   autosave = {
      --     -- auto save last session
      --     last = true,
      --     -- auto save session for each working directory
      --     cwd = true,
      --   },
      --   -- Patterns to ignore when saving sessions
      --   ignore = {
      --     -- working directories to ignore sessions in
      --     dirs = {},
      --     -- filetypes to ignore sessions
      --     filetypes = { "gitcommit", "gitrebase" },
      --     -- buffer types to ignore sessions
      --     buftypes = {},
      --   },
      -- },

      -- Enable git integration for detached worktrees
      -- see: <https://www.atlassian.com/git/tutorials/dotfiles>
      -- git_worktrees = {
      --   { toplevel = vim.env.HOME, gitdir = vim.env.HOME .. "/.dotfiles" },
      -- },
    } --[[@as AstroCoreOpts]])
  end,
}
