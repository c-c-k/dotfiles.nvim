-- =============================
-- ASTRONVIM ASTROCORE (OPTIONS)
-- =============================

-- repo url: <https://github.com/AstroNvim/astrocore>
-- nvim help: `:help astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    -- easily configure vim options and globals
    -- first key should be same as `vim.<first_key>` e.g. "options.g" for "vim.g"
    local options = { g = {}, opt = {} }

    -- === set global `vim.g` settings here ===
    local g = options.g

    g.python3_host_prog = vim.fn.stdpath "config" .. "/.venv/bin/python3"

    -- === set `opt` style options here ===
    local opt = options.opt

    -- Autoformatting
    --  * Fallback autoformatting for when it's not provided by plugins and so.
    --  * 'textwidth' is set to 72 to account for a standard 80 char half screen
    --    and gutters.
    --  * 'tabstop' is set to 8 per the vim manual recommendation.
    --  * 'formatlistpat' is meant to accommodate for ordered and unordered lists.
    opt.autoindent = true
    opt.breakindent = true
    opt.expandtab = true
    opt.formatlistpat = [==[^\s*\d\+[\]:.)}\t ]\s*\|^\s*[-*+]\s\]==]
    opt.formatoptions = "jcroqlnt1"
    opt.linebreak = true
    opt.shiftwidth = 4
    opt.softtabstop = 4
    opt.tabstop = 8
    opt.textwidth = 72

    -- Improved visibility
    --  * Colorscheme is set in colorscheme plugin config
    --  * Set width of current window to standard 80 half screen.
    --  * Disable conceal because nvim like vim tends to handle it badly anyway.
    opt.background = "dark"
    opt.conceallevel = 0
    opt.cursorline = true
    opt.winwidth = 80

    -- Buffer write/close
    --  * Avoid accidental writes.
    --  * Confirm instead of error when closing unsaved buffer.
    opt.autowrite = false
    opt.autowriteall = false
    opt.confirm = true

    -- Swap/backup/undo
    --  * Backup files to a central temp/junk dir out of paranoia.
    opt.backup = true
    opt.writebackup = true
    opt.backupdir = { vim.fn.expand("$HOME/tmp/nvim/backup/"), ".", vim.fn.stdpath("state") .. "/backup/" }
    opt.dir = { vim.fn.stdpath("state") .. "/swap/", vim.fn.expand("$HOME/tmp/nvim/swap/"), "." }
    opt.undofile = true
    opt.undodir = { vim.fn.stdpath("state") .. "/undo/", vim.fn.expand("$HOME/tmp/nvim/undo/"), "." }

    -- Disable using clipboard/selection (+/*) instead of the unnamed register (") 
    --  * Done to avoid cluttering the clipboard/selection history.
    --  * Handled via dedicated mappings instead.
    opt.clipboard = ""

    -- Set ripgrep as nvim's grep tool
    if vim.fn.executable("rg") then
      opt.grepprg = [[rg --vimgrep]]
      opt.grepformat = "%f:%l:%c:%m"
    end

    -- Disable hlsearch because it tends to be annoying.
    opt.hlsearch = false

    -- Spellchecking
    --  * Place `spellfile` inside `~/.vim/spell` as it might need to be shared
    --    between vim, nvim and different distributions of them.
    opt.spell = true
    opt.spelllang = "en_us"
    opt.spellfile = vim.fn.expand("$HOME/.vim/spell/general.en.utf-8.add")

    opts.options = require("astrocore").extend_tbl(opts.options, options)
  end,
}
