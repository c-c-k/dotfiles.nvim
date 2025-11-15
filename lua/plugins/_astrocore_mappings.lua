---@type LazyPluginSpec
local spec_astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local schdir_buf_dir = require("my.utils.editor").schdir_buf_dir
    local schdir_buf_root = require("my.utils.editor").schdir_buf_root
    local astrocore = require "astrocore"
    local astromaps = opts.mappings
    -- Get utility function for translating vanilla nvim `map(...)` style
    -- mappings into AstroNvim astrocore `maps.n[lhs] = ...` style mappings.
    local maps, map = require("my.core.keymaps").get_astrocore_mapper()
    -- Get other utilities required by mappings
    local util_win = require "my.utils.win"

    map({ "n", "x" }, "<LEADER>", { desc = "AstroNvim mappings", uleader = false })

    -- *** Basic vim commands mappings ***

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

    -- Set `gg` to go the begging of the first line because it's usually
    -- whats needed
    map({ "n", "x", "o" }, "gg", "gg0", { desc = "go to start of buffer" })

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

    -- change/delete to black hole register ("_)
    map({ "n", "x" }, "<LEADER>c", '"_c', { desc = "black hole change" })
    map({ "n", "x" }, "<LEADER>C", '"_C', { desc = "black hole Change" })
    map({ "n", "x" }, "<LEADER>d", '"_d', { desc = "black hole delete" })
    map({ "n", "x" }, "<LEADER>D", '"_D', { desc = "black hole Delete" })

    -- Set `i_CTRL-B` as a replacement for `i_CTRL-K`
    -- because it is unused by default and right next to `i_CTRL-V`
    -- whereas `i_CTRL-K` can be convenient for other mappings.
    map("i", "<C-B>", "<C-K>", { desc = "Insert digraph" })

    -- Set (<LEADER> + :/?) as replacement for (q + :/?) because `q` is remapped to close stuff in some contexts
    map({ "n", "x" }, "<LEADER>;", "q:", { desc = "Ex-cmd win open" })
    map({ "n", "x" }, "<LEADER>/", "q/", { desc = "search win open (forward)" })
    map({ "n", "x" }, "<LEADER>?", "q?", { desc = "search win open (backword)" })

    -- Set c_<CTRL-N/P> to work like c_<UP/DOWN> because it's more useful
    map("c", "<C-N>", "<DOWN>", { desc = "cmd history next" })
    map("c", "<C-P>", "<UP>", { desc = "cmd history prev" })

    -- Set <M-CR> as raw <CR> alternate to use raw <CR> when mappings added to <CR> are unwanted
    map({ "n", "i", "o", "v", "t" }, "<M-CR>", "<CR>", { desc = "No remap <CR>" })

    -- Remap "s" to the "Surround/quick Search" mappings
    -- The vanilla "s" mapping is somewhat redundant as it's convenient enough to use "cl" instead
    -- Mapping "Surround/quick Search" directly to "s" doesn't work well because it doesn't trigger whichkey
    map({ "n", "x", "o" }, "s", "<A-s>", { remap = true, desc = "Surround/Leap" })

    -- *** Surround/quick Search mappings ***
    -- NOTE: Surround mappings are defined in `nvim-surround`
    -- NOTE: Leap mappings are defined in `leap-nvim`

    map({ "n", "x", "i" }, "<A-s>", { desc = "Surround/Leap" })
    map({ "o", "t" }, "<A-s>", { desc = "Leap" })

    -- *** Text Object mappings ***

    map({ "x" }, "al", "gg0oG$", { desc = "All buffer" })
    map({ "o" }, "al", ":normal val<CR>", { desc = "All buffer" })
    map({ "x" }, "il", "^og_", { desc = "inner line" })
    map({ "o" }, "il", ":normal vil<CR>", { desc = "inner line" })

    -- *** Insert mappings ***

    map("n", "<LEADER>i", { desc = "Insert" })

    -- **** Insert Docs/Annotations mappings ****

    map("n", "<LEADER>id", { desc = "Insert docs/annotations" })

    -- *** Buffer mappings ***

    map("n", "<LEADER>b", { desc = "buffer actions" })

    -- Navigate buffers
    map("n", "<LEADER>bb", { copy = { "n", "<Leader>bp", source = astromaps } }) -- desc = "Previous buffer"
    -- map("n", "<Leader>bss", {... desc = "Select buffer from tabline" }) NOTE: Defined in heirline config
    map("n", "<LEADER>bh", { copy = { "n", "[b", source = astromaps } }) -- desc = "Previous buffer"
    map("n", "<LEADER>bj", { copy = { "n", "<LEADER>bh" } })
    map("n", "<LEADER>bk", { copy = { "n", "]b", source = astromaps } }) -- desc = "Next buffer"
    map("n", "<LEADER>bl", { copy = { "n", "<LEADER>bk" } })
    -- map({ "n", "i", "v", "t" }, "<M-J>", { copy = { "n", "<LEADER>bj" } })
    -- map({ "n", "i", "v", "t" }, "<M-K>", { copy = { "n", "<LEADER>bk" } })

    -- Open/Close (enew) buffers
    map("n", "<LEADER>bx", { desc = "Close buffer(s)" })
    map("n", "<LEADER>bxx", { copy = { "n", "<Leader>c", source = astromaps } }) -- desc = "Close buffer"
    map("n", "<LEADER>xbb", { copy = { "n", "<LEADER>bxx" } })
    map("n", "<LEADER>X", { copy = { "n", "<LEADER>bxx" } })
    -- map("n", "<Leader>bxs", {... desc = "Close buffer from tabline" }) NOTE: Defined in heirline config
    map({ "n", "i", "v", "t" }, "<M-X>", { copy = { "n", "<LEADER>bxx" } })
    map("n", "<LEADER>bX", { copy = { "n", "<Leader>C", source = astromaps } }) -- desc = "Force close buffer"
    map("n", "<LEADER>bxa", { copy = { "n", "<Leader>bc", source = astromaps } }) -- desc = "Close all buffers except current"
    map("n", "<LEADER>bxA", { copy = { "n", "<Leader>bC", source = astromaps } }) -- desc = "Close all buffers"
    map("n", "<LEADER>bxh", { copy = { "n", "<Leader>bl", source = astromaps } }) -- desc = "Close all buffers to the left"
    map("n", "<LEADER>bxj", { copy = { "n", "<LEADER>bxh" } })
    map("n", "<LEADER>bxk", { copy = { "n", "<Leader>br", source = astromaps } }) -- desc = "Close all buffers to the right"
    map("n", "<LEADER>bxl", { copy = { "n", "<LEADER>bxk" } })

    -- Sort buffers
    map("n", "<LEADER>bs", { desc = "Select/Sort buffer(s)" })
    map("n", "<LEADER>bse", { copy = { "n", "<Leader>bse", source = astromaps } }) -- desc = "By extension"
    map("n", "<LEADER>bsr", { copy = { "n", "<Leader>bsr", source = astromaps } }) -- desc = "By relative path"
    map("n", "<LEADER>bsp", { copy = { "n", "<Leader>bsp", source = astromaps } }) -- desc = "By full path"
    map("n", "<LEADER>bsi", { copy = { "n", "<Leader>bsi", source = astromaps } }) -- desc = "By buffer number"
    map("n", "<LEADER>bsm", { copy = { "n", "<Leader>bsm", source = astromaps } }) -- desc = "By modification"

    -- Move buffers
    map("n", "<LEADER>bm", { desc = "Move buffer" })
    map("n", "<LEADER>bmh", { copy = { "n", "<b", source = astromaps } }) -- desc = "Move buffer tab right"
    map("n", "<LEADER>bmj", { copy = { "n", "<LEADER>bmh" } })
    map("n", "<LEADER>bmk", { copy = { "n", ">b", source = astromaps } }) -- desc = "Move buffer tab right"
    map("n", "<LEADER>bml", { copy = { "n", "<LEADER>bmk" } })
    map({ "n", "i", "v", "t" }, "<M-H>", { copy = { "n", "<LEADER>bmh" } })
    map({ "n", "i", "v", "t" }, "<M-L>", { copy = { "n", "<LEADER>bml" } })

    -- *** Window mappings ***

    map({ "n", "x" }, "<LEADER>w", { desc = "window actions" })

    -- Sync window
    map({ "n", "x" }, "<LEADER>wy", function() require("my.utils.win").sync_current_win() end, { desc = "Sync window" })

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

    -- Open/Close (enew) window
    map("n", "<LEADER>ow", { desc = "Open new window" })
    map("n", "<LEADER>owh", "<CMD>leftabove vertical new<CR>", { desc = "Open new window (left-inner)" })
    map("n", "<LEADER>owj", "<CMD>rightbelow new<CR>", { desc = "Open new window (down-inner)" })
    map("n", "<LEADER>owk", "<CMD>leftabove new<CR>", { desc = "Open new window (up-inner)" })
    map("n", "<LEADER>owl", "<CMD>rightbelow vertical new<CR>", { desc = "Open new window (right-inner)" })
    map("n", "<LEADER>owH", "<CMD>topleft vertical new<CR>", { desc = "Open new window (left-outer)" })
    map("n", "<LEADER>owJ", "<CMD>botright new<CR>", { desc = "Open new window (down-outer)" })
    map("n", "<LEADER>owK", "<CMD>topleft new<CR>", { desc = "Open new window (up-outer)" })
    map("n", "<LEADER>owL", "<CMD>botright vertical new<CR>", { desc = "Open new window (right-outer)" })
    map("n", "<LEADER>wx", "<CMD>close<CR>", { desc = "Close current window" })
    map("n", "<LEADER>xw", { copy = { "n", "<LEADER>wx" } })
    map("n", "<LEADER>xx", { copy = { "n", "<LEADER>wx" } })
    map({ "n", "i", "v", "t" }, "<M-x>", { copy = { "n", "<LEADER>wx" } })

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

    -- Change window PWD
    map("n", "<LEADER>wp", function() schdir_buf_dir "w" end, { desc = "win cd" })
    map("n", "<LEADER>wr", function() schdir_buf_root "w" end, { desc = "win cd root" })

    -- *** Tab mappings ***

    map({ "n", "x" }, "<LEADER><TAB>", { desc = "Tab actions" })

    -- Navigate tabs
    map({ "n", "x" }, "<LEADER><TAB><TAB>", "<CMD>tabnext #<CR>", { desc = "Go to tab (alternate)" })
    map({ "n", "x" }, "<LEADER><TAB>h", "<CMD>tabfirst<CR>", { desc = "Go to tab (first)" })
    map({ "n", "x" }, "<LEADER><TAB>j", "<CMD>tabprevious<CR>", { desc = "Go to tab (previous)" })
    map({ "n", "x" }, "<LEADER><TAB>k", "<CMD>tabnext<CR>", { desc = "Go to tab (next)" })
    map({ "n", "x" }, "<LEADER><TAB>l", "<CMD>tablast<CR>", { desc = "Go to tab (last)" })
    map({ "n", "i", "v", "t" }, "<M-H>", { copy = { "n", "<LEADER><TAB>h" } })
    map({ "n", "i", "v", "t" }, "<M-J>", { copy = { "n", "<LEADER><TAB>j" } })
    map({ "n", "i", "v", "t" }, "<M-K>", { copy = { "n", "<LEADER><TAB>k" } })
    map({ "n", "i", "v", "t" }, "<M-L>", { copy = { "n", "<LEADER><TAB>l" } })

    -- Open/Close new tab
    map("n", "<LEADER>o<TAB>", { desc = "Open new tab" })
    map("n", "<LEADER>o<TAB>h", "<CMD>0tabedit<CR>", { desc = "Open new tab (first)" })
    map("n", "<LEADER>o<TAB>j", "<CMD>-tabedit<CR>", { desc = "Open new tab (previous)" })
    map("n", "<LEADER>o<TAB>k", "<CMD>tabedit<CR>", { desc = "Open new tab (next)" })
    map("n", "<LEADER>o<TAB>l", "<CMD>$tabedit<CR>", { desc = "Open new tab (last)" })
    map("n", "<LEADER>o<TAB><TAB>", "<CMD>tabedit<CR>", { desc = "Open new tab (next)" })
    map("n", "<LEADER>o<S-TAB>", "<CMD>-tabedit<CR>", { desc = "Open new tab (previous)" })
    map("n", "<LEADER>x<TAB>", "<CMD>tabclose<CR>", { desc = "Close current tab" })

    -- Change tab PWD
    map("n", "<LEADER><TAB>p", function() schdir_buf_dir "t" end, { desc = "tab cd" })
    map("n", "<LEADER><TAB>r", function() schdir_buf_root "t" end, { desc = "tab cd root" })

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

    -- *** Open/Close mappings ***

    map("n", "<LEADER>o", { desc = "Open ..." })
    map("n", "<LEADER>x", { desc = "close (eXit) ..." })

    -- Add blank line
    map("n", "<LEADER>oo", "o<ESC>0D", { desc = "Add Blank line below" })
    map("n", "<LEADER>O", "O<ESC>0D", { desc = "Add Blank line above" })

    -- Quickfix and Locations list
    map("n", "<LEADER>ol", "<CMD>lopen<cr>", { desc = "Open location list" })
    map("n", "<LEADER>oq", "<CMD>copen<cr>", { desc = "Open quickfix list" })
    map("n", "<LEADER>xl", "<CMD>lclose<cr>", { desc = "Close location list" })
    map("n", "<LEADER>xq", "<CMD>cclose<cr>", { desc = "Close quickfix list" })

    -- Help and Man pages
    map("n", "<LEADER>oh", { desc = "Open nvim help" })
    map("n", "<LEADER>ohh", {
      function() util_win.open_util_in_current_win { init = ":help", ft = "help", prompt_cmd = ":help " } end,
      desc = "Open nvim help (tag)",
    })
    map("n", "<LEADER>ohg", {
      function() util_win.open_util_in_current_win { init = ":help", ft = "help", prompt_cmd = ":helpgrep " } end,
      desc = "Open nvim help (grep)",
    })
    map("n", "<LEADER>om", {
      function() util_win.open_util_in_current_win { init = ":Man man", ft = "man", prompt_cmd = ":Man " } end,
      desc = "Open manpages",
    })

    -- Git (fugitive)
    map("n", "<LEADER>og", { desc = "Open fugitive git ..." })
    map("n", "<LEADER>ogg", {
      function() util_win.open_cmd_in_current_win ":Git" end,
      desc = "Open fugitive git status",
    })
    map("n", "<LEADER>ogl", {
      function() util_win.open_cmd_in_current_win ":Git log --oneline" end,
      desc = "Open fugitive git `log --oneline`",
    })

    -- File manager/explorer
    map("n", "<LEADER>of", { desc = "Open file manager/explorer" })

    -- AI (CodeCompanion)
    -- NOTE: This is defined in the CodeCompanion plugin config

    map({ "n", "v" }, "<LEADER>oa", { desc = "Open AI chat" })

    -- *** Yank/Paste/Register mappings ***

    -- Prepend register
    map({ "n", "x" }, "<LEADER>''", '"', { desc = 'alternate " (choose register)' })
    map({ "n", "x" }, "<LEADER>'c", '"+', { desc = "prepend clipboard register" })
    map({ "n", "x" }, "<LEADER>'s", '"*', { desc = "prepend selection register" })
    map({ "n", "x" }, "<LEADER>'e", '"=', { desc = "prepend expression register" })
    map({ "n", "x" }, "<LEADER>'b", '"%', { desc = "prepend current buffer name register" })
    map(
      { "n", "x" },
      "<LEADER>'d",
      "\"=expand('%:h')<CR>",
      { desc = "prepend current buffer dir (expression) register" }
    )
    map({ "n", "x" }, "<LEADER>'B", '"#', { desc = "prepend alternate buffer name register" })
    map(
      { "n", "x" },
      "<LEADER>'D",
      "\"=expand('#:h')<CR>",
      { desc = "prepend alternate buffer dir (expression) register" }
    )

    -- Paste in insert/command/terminal modes (meant as enhanced `i_<C-R>`)
    map({ "!", "n", "t", "x" }, "<M-p>", "", { desc = "Paste ..." })
    map("!", "<M-p>c", "<C-R>+", { desc = "Paste (clipboard)" })
    map("!", "<M-p>p", '<C-R>"', { desc = "Paste (unnamed)" })
    map("!", "<M-p>s", "<C-R>*", { desc = "Paste (selection)" })
    map("!", "<M-p>r", "'<C-R>'.nr2char(getchar())", { desc = "Paste (ask register)", expr = true })
    map("!", "<M-P>", { copy = { "!", "<M-p>r" } })
    map("n", "<M-p>c", "a<C-R>+<ESC>", { desc = "Paste (clipboard)" })
    map("n", "<M-p>p", 'a<C-R>"<ESC>', { desc = "Paste (unnamed)" })
    map("n", "<M-p>s", "a<C-R>*<ESC>", { desc = "Paste (selection)" })
    map("n", "<M-p>r", "'a<C-R>'.nr2char(getchar()).'<ESC>'", { desc = "Paste (ask register)", expr = true })
    map("n", "<M-P>", { copy = { "n", "<M-p>r" } })
    map("t", "<M-p>c", '<C-\\><C-N>"+pi', { desc = "Paste (clipboard)" })
    map("t", "<M-p>p", '<C-\\><C-N>""pi', { desc = "Paste (unnamed)" })
    map("t", "<M-p>s", '<C-\\><C-N>"*pi', { desc = "Paste (selection)" })
    map("t", "<M-p>r", "'<C-\\><C-N>\"'.nr2char(getchar()).'pi'", { desc = "Paste (ask register)", expr = true })
    map("t", "<M-P>", { copy = { "t", "<M-p>r" } })
    map("x", "<M-p>c", "c<C-R>+<ESC>", { desc = "Paste (clipboard)" })
    map("x", "<M-p>p", '"_c<C-R>"<ESC>', { desc = "Paste (unnamed)" })
    map("x", "<M-p>s", "c<C-R>*<ESC>", { desc = "Paste (selection)" })
    map("x", "<M-p>r", "'c<C-R>'.nr2char(getchar()).'<ESC>'", { desc = "Paste (ask register)", expr = true })
    map("x", "<M-P>", { copy = { "x", "<M-p>r" } })

    -- *** Visual selection mappings ***

    -- Increment/Decrement visual selection using TreeSitter
    -- NOTE: this is defined in the nvim-treesitter plugin config
    -- map("n", "<C-k>", "", { desc = "init_selection" })
    -- map("v", "<C-k>", "", { desc = "node_incremental" })
    -- map("v", "<C-l>", "", { desc = "scope_incremental" })
    -- map("v", "<C-j>", "", { desc = "node_decremental" })

    -- *** Terminal mode mappings ***

    -- Open terminal
    map("n", "<LEADER>ot", { desc = "Open terminal" })
    -- NOTE: backup, current mappings in neomux plugin config
    map("n", "<LEADER>ott", "<CMD>terminal<CR>i", { desc = "Open terminal (PWD)" })
    map("n", "<LEADER>otl", "<CMD>lcd %:h|terminal<CR>i", { desc = "Open terminal (buffer dir)" })
    map("n", "<LEADER>oth", "<CMD>lcd ~|terminal<CR>i", { desc = "Open terminal (home)" })

    -- Escape from terminal to normal mode
    map("t", "<M-ESC>", "<C-\\><C-n>", { desc = "Enter normal mode" })

    -- AI (CodeCompanion)
    -- NOTE: This is defined in the CodeCompanion plugin config

    map({ "n", "v" }, "<LEADER>a", { desc = "AI" })

    -- *** Git actions ***
    -- NOTE: most git action mappings are defined in `gitsigns-nvim`

    map({ "n", "v" }, "<LEADER>g", { desc = "Git actions" })

    -- *** Find/Picker mappings ***
    -- NOTE: most find mappings are defined in `snacks`

    map("n", "<LEADER>f", { desc = "Find ..." })

    -- *** LSP mappings ***
    -- NOTE: most lsp mappings are defined in `_astrolsp_mappings`

    map({ "n", "v" }, "<LEADER>l", { desc = "LSP actions" })
    map("n", "<LEADER>ld", { copy = { "n", "<Leader>ld", source = astromaps } }) -- desc = "Hover diagnostics"

    -- *** Run/Debug mappings ***
    -- NOTE: most Run/Debug mappings are defined in `dap`

    map({ "n", "v" }, "<LEADER>r", { desc = "Run/Debug" })

    -- *** Test mappings ***
    -- NOTE: most Test mappings are defined in `neotest`

    map("n", "<LEADER>t", { desc = "Test" })

    -- *** UI/UX toggle mappings ***
    -- NOTE: A lot of additional UI/UX toggle mappings are spread in other plugin configs

    map("n", "<LEADER>u", { desc = "UI/UX toggles" })
    map("n", "<LEADER>uA", { copy = { "n", "<Leader>uA", source = astromaps } }) -- desc = "Toggle rooter autochdir"
    map("n", "<LEADER>ub", { copy = { "n", "<Leader>ub", source = astromaps } }) -- desc = "Toggle background"
    map("n", "<LEADER>ud", { copy = { "n", "<Leader>ud", source = astromaps } }) -- desc = "Toggle diagnostics"
    map("n", "<LEADER>ug", { copy = { "n", "<Leader>ug", source = astromaps } }) -- desc = "Toggle signcolumn"
    map("n", "<LEADER>u>", { copy = { "n", "<Leader>u>", source = astromaps } }) -- desc = "Toggle foldcolumn"
    map("n", "<LEADER>ui", { copy = { "n", "<Leader>ui", source = astromaps } }) -- desc = "Change indent setting"
    map("n", "<LEADER>ul", { copy = { "n", "<Leader>ul", source = astromaps } }) -- desc = "Toggle statusline"
    map("n", "<LEADER>un", { copy = { "n", "<Leader>un", source = astromaps } }) -- desc = "Change line numbering"
    map("n", "<LEADER>uN", { copy = { "n", "<Leader>uN", source = astromaps } }) -- desc = "Toggle Notifications"
    map("n", "<LEADER>up", { copy = { "n", "<Leader>up", source = astromaps } }) -- desc = "Toggle paste mode"
    map("n", "<LEADER>us", { copy = { "n", "<Leader>us", source = astromaps } }) -- desc = "Toggle spellcheck"
    map("n", "<LEADER>uS", { copy = { "n", "<Leader>uS", source = astromaps } }) -- desc = "Toggle conceal"
    map("n", "<LEADER>ut", { copy = { "n", "<Leader>ut", source = astromaps } }) -- desc = "Toggle tabline"
    map("n", "<LEADER>uu", { copy = { "n", "<Leader>uu", source = astromaps } }) -- desc = "Toggle URL highlight"
    map("n", "<LEADER>uv", { copy = { "n", "<Leader>uv", source = astromaps } }) -- desc = "Toggle virtual text"
    map("n", "<LEADER>uV", { copy = { "n", "<Leader>uV", source = astromaps } }) -- desc = "Toggle virtual lines"
    map("n", "<LEADER>uw", { copy = { "n", "<Leader>uw", source = astromaps } }) -- desc = "Toggle wrap"
    map("n", "<LEADER>uy", { copy = { "n", "<Leader>uy", source = astromaps } }) -- desc = "Toggle syntax highlight"

    -- *** Top level Editor mappings ***

    map("n", "<LEADER>q", { desc = "Editor actions" })

    -- Write/Quit
    map("n", "<LEADER>qw", "<CMD>confirm wall<CR>", { desc = "Write all" })
    map("n", "<LEADER>qq", "<CMD>confirm qall<CR>", { desc = "Exit with confirm" })

    -- Sessions
    -- NOTE: Session mappings are defined in `resession-nvim`

    map("n", "<LEADER>qs", { desc = "Sessions" })

    -- Change active/global PWD
    map("n", "<LEADER>qp", function() schdir_buf_dir "a" end, { desc = "active cd" })
    map("n", "<LEADER>qr", function() schdir_buf_root "a" end, { desc = "active cd root" })
    map("n", "<LEADER>qP", function() schdir_buf_dir "g" end, { desc = "global cd" })
    map("n", "<LEADER>qR", function() schdir_buf_root "g" end, { desc = "global cd root" })

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

---@type LazyPluginSpec[]
return {
  spec_astrocore,
}
