local map = vim.keymap.set

local util_win = require('cck.utils.win')

-- ===========================
-- Basic vim commands remapping
-- ============================

-- Remap Redo to U because U is more convenient to press than <C-R> and it's
-- official mapping seems pointless
map({ "n", "x" }, "U", "<C-r>", { desc = "Unundo (redo)" })

-- Exchange `g<motion>` and motion because the former is more often needed.
-- Also add the keypad keys as alternatives to the remapped `g<motion>` for
-- cases where pressing `g<motion>` a lot would be inconvenient.
map({ "n", "x" }, "j", "gj", { desc = "Down (wrap)" })
map({ "n", "x" }, "k", "gk", { desc = "Up (wrap)" })
map({ "n", "x" }, "0", "g0", { desc = "Line start (wrap)" })
map({ "n", "x" }, "$", "g$", { desc = "Line end (wrap)" })
map({ "n", "x" }, "^", "g^", { desc = "First word in line (wrap)" })
map({ "n", "x" }, "gj", "j", { desc = "Down (no wrap)" })
map({ "n", "x" }, "gk", "k", { desc = "Up (no wrap)" })
map({ "n", "x" }, "g0", "0", { desc = "Line start (no wrap)" })
map({ "n", "x" }, "g$", "$", { desc = "Line end (no wrap)" })
map({ "n", "x" }, "g^", "^", { desc = "First word in line (no wrap)" })
map({ "n", "x" }, "<LEFT>", "h", { desc = "Left (no wrap)" })
map({ "n", "x" }, "<DOWN>", "j", { desc = "Down (no wrap)" })
map({ "n", "x" }, "<UP>", "k", { desc = "Up (no wrap)" })
map({ "n", "x" }, "<RIGHT>", "l", { desc = "Right (no wrap)" })

-- Exchange ` and ' because the former is more often needed.
map({ "n", "x" }, "`", "'", { desc = "Go to mark (col + row)" })
map({ "n", "x" }, "'", "`", { desc = "Go to mark (col start)" })

-- Disable `K` because it often accidentally interrupts the workflow
map({ "n", "x" }, "K", "", { desc = "" })

-- Set behavior of `[p/]p/[P/]P` to be in line in line with `p/P` logic instead
-- of `[/]` logic because trying to press `]p` often results in accidentally
-- pressing `[p` or `\p` instead.
map({ "n", "x" }, "[p", "]p", { desc = "Paste indented after" })
map({ "n", "x" }, "[P", "[p", { desc = "Paste indented before" })
map({ "n", "x" }, "]p", "]p", { desc = "Paste indented after" })
map({ "n", "x" }, "]P", "[p", { desc = "Paste indented before" })

-- ===============
-- Window mappings
-- ===============

-- Navigate windows
map({ "i", "n", "t" }, "<M-w>", "<CMD>wincmd w<CR>", { desc = "Go to window (alternate)" })
map({ "i", "n", "t" }, "<M-h>", "<CMD>wincmd h<CR>", { desc = "Go to window (left)" })
map({ "i", "n", "t" }, "<M-j>", "<CMD>wincmd j<CR>", { desc = "Go to window (down)" })
map({ "i", "n", "t" }, "<M-k>", "<CMD>wincmd k<CR>", { desc = "Go to window (up)" })
map({ "i", "n", "t" }, "<M-l>", "<CMD>wincmd l<CR>", { desc = "Go to window (right)" })
map( "n" , "<LEADER>ww", "<CMD>wincmd w<CR>", { desc = "Go to window (alternate)" })
map( "n" , "<LEADER>wh", "<CMD>wincmd h<CR>", { desc = "Go to window (left)" })
map( "n" , "<LEADER>wj", "<CMD>wincmd j<CR>", { desc = "Go to window (down)" })
map( "n" , "<LEADER>wk", "<CMD>wincmd k<CR>", { desc = "Go to window (up)" })
map( "n" , "<LEADER>wl", "<CMD>wincmd l<CR>", { desc = "Go to window (right)" })

-- Move current window
map("n", "<LEADER>wmh", "<CMD>wincmd H<CR>", { desc = "Move window (left)" })
map("n", "<LEADER>wmj", "<CMD>wincmd J<CR>", { desc = "Move window (down)" })
map("n", "<LEADER>wmk", "<CMD>wincmd K<CR>", { desc = "Move window (up)" })
map("n", "<LEADER>wml", "<CMD>wincmd L<CR>", { desc = "Move window (right)" })
map("n", "<LEADER>wm<TAB>", "<CMD>wincmd T<CR>", { desc = "Move window (tab-next)" })
map("n", "<LEADER>wm<S-TAB>", "<CMD>wincmd T|-tabmove<CR>", { desc = "Move window (tab-previous)" })

-- Split current window
map("n", "<LEADER>wsh", "<CMD>leftabove vertical split<CR>", { desc = "Split window (left-inner)" })
map("n", "<LEADER>wsj", "<CMD>rightbelow split<CR>", { desc = "Split window (down-inner)" })
map("n", "<LEADER>wsk", "<CMD>leftabove split<CR>", { desc = "Split window (up-inner)" })
map("n", "<LEADER>wsl", "<CMD>rightbelow vertical split<CR>", { desc = "Split window (right-inner)" })
map("n", "<LEADER>wsH", "<CMD>topleft vertical split<CR>", { desc = "Split window (left-outer)" })
map("n", "<LEADER>wsJ", "<CMD>botright split<CR>", { desc = "Split window (down-outer)" })
map("n", "<LEADER>wsK", "<CMD>topleft split<CR>", { desc = "Split window (up-outer)" })
map("n", "<LEADER>wsL", "<CMD>botright vertical split<CR>", { desc = "Split window (right-outer)" })
map("n", "<LEADER>ws<TAB>", "<CMD>split|wincmd T<CR>", { desc = "Split window (tab-next)" })
map("n", "<LEADER>ws<S-TAB>", "<CMD>split|wincmd T|-tabmove<CR>", { desc = "Split window (tab-previous)" })

-- ============
-- Tab mappings
-- ============

-- Navigate tabs
map({ "i", "n", "t" }, "<M-W>", "<CMD>tabnext #<CR>", { desc = "Go to tab (alternate)" })
map({ "i", "n", "t" }, "<M-H>", "<CMD>tabfirst<CR>", { desc = "Go to tab (first)" })
map({ "i", "n", "t" }, "<M-J>", "<CMD>tabprevious<CR>", { desc = "Go to tab (previous)" })
map({ "i", "n", "t" }, "<M-K>", "<CMD>tabnext<CR>", { desc = "Go to tab (next)" })
map({ "i", "n", "t" }, "<M-L>", "<CMD>tablast<CR>", { desc = "Go to tab (last)" })
map("n", "<LEADER><TAB><TAB>", "<M-W>", { remap = true, desc = "Go to tab (alternate)" })
map("n", "<LEADER><TAB>h", "<M-H>", { remap = true, desc = "Go to tab (first)" })
map("n", "<LEADER><TAB>j", "<M-J>", { remap = true, desc = "Go to tab (previous)" })
map("n", "<LEADER><TAB>k", "<M-K>", { remap = true, desc = "Go to tab (next)" })
map("n", "<LEADER><TAB>l", "<M-L>", { remap = true, desc = "Go to tab (last)" })

-- Move current tab
map("n", "<LEADER><TAB>mh", "<CMD>0tabmove<CR>", { desc = "Move tab (first)" })
map("n", "<LEADER><TAB>mj", "<CMD>-tabmove<CR>", { desc = "Move tab (previous)" })
map("n", "<LEADER><TAB>mk", "<CMD>+tabmove<CR>", { desc = "Move tab (next)" })
map("n", "<LEADER><TAB>ml", "<CMD>$tabmove<CR>", { desc = "Move tab (last)" })
map("n", "<LEADER><TAB>mt", "<CMD>tabmove #<CR>", { desc = "Move tab (alternate)" })

-- Split current window into a new tab
-- map("n", "<LEADER><TAB>sh", "<CMD>split|wincmd T|0tabmove<CR>", { remap = true, desc = "Split window (Tab-first)" })
-- map("n", "<LEADER><TAB>sj", "<CMD>split|wincmd T|-tabmove<CR>", { remap = true, desc = "Split window (Tab-previous)" })
-- map("n", "<LEADER><TAB>sk", "<CMD>split|wincmd T<CR>", { desc = "Split window (Tab-next)" })
-- map("n", "<LEADER><TAB>sl", "<CMD>split|wincmd T|$tabmove<CR>", { remap = true, desc = "Split window (Tab-last)" })
-- map("n", "<LEADER><TAB>ss", "<LEADER><TAB>sk", { remap = true, desc = "Split window (Tab-next)" })
-- map("n", "<LEADER><TAB>sS", "<LEADER><TAB>sj", { remap = true, desc = "Split window (Tab-previous)" })

-- ========================================
-- Open/Close stuff
-- ========================================

-- Add blank line
map("n", "<LEADER>oo", "o<ESC>0D", { desc = "Add Blank line below" })
map("n", "<LEADER>O", "O<ESC>0D", { desc = "Add Blank line above" })

-- Open/Close (new) window
map("n", "<LEADER>owh", "<CMD>leftabove vertical split enew<CR>", { desc = "Open new window (left-inner)" })
map("n", "<LEADER>owj", "<CMD>rightbelow split enew<CR>", { desc = "Open new window (down-inner)" })
map("n", "<LEADER>owk", "<CMD>leftabove split enew<CR>", { desc = "Open new window (up-inner)" })
map("n", "<LEADER>owl", "<CMD>rightbelow vertical split enew<CR>", { desc = "Open new window (right-inner)" })
map("n", "<LEADER>owH", "<CMD>topleft vertical split enew<CR>", { desc = "Open new window (left-outer)" })
map("n", "<LEADER>owJ", "<CMD>botright split enew<CR>", { desc = "Open new window (down-outer)" })
map("n", "<LEADER>owK", "<CMD>topleft split enew<CR>", { desc = "Open new window (up-outer)" })
map("n", "<LEADER>owL", "<CMD>botright vertical split enew<CR>", { desc = "Open new window (right-outer)" })
map("n", "<LEADER>xw", "<CMD>close<CR>", { desc = "Close current window" })
map("n", "<LEADER>xx", "<CMD>close<CR>", { desc = "Close current window" })

-- Open/Close new tab
map("n", "<LEADER>o<TAB>h", "<CMD>0tabedit<CR>", { desc = "Open new tab (first)" })
map("n", "<LEADER>o<TAB>j", "<CMD>-tabedit<CR>", { desc = "Open new tab (previous)" })
map("n", "<LEADER>o<TAB>k", "<CMD>tabedit<CR>", { desc = "Open new tab (next)" })
map("n", "<LEADER>o<TAB>l", "<CMD>$tabedit<CR>", { desc = "Open new tab (last)" })
map("n", "<LEADER>o<TAB><TAB>", "<CMD>tabedit<CR>", { desc = "Open new tab (next)" })
map("n", "<LEADER>o<S-TAB>", "<CMD>-tabedit<CR>", { desc = "Open new tab (previous)" })
map("n", "<LEADER>x<TAB>", "<CMD>tabclose<CR>", { desc = "Close current tab" })
map("n", "<LEADER>X", "<CMD>tabclose<CR>", { desc = "Close current tab" })


-- Quickfix and Locations list
map("n", "<LEADER>ol", "<CMD>lopen<cr>", { desc = "Open location list" })
map("n", "<LEADER>oq", "<CMD>copen<cr>", { desc = "Open quickfix list" })
map("n", "<LEADER>xl", "<CMD>lclose<cr>", { desc = "Close location list" })
map("n", "<LEADER>xq", "<CMD>cclose<cr>", { desc = "Close quickfix list" })

-- NERDTree file system browser
map( "n", "<LEADER>odb", ":NERDTreeFromBookmark ", { desc = "" } )
map( "n", "<LEADER>oD", ":NERDTree ", { desc = "" } )
map( "n", "<LEADER>odd", "<CMD>NERDTreeToggle<CR>", { desc = "" } )
map( "n", "<LEADER>ods", "<CMD>NERDTreeFind<CR>", { desc = "" } )

-- Help and Man pages
map("n", "<LEADER>ohh", function()
    util_win.open_util_in_current_win({init = ":help", ft = "help", prompt_cmd = ":help "})
end, { desc = "Open nvim help" })
map("n", "<LEADER>ohg", function()
    util_win.open_util_in_current_win({init = ":help", ft = "help", prompt_cmd = ":helpgrep "})
end, { desc = "Open nvim helpgrep" })
map("n", "<LEADER>om", function()
    util_win.open_util_in_current_win({init = ":Man man", ft = "man", prompt_cmd = ":Man "})
end, { desc = "Open manpages" })

-- Git (fugitive)
map("n", "<LEADER>ogg", function()
    util_win.open_cmd_in_current_win(":Git")
end, { desc = "Open fugitive git manager" })
map("n", "<LEADER>ogl", function()
    util_win.open_cmd_in_current_win(":Git log --oneline")
end, { desc = "Open fugitive git `log --oneline`" })

-- Terminal
map("n", "<LEADER>ott", "<CMD>terminal<CR>i", { desc = "Open terminal" })
map("n", "<LEADER>otl", "<CMD>lcd %:h|terminal<CR>i", { desc = "Open terminal (buffer dir)" })
map("n", "<LEADER>oth", "<CMD>lcd ~|terminal<CR>i", { desc = "Open terminal (home)" })

-- ===================================
-- UI set/toggle options/globals/etc..
-- ===================================

-- Change PWD to current dir
map("n", "<LEADER>upg", "<CMD>cd %:h<CR>", { desc = "Set PWD (global) to current dir" })
map("n", "<LEADER>upt", "<CMD>tcd %:h<CR>", { desc = "Set PWD (tab) to current dir" })
map("n", "<LEADER>upl", "<CMD>lcd %:h<CR>", { desc = "Set PWD (local) to current dir" })

-- =================
-- Yank/Put mappings
-- =================

-- Paste in insert/command/terminal modes (meant as enhanced `i_<C-R>`)
map("!", "<M-p>", "", { desc = "" })
map("!", "<M-p>c", "<C-R>+", { desc = "Paste (clipboard)" })
map("!", "<M-p>p", '<C-R>"', { desc = "Paste (unnamed)" })
map("!", "<M-p>s", "<C-R>*", { desc = "Paste (selection)" })
map("!", "<M-p>r", "'<C-R>'.nr2char(getchar())", { desc = "Paste (ask register)", expr = true })
map("!", "<M-P>", "<M-p>r", { remap = true, desc = "Paste (ask register)" })
map("t", "<M-p>", "", { desc = "" })
map("t", "<M-p>c", '<C-\\><C-N>"+pi', { desc = "Paste (clipboard)" })
map("t", "<M-p>p", '<C-\\><C-N>""pi', { desc = "Paste (unnamed)" })
map("t", "<M-p>s", '<C-\\><C-N>"*pi', { desc = "Paste (selection)" })
map("t", "<M-p>r", "'<C-\\><C-N>\"'.nr2char(getchar()).'pi'", { desc = "Paste (ask register)", expr = true })
map("t", "<M-P>", "<M-p>r", { remap = true, desc = "Paste (ask register)" })

-- Yank/Put to/from clipboard/selection
map({ "n", "x" }, "<LEADER>yc", '"+y', { desc = "Yank (clipboard)" })
map({ "n", "x" }, "<LEADER>yyc", '"+yy', { desc = "Yank (clipboard:line)" })
map({ "n", "x" }, "<LEADER>Yc", '"+yy', { desc = "Yank (clipboard:to-end)" })
map({ "n", "x" }, "<LEADER>zyc", '"+zy', { desc = "Yank (clipboard:no-trail-space)" })
map({ "n", "x" }, "<LEADER>pc", '"+p', { desc = "Paste (clipboard:after)" })
map({ "n", "x" }, "<LEADER>Pc", '"+P', { desc = "Paste (clipboard:before)" })
map({ "n", "x" }, "<LEADER>gpc", '"+gp', { desc = "Paste (clipboard:after-cursor+1)" })
map({ "n", "x" }, "<LEADER>gPc", '"+gP', { desc = "Paste (clipboard:before-cursor+1)" })
map({ "n", "x" }, "<LEADER>[pc", '"+]p', { desc = "Paste (clipboard:after-indent)" })
map({ "n", "x" }, "<LEADER>]pc", '"+]p', { desc = "Paste (clipboard:after-indent)" })
map({ "n", "x" }, "<LEADER>[Pc", '"+]P', { desc = "Paste (clipboard:before-indent)" })
map({ "n", "x" }, "<LEADER>]Pc", '"+]P', { desc = "Paste (clipboard:before-indent)" })
map({ "n", "x" }, "<LEADER>zpc", '"+zp', { desc = "Paste (clipboard:after-no-trail-space)" })
map({ "n", "x" }, "<LEADER>zPc", '"+zP', { desc = "Paste (clipboard:before-no-trail-space)" })
map({ "n", "x" }, "<LEADER>ys", '"*y', { desc = "Yank (selection)" })
map({ "n", "x" }, "<LEADER>yys", '"*yy', { desc = "Yank (selection:line)" })
map({ "n", "x" }, "<LEADER>Ys", '"*yy', { desc = "Yank (selection:to-end)" })
map({ "n", "x" }, "<LEADER>zys", '"*zy', { desc = "Yank (selection:no-trail-space)" })
map({ "n", "x" }, "<LEADER>ps", '"*p', { desc = "Paste (selection:after)" })
map({ "n", "x" }, "<LEADER>Ps", '"*P', { desc = "Paste (selection:before)" })
map({ "n", "x" }, "<LEADER>gps", '"*gp', { desc = "Paste (selection:after-cursor+1)" })
map({ "n", "x" }, "<LEADER>gPs", '"*gP', { desc = "Paste (selection:before-cursor+1)" })
map({ "n", "x" }, "<LEADER>[ps", '"*]p', { desc = "Paste (selection:after-indent)" })
map({ "n", "x" }, "<LEADER>]ps", '"*]p', { desc = "Paste (selection:after-indent)" })
map({ "n", "x" }, "<LEADER>[Ps", '"*]P', { desc = "Paste (selection:before-indent)" })
map({ "n", "x" }, "<LEADER>]Ps", '"*]P', { desc = "Paste (selection:before-indent)" })
map({ "n", "x" }, "<LEADER>zps", '"*zp', { desc = "Paste (selection:after-no-trail-space)" })
map({ "n", "x" }, "<LEADER>zPs", '"*zP', { desc = "Paste (selection:before-no-trail-space)" })

-- =========================
-- Visual selection mappings
-- =========================

-- Increment/Decrement visual selection using TreeSitter
-- NOTE: this is defined in the nvim-treesitter plugin config
-- map("n", "<C-k>", "", { desc = "init_selection" })
-- map("v", "<C-k>", "", { desc = "node_incremental" })
-- map("v", "<C-l>", "", { desc = "scope_incremental" })
-- map("v", "<C-j>", "", { desc = "node_decremental" })

-- ======================
-- Terminal mode mappings
-- ======================
map("t", "<M-ESC>", "<C-\\><C-n>", { desc = "Enter normal mode" })

-- =========================
-- Top level Editor mappings
-- =========================

map("n", "<LEADER>qr", "<CMD>source $MYVIMRC<CR>", { desc = "Reload init.lua" })
map("n", "<LEADER>qs", "<CMD>wall<CR>", { desc = "Save all" })
map("n", "<LEADER>qq", "<CMD>confirm qall<CR>", { desc = "Exit with confirm" })

-- =====================================
-- Finding stuff with a picker (fzf.vim)
-- =====================================

-- find nvim stuff
map( "n", "<LEADER>fh", "<CMD>FzfHistory<CR>", { desc = "" } )
map( "n", "<LEADER>f/", "<CMD>FzfHistory/<CR>", { desc = "" } )
map( "n", "<LEADER>f;", "<CMD>FzfHistory:<CR>", { desc = "" } )
map( "n", "<LEADER>f:", "<CMD>FzfHistory:<CR>", { desc = "" } )
map( "n", "<LEADER>fb", "<CMD>FzfBuffers<CR>", { desc = "" } )
map( "n", "<LEADER>fw", "<CMD>FzfWindows<CR>", { desc = "" } )
map( "n", "<LEADER>fc", "<CMD>FzfCommands<CR>", { desc = "" } )
map( "n", "<LEADER>fmm", "<CMD>FzfMaps<CR>", { desc = "" } )
map( "n", "<LEADER>fmr", "<CMD>FzfMarks<CR>", { desc = "" } )

-- find lines
-- NOTE: This section only contains global stuff that is appropriate for
--       most/all file and buffer types, patterns fitting for specific
--       filetypes are defined in the appropriate ftplugin.
map( "n", "<LEADER>fL", "<CMD>FzfLines<CR>", { desc = "" } )
map( "n", "<LEADER>fL;", ":FzfLines ", { desc = "" } )
map( "n", "<LEADER>fL:", ":FzfLines ", { desc = "" } )
map( "n", "<LEADER>fl", "<CMD>FzfBLines<CR>", { desc = "" } )
map( "n", "<LEADER>fl;", ":FzfBLines ", { desc = "" } )
map( "n", "<LEADER>fl:", ":FzfBLines ", { desc = "" } )

-- find files in file system
map( "n", "<LEADER>ff", ":FzfFiles ~/", { desc = "" } )
map( "n", "<LEADER>fp", "<CMD>FzfFiles ~/proj<CR>", { desc = "" } )
map( "n", "<LEADER>fP", ":FzfFiles ~/proj", { desc = "" } )

-- find files in git repository
map( "n", "<LEADER>fgg", "<CMD>FzfGFiles<CR>", { desc = "" } )
map( "n", "<LEADER>fgG", ":FzfGFiles ", { desc = "" } )
map( "n", "<LEADER>fgs", "<CMD>FzfGFiles?<CR>", { desc = "" } )

-- linting and fixing commands (mostly ALE)
map( "n", "<LEADER>lii", "<CMD>ALEInfo<CR>", { desc = "" } )
map( "n", "<LEADER>lic", "<CMD>ALEInfoToClipboard<CR>", { desc = "" } )
map( "n", "<LEADER>ld", "<CMD>ALEDetail<CR>", { desc = "" } )
map( "n", "<LEADER>LT", "<CMD>ALEToggle<CR>", { desc = "" } )
map( "n", "<LEADER>lt", "<CMD>ALEToggleBuffer<CR>", { desc = "" } )
map( "n", "<LEADER>lpp", "<Plug>(ale_previous_wrap)", { desc = "" } )
map( "n", "<LEADER>lpe", "<Plug>(ale_previous_wrap_error)", { desc = "" } )
map( "n", "<LEADER>lpw", "<Plug>(ale_previous_wrap_warning)", { desc = "" } )
map( "n", "<LEADER>lnn", "<Plug>(ale_next_wrap)", { desc = "" } )
map( "n", "<LEADER>lne", "<Plug>(ale_next_wrap_error)", { desc = "" } )
map( "n", "<LEADER>lnw", "<Plug>(ale_next_wrap_warning)", { desc = "" } )
map( "n", "<LEADER>lgf", "<Plug>(ale_first)", { desc = "" } )
map( "n", "<LEADER>lgl", "<Plug>(ale_last)", { desc = "" } )
map( "n", "<LEADER>lq", "<CMD>ALELint<CR>:ALEPopulateQuickfix<CR>", { desc = "" } )
map( "n", "<LEADER>ll", "<CMD>ALELint<CR>:ALEPopulateLocList<CR>", { desc = "" } )
map( "n", "<LEADER>ls", "<CMD>ALELintStop<CR>", { desc = "" } )
map( "n", "<LEADER>lr", "<CMD>ALELint<CR>", { desc = "" } )
map( "n", "<LEADER>lff", "<CMD>ALECodeAction<CR>", { desc = "" } )
map( "n", "<LEADER>lfs", "<CMD>ALEFixSuggest<CR>", { desc = "" } )
map( "n", "<LEADER>lfa", "<CMD>ALEFix<CR>", { desc = "" } )

-- ===================
-- Goto commands (YCM)
-- ===================
map( "n", "<LEADER>gid", "<CMD>YcmCompleter GetDoc<CR>", { desc = "" } )
map( "n", "<LEADER>git", "<CMD>YcmCompleter GetType<CR>", { desc = "" } )
map( "n", "<LEADER>gce", "<CMD>YcmCompleter GoToCallees<CR>", { desc = "" } )
map( "n", "<LEADER>gcr", "<CMD>YcmCompleter GoToCallers<CR>", { desc = "" } )
map( "n", "<LEADER>gd", "<CMD>YcmCompleter GoToDeclaration<CR>", { desc = "" } )
map( "n", "<LEADER>ge", "<CMD>YcmCompleter GoToDefinition<CR>", { desc = "" } )
map( "n", "<LEADER>gg", "<CMD>YcmCompleter GoTo<CR>", { desc = "" } )
map( "n", "<LEADER>gm", "<CMD>YcmCompleter GoToImplementation<CR>", { desc = "" } )
map( "n", "<LEADER>gr", "<CMD>YcmCompleter GoToReferences<CR>", { desc = "" } )
map( "n", "<LEADER>gs", ":YcmCompleter GoToSymbol ", { desc = "" } )
map( "n", "<LEADER>gt", "<CMD>YcmCompleter GoToType<CR>", { desc = "" } )

-- ==========================
-- Refactoring commands (YCM)
-- ==========================
map( "n", "<LEADER>ref", ":YcmCompleter RefactorExtractFunction ", { desc = "" } )
map( "n", "<LEADER>rev", ":YcmCompleter RefactorExtractVariable ", { desc = "" } )
map( "n", "<LEADER>ri", ":YcmCompleter RefactorInline ", { desc = "" } )
map( "n", "<LEADER>rr", ":YcmCompleter RefactorRename ", { desc = "" } )
map( "n", "<LEADER>roi", ":YcmCompleter OrganizeImports ", { desc = "" } )
