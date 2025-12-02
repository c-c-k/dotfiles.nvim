local my = require "my"

---@type LazyPluginSpec
local spec_astrocore = {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    diagnostics = {
      virtual_text = true,
      underline = true,
      update_in_insert = false,
    },
    features = {
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = true, virtual_lines = false },
      highlighturl = true,
      large_buf = {
        enabled = function(bufnr, config)
          -- PLACEHOLDER
          return true
        end,
        notify = true,
        size = 1024 * 256,
        lines = 10000,
        line_length = 1000,
      },
      notifications = true,
    },
    git_worktrees = {
      -- PLACEHOLDER
    },
    rooter = {
      detector = {
        "lsp",
        { ".git", "_darcs", ".hg", ".bzr", ".svn" },
        { "lua", "MakeFile", "package.json" },
      },
      ignore = {
        servers = {},
        dirs = {},
      },
      autochdir = false,
      scope = "global",
      notify = false,
    },
    sessions = {
      autosave = {
        last = true,
        cwd = true,
      },
      ignore = {
        dirs = {},
        filetypes = { "gitcommit", "gitrebase" },
        buftypes = {},
      },
    },
  },
}

---@type LazyPluginSpec[]
return {
  spec_astrocore,
}
