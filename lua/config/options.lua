local astroui_foldexpr = "v:lua.require'astroui.folding'.foldexpr()"

local g = vim.g
local opt = vim.opt

-- # Globals: Paths

g.python3_host_prog = vim.fn.stdpath "config" .. "/.venv/bin/python3"

-- # Opts: Autoformatting
opt.autoindent = true
opt.breakindent = true
opt.expandtab = true
opt.formatlistpat = [==[^\s*\d\+[\]:.)}\t ]\s*\|^\s*[-*+]\s\+]==]
opt.formatoptions = "croqwnl1j"
opt.linebreak = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 8
opt.textwidth = 78

-- # Opts: Improved Visibility
opt.background = "dark"
opt.cmdheight = 1
opt.conceallevel = 0
opt.cursorline = true
opt.listchars = [==[tab:>-,multispace:+...]==]
opt.number = false
opt.relativenumber = false
opt.winwidth = 85
opt.wrap = false

-- # Opts: Folding
opt.foldcolumn = "1"
opt.foldenable = true
opt.foldexpr = astroui_foldexpr
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldtext = ""

-- # Opts: Buffer Read/Write/Close
opt.autoread = true
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

-- # Opts: Misc copied from AstroNvim

opt.backspace = vim.list_extend(vim.opt.backspace:get(), { "nostop" }) -- don't stop backspace at insert
opt.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion
opt.copyindent = true -- copy the previous indentation on autoindenting
opt.diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" }) -- enable linematch diff algorithm
opt.fillchars = { eob = " " } -- disable `~` on nonexistent lines
opt.ignorecase = true -- case insensitive searching
opt.infercase = true -- infer cases in keyword completion
opt.jumpoptions = {} -- apply no jumpoptions on startup
opt.laststatus = 3 -- global statusline
opt.mouse = "a" -- enable mouse support
opt.preserveindent = true -- preserve indent structure as much as possible
opt.pumheight = 10 -- height of the pop up menu
opt.shiftround = true -- round indentation with `>`/`<` to shiftwidth
opt.shortmess = vim.tbl_deep_extend("force", vim.opt.shortmess:get(), { s = true, I = true, c = true, C = true }) -- disable search count wrap, startup messages, and completion messages
opt.showmode = true -- disable showing modes in command line
opt.showtabline = 2 -- always display tabline
opt.signcolumn = "yes" -- always show the sign column
opt.smartcase = true -- case sensitive searching
opt.splitbelow = true -- splitting a new window below the current one
opt.splitright = true -- splitting a new window at the right of the current one
opt.tabclose = "uselast" -- go to last used tab when closing the current tab
opt.termguicolors = true -- enable 24-bit RGB color in the TUI
opt.timeoutlen = 500 -- shorten key timeout length a little bit for which-key
opt.title = true -- set terminal title to the filename and path
opt.updatetime = 300 -- length of time to wait before triggering the plugin
opt.virtualedit = "block" -- allow going past end of line in visual block mode
