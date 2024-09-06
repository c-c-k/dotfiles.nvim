-- =======================================================
-- ASTRONVIM ASTROCORE (COMMANDS, AUTOCOMMANDS, FILETYPES)
-- =======================================================

-- repo url: <https://github.com/AstroNvim/astrocore>
-- nvim help: `:help astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- -- easily configure user commands
    -- commands = {
    --   -- key is the command name
    --   AstroReload = {
    --     -- first element with no key is the command (string or function)
    --     function() require("astrocore").reload() end,
    --     -- the rest are options for creating user commands (:h nvim_create_user_command)
    --     desc = "Reload AstroNvim (Experimental)",
    --   },
    -- },
    -- easily configure auto commands
    -- autocmds = {
    --   -- first key is the `augroup` (:h augroup)
    --   highlighturl = {
    --     -- list of auto commands to set
    --     {
    --       -- events to trigger
    --       event = { "VimEnter", "FileType", "BufEnter", "WinEnter" },
    --       -- the rest of the autocmd options (:h nvim_create_autocmd)
    --       desc = "URL Highlighting",
    --       callback = function() require("astrocore").set_url_match() end,
    --     },
    --   },
    -- },
    -- easily configure functions on key press
    -- on_keys = {
    --   -- first key is the namespace
    --   auto_hlsearch = {
    --     -- list of functions to execute on key press (:h vim.on_key)
    --     function(char) -- example automatically disables `hlsearch` when not actively searching
    --       if vim.fn.mode() == "n" then
    --         local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
    --         if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
    --       end
    --     end,
    --   },
    -- },
    -- passed to `vim.filetype.add`
    -- filetypes = {
    --   -- see `:h vim.filetype.add` for usage
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     [".foorc"] = "fooscript",
    --   },
    --   pattern = {
    --     [".*/etc/foo/.*"] = "fooscript",
    --   },
    -- },
  },
}
