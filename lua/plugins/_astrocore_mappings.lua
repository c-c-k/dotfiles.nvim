-- ==================================
-- ASTRONVIM ASTROCORE (KEY MAPPINGS)
-- ==================================

-- repo url: <https://github.com/AstroNvim/astrocore>
-- nvim help: `:help astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    -- Get initialized AstroCore mappings table
    local maps = astrocore.empty_map_table()
    -- Get utility function for translating vanilla nvim `map(...)` style
    -- mappings into AstroNvim astrocore `maps.n[lhs] = ...` style mappings.
    local map, mapf = require('cck.utils.config').get_astrocore_mapper(maps)
    -- Get other utilities required by mappings
    local util_win = require('cck.utils.win')

    mapf({ "n", "x",}, "<LEADER>", { desc = "AstroNvim mappings" })

    -- ============================
    -- Basic vim commands remapping
    -- ============================

    -- Remap Redo to U because U is more convenient to press than <C-R> and it's
    -- official mapping seems pointless
    map({ "n", "x" }, "U", "<C-r>", { desc = "Unundo (redo)" })

    -- Exchange `g<motion>` and motion because the former is more often needed.
    -- Also add the keypad keys as alternatives to the remapped `g<motion>` for
    -- cases where pressing `g<motion>` a lot would be inconvenient.
    map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down (in wrap)" })
    map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up (in wrap)" })
    -- map({ "n", "x" }, "0", "g0", { desc = "Line start (in wrap)" })
    -- map({ "n", "x" }, "$", "g$", { desc = "Line end (in wrap)" })
    -- map({ "n", "x" }, "^", "g^", { desc = "First word in line (in wrap)" })
    map({ "n", "x" }, "gj", "j", { desc = "Down (ignore wrap)" })
    map({ "n", "x" }, "gk", "k", { desc = "Up (ignore wrap)" })
    -- map({ "n", "x" }, "g0", "0", { desc = "Line start (ignore wrap)" })
    -- map({ "n", "x" }, "g$", "$", { desc = "Line end (ignore wrap)" })
    -- map({ "n", "x" }, "g^", "^", { desc = "First word in line (ignore wrap)" })
    map({ "n", "x" }, "<LEFT>", "h", { desc = "Left (ignore wrap)" })
    map({ "n", "x" }, "<DOWN>", "j", { desc = "Down (ignore wrap)" })
    map({ "n", "x" }, "<UP>", "k", { desc = "Up (ignore wrap)" })
    map({ "n", "x" }, "<RIGHT>", "l", { desc = "Right (ignore wrap)" })

    -- Exchange ` and ' because the former is more often needed.
    map({ "n", "x" }, "`", "'", { desc = "Go to mark (col + row)" })
    map({ "n", "x" }, "'", "`", { desc = "Go to mark (col start)" })

    -- Disable `K` because it often accidentally interrupts the workflow
    map({ "n", "x" }, "K", "", { desc = "" })

    -- Set behavior of `[p/]p/[P/]P` to be in line in line with `p/P` logic
    -- instead of `[/]` logic because trying to press `]p` often results in
    -- accidentally pressing `[p` or `\p` instead.
    map({ "n", "x" }, "[p", "]p", { desc = "Paste indented after" })
    map({ "n", "x" }, "]p", "]p", { desc = "Paste indented after" })
    map({ "n", "x" }, "[P", "[p", { desc = "Paste indented before" })
    map({ "n", "x" }, "]P", "[p", { desc = "Paste indented before" })

    -- ===============
    -- Window mappings
    -- ===============
    map({ "n", "x" }, "<LEADER>w", { desc = "window actions" })

    -- Navigate windows
    map({ "n", "x" }, "<LEADER>ww", "<CMD>wincmd w<CR>", { desc = "Go to window (alternate)" })
    map({ "n", "x" }, "<LEADER>wh", "<CMD>wincmd h<CR>", { desc = "Go to window (left)" })
    map({ "n", "x" }, "<LEADER>wj", "<CMD>wincmd j<CR>", { desc = "Go to window (down)" })
    map({ "n", "x" }, "<LEADER>wk", "<CMD>wincmd k<CR>", { desc = "Go to window (up)" })
    map({ "n", "x" }, "<LEADER>wl", "<CMD>wincmd l<CR>", { desc = "Go to window (right)" })
    map({ "n", "i", "v", "t" }, "<M-w>", { copy = { "n", "<LEADER>ww" } })
    map({ "n", "i", "v", "t" }, "<M-h>", { copy = { "n", "<LEADER>wh" } })
    map({ "n", "i", "v", "t" }, "<M-j>", { copy = { "n", "<LEADER>wj" } })
    map({ "n", "i", "v", "t" }, "<M-k>", { copy = { "n", "<LEADER>wk" } })
    map({ "n", "i", "v", "t" }, "<M-l>", { copy = { "n", "<LEADER>wl" } })

    -- Move current window
    map({ "n", "x" }, "<LEADER>wm", { desc = "Move window" })
    map({ "n", "x" }, "<LEADER>wmh", "<CMD>wincmd H<CR>", { desc = "Move window (left)" })
    map({ "n", "x" }, "<LEADER>wmj", "<CMD>wincmd J<CR>", { desc = "Move window (down)" })
    map({ "n", "x" }, "<LEADER>wmk", "<CMD>wincmd K<CR>", { desc = "Move window (up)" })
    map({ "n", "x" }, "<LEADER>wml", "<CMD>wincmd L<CR>", { desc = "Move window (right)" })
    map({ "n", "x" }, "<LEADER>wm<TAB>", "<CMD>wincmd T<CR>", { desc = "Move window (tab-next)" })
    map({ "n", "x" }, "<LEADER>wm<S-TAB>", "<CMD>wincmd T|-tabmove<CR>", { desc = "Move window (tab-previous)" })

    -- Split current window
    map({ "n", "x" }, "<LEADER>ws", { desc = "Split window" })
    map({ "n", "x" }, "<LEADER>wsh", "<CMD>leftabove vertical split<CR>", { desc = "Split window (left-inner)" })
    map({ "n", "x" }, "<LEADER>wsj", "<CMD>rightbelow split<CR>", { desc = "Split window (down-inner)" })
    map({ "n", "x" }, "<LEADER>wsk", "<CMD>leftabove split<CR>", { desc = "Split window (up-inner)" })
    map({ "n", "x" }, "<LEADER>wsl", "<CMD>rightbelow vertical split<CR>", { desc = "Split window (right-inner)" })
    map({ "n", "x" }, "<LEADER>wsH", "<CMD>topleft vertical split<CR>", { desc = "Split window (left-outer)" })
    map({ "n", "x" }, "<LEADER>wsJ", "<CMD>botright split<CR>", { desc = "Split window (down-outer)" })
    map({ "n", "x" }, "<LEADER>wsK", "<CMD>topleft split<CR>", { desc = "Split window (up-outer)" })
    map({ "n", "x" }, "<LEADER>wsL", "<CMD>botright vertical split<CR>", { desc = "Split window (right-outer)" })
    map({ "n", "x" }, "<LEADER>ws<TAB>", "<CMD>split|wincmd T<CR>", { desc = "Split window (tab-next)" })
    map({ "n", "x" }, "<LEADER>ws<S-TAB>", "<CMD>split|wincmd T|-tabmove<CR>", { desc = "Split window (tab-previous)" })

    -- ============
    -- Tab mappings
    -- ============
    map({ "n", "x" }, "<LEADER><TAB>", { desc = "Tab actions" })

    -- Navigate tabs
    map({ "n", "x" }, "<LEADER><TAB><TAB>", "<CMD>tabnext #<CR>", { desc = "Go to tab (alternate)" })
    map({ "n", "x" }, "<LEADER><TAB>h", "<CMD>tabfirst<CR>", { desc = "Go to tab (first)" })
    map({ "n", "x" }, "<LEADER><TAB>j", "<CMD>tabprevious<CR>", { desc = "Go to tab (previous)" })
    map({ "n", "x" }, "<LEADER><TAB>k", "<CMD>tabnext<CR>", { desc = "Go to tab (next)" })
    map({ "n", "x" }, "<LEADER><TAB>l", "<CMD>tablast<CR>", { desc = "Go to tab (last)" })
    map({ "n", "i", "v", "t" }, "<M-t>", { copy = { "n", "<LEADER><TAB>j" } })
    map({ "n", "i", "v", "t" }, "<M-r>", { copy = { "n", "<LEADER><TAB>k" } })

    -- Move current tab
    map({ "n", "x" }, "<LEADER><TAB>m", { desc = "Move tab" })
    map({ "n", "x" }, "<LEADER><TAB>mh", "<CMD>0tabmove<CR>", { desc = "Move tab (first)" })
    map({ "n", "x" }, "<LEADER><TAB>mj", "<CMD>-tabmove<CR>", { desc = "Move tab (previous)" })
    map({ "n", "x" }, "<LEADER><TAB>mk", "<CMD>+tabmove<CR>", { desc = "Move tab (next)" })
    map({ "n", "x" }, "<LEADER><TAB>ml", "<CMD>$tabmove<CR>", { desc = "Move tab (last)" })
    map({ "n", "x" }, "<LEADER><TAB>mt", "<CMD>tabmove #<CR>", { desc = "Move tab (alternate)" })

    -- Split tab from current window
    map({ "n", "x" }, "<LEADER><TAB>s", { copy = { "n", "<LEADER>ws<TAB>" } })
    map({ "n", "x" }, "<LEADER><TAB>S", { copy = { "n", "<LEADER>ws<S-TAB>" } })

    -- ========================================
    -- Open/Close stuff
    -- ========================================
    map("n", "<LEADER>o", { desc = "Open ..." })
    map("n", "<LEADER>x", { desc = "close (eXit) ..." })

    -- Add blank line
    map("n", "<LEADER>oo", "o<ESC>0D", { desc = "Add Blank line below" })
    map("n", "<LEADER>O", "O<ESC>0D", { desc = "Add Blank line above" })

    -- Open/Close (enew) window
    map("n", "<LEADER>ow", { desc = "Open new window" })
    map("n", "<LEADER>owh", "<CMD>leftabove vertical split enew<CR>", { desc = "Open new window (left-inner)" })
    map("n", "<LEADER>owj", "<CMD>rightbelow split enew<CR>", { desc = "Open new window (down-inner)" })
    map("n", "<LEADER>owk", "<CMD>leftabove split enew<CR>", { desc = "Open new window (up-inner)" })
    map("n", "<LEADER>owl", "<CMD>rightbelow vertical split enew<CR>", { desc = "Open new window (right-inner)" })
    map("n", "<LEADER>owH", "<CMD>topleft vertical split enew<CR>", { desc = "Open new window (left-outer)" })
    map("n", "<LEADER>owJ", "<CMD>botright split enew<CR>", { desc = "Open new window (down-outer)" })
    map("n", "<LEADER>owK", "<CMD>topleft split enew<CR>", { desc = "Open new window (up-outer)" })
    map("n", "<LEADER>owL", "<CMD>botright vertical split enew<CR>", { desc = "Open new window (right-outer)" })
    map("n", "<LEADER>wx", "<CMD>close<CR>", { desc = "Close current window" })
    map("n", "<LEADER>xw", { copy = { "n", "<LEADER>wx" } })
    map("n", "<LEADER>xx", { copy = { "n", "<LEADER>wx" } })

    -- Open/Close new tab
    map("n", "<LEADER>o<TAB>", { desc = "Open new tab" })
    map("n", "<LEADER>o<TAB>h", "<CMD>0tabedit<CR>", { desc = "Open new tab (first)" })
    map("n", "<LEADER>o<TAB>j", "<CMD>-tabedit<CR>", { desc = "Open new tab (previous)" })
    map("n", "<LEADER>o<TAB>k", "<CMD>tabedit<CR>", { desc = "Open new tab (next)" })
    map("n", "<LEADER>o<TAB>l", "<CMD>$tabedit<CR>", { desc = "Open new tab (last)" })
    map("n", "<LEADER>o<TAB><TAB>", "<CMD>tabedit<CR>", { desc = "Open new tab (next)" })
    map("n", "<LEADER>o<S-TAB>", "<CMD>-tabedit<CR>", { desc = "Open new tab (previous)" })
    map("n", "<LEADER>x<TAB>", "<CMD>tabclose<CR>", { desc = "Close current tab" })
    map("n", "<LEADER>X", { copy = { "n", "<LEADER>x<TAB>" } })


    -- Quickfix and Locations list
    map("n", "<LEADER>ol", "<CMD>lopen<cr>", { desc = "Open location list" })
    map("n", "<LEADER>oq", "<CMD>copen<cr>", { desc = "Open quickfix list" })
    map("n", "<LEADER>xl", "<CMD>lclose<cr>", { desc = "Close location list" })
    map("n", "<LEADER>xq", "<CMD>cclose<cr>", { desc = "Close quickfix list" })

    -- Help and Man pages
    map("n", "<LEADER>oh", { desc = "Open nvim help" })
    map("n", "<LEADER>ohh", function()
        util_win.open_util_in_current_win({init = ":help", ft = "help", prompt_cmd = ":help "})
    end, { desc = "Open nvim help (tag)" })
    map("n", "<LEADER>ohg", function()
        util_win.open_util_in_current_win({init = ":help", ft = "help", prompt_cmd = ":helpgrep "})
    end, { desc = "Open nvim help (grep)" })
    map("n", "<LEADER>om", function()
        util_win.open_util_in_current_win({init = ":Man man", ft = "man", prompt_cmd = ":Man "})
    end, { desc = "Open manpages" })

    -- Git (fugitive)
    map("n", "<LEADER>og", { desc = "Open fugitive git ..." })
    map("n", "<LEADER>ogg", function()
        util_win.open_cmd_in_current_win(":Git")
    end, { desc = "Open fugitive git status" })
    map("n", "<LEADER>ogl", function()
        util_win.open_cmd_in_current_win(":Git log --oneline")
    end, { desc = "Open fugitive git `log --oneline`" })

    -- Terminal
    map("n", "<LEADER>ot", { desc = "Open terminal" })
    map("n", "<LEADER>ott", "<CMD>terminal<CR>i", { desc = "Open terminal (PWD)" })
    map("n", "<LEADER>otl", "<CMD>lcd %:h|terminal<CR>i", { desc = "Open terminal (buffer dir)" })
    map("n", "<LEADER>oth", "<CMD>lcd ~|terminal<CR>i", { desc = "Open terminal (home)" })

    -- File manager/explorer
    map("n", "<LEADER>of", { desc = "Open file manager/explorer" })

    -- ===================================
    -- UI set/toggle options/globals/etc..
    -- ===================================
    map("n", "<LEADER>u", { desc = "UI/UX" })

    -- Change PWD to current dir
    map("n", "<LEADER>up", { desc = "Set PWD" })
    map("n", "<LEADER>upg", "<CMD>cd %:h<CR>", { desc = "Set PWD (global) to current dir" })
    map("n", "<LEADER>upt", "<CMD>tcd %:h<CR>", { desc = "Set PWD (tab) to current dir" })
    map("n", "<LEADER>upl", "<CMD>lcd %:h<CR>", { desc = "Set PWD (local) to current dir" })

    -- =================
    -- Yank/Put mappings
    -- =================
    map({ "n", "x" }, "<LEADER>g", { desc = "g variants" })
    map({ "n", "x" }, "<LEADER>z", { desc = "z variants" })
    map({ "n", "x" }, "<LEADER>[", { desc = "[ variants" })
    map({ "n", "x" }, "<LEADER>]", { desc = "] variants" })

    -- Paste in insert/command/terminal modes (meant as enhanced `i_<C-R>`)
    map("!", "<M-p>", "", { desc = "Paste ..." })
    map("!", "<M-p>c", "<C-R>+", { desc = "Paste (clipboard)" })
    map("!", "<M-p>p", '<C-R>"', { desc = "Paste (unnamed)" })
    map("!", "<M-p>s", "<C-R>*", { desc = "Paste (selection)" })
    map("!", "<M-p>r", "'<C-R>'.nr2char(getchar())", { desc = "Paste (ask register)", expr = true })
    map("!", "<M-P>", { copy = { "!", "<M-p>r" } })
    map("t", "<M-p>", "", { desc = "Paste ..." })
    map("t", "<M-p>c", '<C-\\><C-N>"+pi', { desc = "Paste (clipboard)" })
    map("t", "<M-p>p", '<C-\\><C-N>""pi', { desc = "Paste (unnamed)" })
    map("t", "<M-p>s", '<C-\\><C-N>"*pi', { desc = "Paste (selection)" })
    map("t", "<M-p>r", "'<C-\\><C-N>\"'.nr2char(getchar()).'pi'", { desc = "Paste (ask register)", expr = true })
    map("t", "<M-P>", { copy = { "t", "<M-p>r" } })

    -- Yank/Put to/from clipboard/selection
    map({ "n", "x" }, "<LEADER>y", { desc = "Yank ..." })
    map({ "n", "x" }, "<LEADER>yy", { desc = "Yank (line) ..." })
    map({ "n", "x" }, "<LEADER>Y", { desc = "Yank (to-end) ..." })
    map({ "n", "x" }, "<LEADER>zy", { desc = "Yank (no-trail-space) ..." })
    map({ "n", "x" }, "<LEADER>yc", '"+y', { desc = "Yank (clipboard)" })
    map({ "n", "x" }, "<LEADER>yyc", '"+yy', { desc = "Yank (clipboard:line)" })
    map({ "n", "x" }, "<LEADER>Yc", '"+yy', { desc = "Yank (clipboard:to-end)" })
    map({ "n", "x" }, "<LEADER>zyc", '"+zy', { desc = "Yank (clipboard:no-trail-space)" })
    map({ "n", "x" }, "<LEADER>ys", '"*y', { desc = "Yank (selection)" })
    map({ "n", "x" }, "<LEADER>yys", '"*yy', { desc = "Yank (selection:line)" })
    map({ "n", "x" }, "<LEADER>Ys", '"*yy', { desc = "Yank (selection:to-end)" })
    map({ "n", "x" }, "<LEADER>zys", '"*zy', { desc = "Yank (selection:no-trail-space)" })
    map({ "n", "x" }, "<LEADER>p", { desc = "Paste ..." })
    map({ "n", "x" }, "<LEADER>P", { desc = "Paste (to-end) ..." })
    map({ "n", "x" }, "<LEADER>gp", { desc = "Paste (after-cursor+1) ..." })
    map({ "n", "x" }, "<LEADER>gP", { desc = "Paste (before-cursor+1) ..." })
    map({ "n", "x" }, "<LEADER>[p", { desc = "Paste (after-indent) ..." })
    map({ "n", "x" }, "<LEADER>]p", { desc = "Paste (after-indent) ..." })
    map({ "n", "x" }, "<LEADER>[P", { desc = "Paste (before-indent) ..." })
    map({ "n", "x" }, "<LEADER>]P", { desc = "Paste (before-indent) ..." })
    map({ "n", "x" }, "<LEADER>zp", { desc = "Paste (after-no-trail-space) ..." })
    map({ "n", "x" }, "<LEADER>zP", { desc = "Paste (before-no-trail-space) ..." })
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

    map("n", "<LEADER>q", { desc = "Editor actions" })
    map("n", "<LEADER>qs", "<CMD>wall<CR>", { desc = "Save all" })
    map("n", "<LEADER>qq", "<CMD>confirm qall<CR>", { desc = "Exit with confirm" })

    -- =====================================
    -- Finding stuff with a picker (fzf.vim)
    -- =====================================
    map("n", "<LEADER>f", { desc = "Find(FZF) ..." } )

    -- find nvim stuff
    map("n", "<LEADER>fh", "<CMD>FzfHistory<CR>", { desc = "Find(FZF) recent files" } )
    map("n", "<LEADER>f/", "<CMD>FzfHistory/<CR>", { desc = "Find(FZF) recent searches" } )
    map("n", "<LEADER>f:", "<CMD>FzfHistory:<CR>", { desc = "Find(FZF) recent commands" } )
    map("n", "<LEADER>f;", { copy = { "n", "<LEADER>f:" } })
    map("n", "<LEADER>fb", "<CMD>FzfBuffers<CR>", { desc = "Find(FZF) buffers" } )
    map("n", "<LEADER>fw", "<CMD>FzfWindows<CR>", { desc = "Find(FZF) windows" } )
    map("n", "<LEADER>fc", "<CMD>FzfCommands<CR>", { desc = "Find(FZF) commands" } )
    map("n", "<LEADER>fm", "<CMD>FzfMaps<CR>", { desc = "Find(FZF) mappings" } )
    map("n", "<LEADER>f'", "<CMD>FzfMarks<CR>", { desc = "Find(FZF) marks" } )

    -- find lines
    --  * NOTE: This section only contains global stuff that is appropriate for
    --    most/all file and buffer types, patterns fitting for specific
    --    filetypes are defined in the appropriate ftplugin.
    map("n", "<LEADER>flb", "<CMD>FzfBLines<CR>", { desc = "Find(FZF) lines (buffer)" } )
    map("n", "<LEADER>flB", ":FzfBLines ", { desc = "Find(FZF) lines (buffer,input)" } )
    map("n", "<LEADER>fla", "<CMD>FzfLines<CR>", { desc = "Find(FZF) lines (all)" } )
    map("n", "<LEADER>flA", ":FzfLines ", { desc = "Find(FZF) lines (all,input)" } )

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}
