local opt = vim.opt
local cmd = vim.cmd
local fn = vim.fn
local has = require("cck.utils.config").has

-- Set minimal autoformatting
opt.autoindent = true
opt.breakindent = true
opt.expandtab = true
opt.linebreak = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.textwidth = 78
vim.opt.formatlistpat = [==[^\s*\d\+[\]:.)}\t ]\s*\|^\s*-\s\|\s*[^:]:\s]==]
opt.formatoptions = "jcroqlnt1"

-- Improve buffer write/close handling:
--  - Avoid accidental writes.
--  - Confirm instead of error when closing unsaved buffer.
opt.autowrite = false
opt.autowriteall = false
opt.confirm = true

-- Improved visibility stuff:
opt.background = "dark"
-- cmd.colorscheme(...) -- applied in plugin config
opt.cursorline = true
cmd.syntax({ "enable" })

-- Set all swap and backup files to be written to the vim temp directory
-- to prevent them clattering every other directory with temporary vim files.
opt.backupdir = { fn.expand("$HOME/tmp/nvim/backup/"), ".", fn.stdpath("state") }
opt.dir = { fn.expand("$HOME/tmp/nvim/swap/"), ".", fn.stdpath("state") }
opt.undodir = { fn.expand("$HOME/tmp/nvim/undo/"), ".", fn.stdpath("state") }

-- Disable using clipboard/selection (+/*) instead of the unnamed register (") to avoid cluttering their history.
opt.clipboard = ""

-- Completion
--  - 'popup' is set for YCM because 'preview' is too intrusive
opt.completeopt = "menu,menuone,noselect,popup"

-- Disable conceal because nvim like vim tends to handle it badly anyway.
opt.conceallevel = 0

-- Enable pc_speaker noise because it's occasionally convenient.
opt.errorbells = true
opt.visualbell = false

-- Fold options that are vaguely convenient.
opt.foldenable = true
opt.foldlevel = 4
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldminlines = 0

-- Set ripgrep as nvim's grep tool
if fn.executable("rg") then
  opt.grepprg = [[rg --vimgrep --smart-case --hidden]]
  opt.grepformat = "%f:%l:%c:%m"
end

-- Disable hlsearch because it tends to be annoying.
opt.hlsearch = false

-- Disable modlines because they cause errors by detecting non-modeline lines
-- as modlines.
opt.modeline = false
opt.modelines = 0

-- Enable buffers changes reusing already opened buffers in other tabs and
-- windows.
-- NOTE: Disabled. Initially thought that it's convenient but later realized
-- that it's not due to the frequent need to open the same buffer in several
-- different tabs.
-- opt.switchbuf:append({"useopen", "usetab"})

-- Enable spellchecking.
-- Place `spellfile` inside `~/.vim/spell` as it might need to be shared
-- between vim, nvim and different distributions of them.
opt.spell = true
opt.spelllang = "en_us"
opt.spellfile = fn.expand("$HOME/.vim/spell/general.en.utf-8.add")

-- Set width of current window to 82 because it somehow tends to be
-- convenient more often than not.
opt.winwidth = 81
