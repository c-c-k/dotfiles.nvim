local g = vim.g
local opt = vim.opt

-- # Globals: Paths

g.python3_host_prog = vim.fn.stdpath "config" .. "/.venv/bin/python3"

-- # Opts: Autoformatting
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

-- # Opts: Improved Visibility
opt.background = "dark"
opt.cmdheight = 1
opt.conceallevel = 0
opt.cursorline = true
opt.winwidth = 80
opt.wrap = true

-- # Opts: Buffer Write/Close
opt.autowrite = false
opt.autowriteall = false
opt.confirm = true

-- # Opts: Swap/Backup/Undo
opt.backup = true
opt.writebackup = true
opt.backupdir = { vim.fn.expand "$HOME/tmp/nvim/backup/", ".", vim.fn.stdpath "state" .. "/backup/" }
opt.dir = { vim.fn.stdpath "state" .. "/swap/", vim.fn.expand "$HOME/tmp/nvim/swap/", "." }
opt.undofile = true
opt.undodir = { vim.fn.stdpath "state" .. "/undo/", vim.fn.expand "$HOME/tmp/nvim/undo/", "." }

-- # Opts: Registers/Clipboard
opt.clipboard = ""

-- # Opts: Grep
if vim.fn.executable "rg" then
  opt.grepprg = [[rg --vimgrep]]
  opt.grepformat = "%f:%l:%c:%m"
end

-- # Opts: Search
opt.hlsearch = false

-- # Opts: Modelines
opt.modeline = false
opt.modelines = 0

-- # Opts: Spellchecking
opt.spell = true
opt.spelllang = "en_us"
opt.spellfile = vim.fn.expand "$HOME/.vim/spell/general.en.utf-8.add"
