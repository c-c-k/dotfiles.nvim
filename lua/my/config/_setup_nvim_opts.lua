local opt = vim.opt

-- # Opts: Autoformatting
opt.autoindent = true
opt.breakindent = true
opt.copyindent = true
opt.expandtab = true
opt.formatlistpat = [==[^\s*\d\+[\]:.)}\t ]\s*\|^\s*[-*+]\s\+]==]
opt.formatoptions = "croqwnl1j"
opt.linebreak = true
opt.preserveindent = true
opt.shiftround = true -- round indentation with `>`/`<` to shiftwidth
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 8
opt.textwidth = 78

-- # Opts: Improved Visibility
opt.background = "dark"
opt.conceallevel = 0
opt.cursorline = true
opt.listchars = [==[tab:>-,multispace:+...]==]
opt.winwidth = 85
opt.wrap = false

-- # Opts: Tab/Win/Status/Message Lines and Gutters
opt.cmdheight = 1
opt.laststatus = 3
opt.number = false
opt.showmode = false
opt.showtabline = 2
opt.signcolumn = "yes"
-- opt.winbar = "%!v:lua.require'my.win'.winbar_expr()"
opt.tabline = "%!v:lua.My.tab.tabline_expr()"
opt.relativenumber = false

-- # Opts: Folding
opt.foldcolumn = "1"
opt.foldenable = true
-- opt.foldexpr = "v:lua.require'my.win.ufo'.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
-- opt.foldmethod = "expr"
-- opt.foldtext = ""

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
opt.ignorecase = true
opt.hlsearch = true
opt.smartcase = true

-- # Opts: Modelines
opt.modeline = false
opt.modelines = 0

-- # Opts: Spellchecking
opt.spell = true
opt.spelllang = "en_us"
opt.spellfile = vim.fn.expand "$HOME/.vim/spell/general.en.utf-8.add"

-- # Opts: Misc

opt.backspace = vim.list_extend(vim.opt.backspace:get(), { "nostop" })
opt.completeopt = { "menu", "menuone", "noselect" }
opt.diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" })
opt.fillchars = { eob = " " }
opt.infercase = true
opt.jumpoptions = {}
opt.mouse = "a"
opt.pumheight = 10
opt.shortmess = vim.tbl_deep_extend("force", vim.opt.shortmess:get(), { s = true, I = true, c = true, C = true })
opt.tabclose = "uselast"
opt.termguicolors = true
opt.timeoutlen = 500
opt.title = true
opt.updatetime = 300
opt.virtualedit = "block"
