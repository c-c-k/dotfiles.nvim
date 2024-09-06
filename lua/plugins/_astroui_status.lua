-- ==========================
-- ASTRONVIM ASTROUI (STATUS)
-- ==========================

-- repo url: <https://github.com/AstroNvim/astroui>
-- nvim help: `:help astroui`

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@param opts AstroUIOpts
  opts = function(_, opts)
    -- Configuration options for the AstroNvim lines and bars built with the `status` API.
    opts.status = require("astrocore").extend_tbl(opts.status, {
      -- Configure attributes of components defined in the `status` API. Check the AstroNvim documentation for a complete list of color names, this applies to colors that have `_fg` and/or `_bg` names with the suffix removed (ex. `git_branch_fg` as attributes from `git_branch`).
      -- attributes = {
      --   git_branch = { bold = true },
      -- },

      -- Configure colors of components defined in the `status` API. Check the AstroNvim documentation for a complete list of color names.
      -- colors = {
      --   git_branch_fg = "#ABCDEF",
      -- },

      -- Configure which icons that are highlighted based on context
      -- icon_highlights = {
      --   -- enable or disable breadcrumb icon highlighting
      --   breadcrumbs = false,
      --   -- Enable or disable the highlighting of filetype icons both in the statusline and tabline
      --   file_icon = {
      --     tabline = function(self) return self.is_active or self.is_visible end,
      --     statusline = true,
      --   },
      -- },

      -- Configure characters used as separators for various elements
      -- separators = {
      --   none = { "", "" },
      --   left = { "", "  " },
      --   right = { "  ", "" },
      --   center = { "  ", "  " },
      --   tab = { "", "" },
      --   breadcrumbs = "  ",
      --   path = "  ",
      -- },

      -- Configure enabling/disabling of winbar
      -- winbar = {
      --   enabled = { -- whitelist buffer patterns
      --     filetype = { "gitsigns.blame" },
      --   },
      --   disabled = { -- blacklist buffer patterns
      --     buftype = { "nofile", "terminal" },
      --   },
      -- },
    })
  end,
}
