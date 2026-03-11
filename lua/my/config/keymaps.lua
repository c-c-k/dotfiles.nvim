local my = require "my"
---@class my.config.keymaps
local M = {}

-- Helper to get mode_slugs list without going into the meta file.
-- selene: allow(unused_variable)
---@type my.keymap.mode_slugs
---@diagnostic disable-next-line: unused-local
local mode_slugs

local b_defaults = { buffer = true }

---@alias kmlg my.keymap.keymaps_loader_group
-- sort with `/-- KEYGROUPS START/+1,/-- KEYGROUPS END/-1sort /M.\w_/`
-- KEYGROUPS START
M.g_aerial__ = {} ---@type kmlg # "stevearc/aerial.nvim"
M.g_aupairs_ = {} ---@type kmlg # "windwp/nvim-autopairs"
M.g_blinkcmp = {} ---@type kmlg # "saghen/blink.cmp"
M.g_coco_ai_ = {} ---@type kmlg # "olimorris/codecompanion.nvim"
M.b_core____ = {} ---@type kmlg # core NVIM buffer
M.g_core____ = {} ---@type kmlg # core NVIM global
M.b_core_lsp = {} ---@type kmlg # core NVIM LSP buffer
-- M.b_core_lsp.defaults = b_defaults
M.g_dap_____ = {} ---@type kmlg # "mfussenegger/nvim-dap"
M.g_dap_ui__ = {} ---@type kmlg # "rcarriga/nvim-dap-ui"
M.g_dap_view = {} ---@type kmlg # "igorlfs/nvim-dap-view"
M.g_fugitive = {} ---@type kmlg # "tpope/vim-fugitive"
M.b_gitsigns = {} ---@type kmlg # "lewis6991/gitsigns.nvim"
-- M.b_gitsigns.defaults = b_defaults
M.g_illumint = {} ---@type kmlg # "RRethy/vim-illuminate"
M.g_leap____ = {} ---@type kmlg # "ggandor/leap.nvim"
M.b_lspconfg = {} ---@type kmlg # "neovim/nvim-lspconfig"
-- M.b_lspconfg.defaults = b_defaults
M.b_md_nvim_ = {} ---@type kmlg # "tadmccorkle/markdown.nvim"
-- M.b_md_nvim_.defaults = b_defaults
M.g_minfiles = {} ---@type kmlg # "nvim-mini/mini.files"
M.b_minfiles = {} ---@type kmlg # "nvim-mini/mini.files"
-- M.b_minfiles.defaults = b_defaults
M.g_neotest_ = {} ---@type kmlg # "nvim-neotest/neotest"
M.g_notes___ = {} ---@type kmlg # my notes/pkms
M.b_null_ls_ = {} ---@type kmlg # "nvimtools/none-ls.nvim"
-- M.b_null_ls_.defaults = b_defaults
M.g_nv_ts___ = {} ---@type kmlg # "nvim-treesitter/nvim-treesitter"
M.g_oil_____ = {} ---@type kmlg # "stevearc/oil.nvim"
M.b_oil_____ = {} ---@type kmlg # "stevearc/oil.nvim"
-- M.b_oil_____.defaults = b_defaults
M.g_rsession = {} ---@type kmlg # "stevearc/resession.nvim"
M.g_snkindnt = {} ---@type kmlg # "folke/snacks.nvim": indent
M.g_snkkbuf_ = {} ---@type kmlg # "folke/snacks.nvim": picker: buffers
M.g_snkkfs__ = {} ---@type kmlg # "folke/snacks.nvim": picker: files/filesystem
M.g_snkkgit_ = {} ---@type kmlg # "folke/snacks.nvim": picker: git
-- M.g_snkkgit_.defaults = { cond = function() return vim.fn.executable "git" == 1 end }
M.g_snkklsp_ = {} ---@type kmlg # "folke/snacks.nvim": picker: LSP
M.g_snkknvim = {} ---@type kmlg # "folke/snacks.nvim": picker: NVIM stuff
M.g_snkkrg__ = {} ---@type kmlg # "folke/snacks.nvim": picker: RipGrep
-- M.g_snkkrg__.defaults = { cond = function() return vim.fn.executable "rg" == 1 end }
M.g_snknotfy = {} ---@type kmlg # "folke/snacks.nvim": notifications
M.g_surround = {} ---@type kmlg # "kylechui/nvim-surround"
M.g_ufo_____ = {} ---@type kmlg # "kevinhwang91/nvim-ufo"
M.b_ufo_____ = {} ---@type kmlg # "kevinhwang91/nvim-ufo"
-- M.b_ufo_____.defaults = b_defaults
M.g_venvslct = {} ---@type kmlg # "linux-cultist/venv-selector.nvim"
M.g_wkey____ = {} ---@type kmlg # "folke/which-key.nvim"
-- KEYGROUPS END

-- ============================================================================

-- sort with `/-- KEYMAPS START/+1,/-- KEYMAPS END/-1sort i /M.\{-\}\[["']..._<.>/`
-- KEYMAPS START
M.g_illumint["n___<_> # "] = my.syntax.illuminate.keymaps.prev
M.g_core____["nxo_<_> ' "] = my.motion.keymaps.goto_mark_char
M.g_core____["nx__<L> '' "] = my.ypxcd.keymaps.choose_register
M.g_core____["nx__<L> 'B "] = my.ypxcd.keymaps.prepend_alt_buf_name_reg
M.g_core____["nx__<L> 'b "] = my.ypxcd.keymaps.prepend_buf_name_reg
M.g_core____["nx__<L> 'c "] = my.ypxcd.keymaps.prepend_clipboard_reg
M.g_core____["nx__<L> 'D "] = my.ypxcd.keymaps.prepend_alt_buf_dir_reg
M.g_core____["nx__<L> 'd "] = my.ypxcd.keymaps.prepend_buf_dir_reg
M.g_core____["nx__<L> 'e "] = my.ypxcd.keymaps.prepend_expr_reg
M.g_core____["nx__<L> 's "] = my.ypxcd.keymaps.prepend_selection_reg
M.g_illumint["n___<_> * "] = my.syntax.illuminate.keymaps.next
M.g_core____["nx__<L> / "] = my.win.keymaps.open_search_forward
M.b_minfiles["n___<_> <BS> "] = my.fs.minifiles.keymaps.go_out_plus
M.b_oil_____["n___<_> <BS> "] = my.fs.oil.keymaps.parent
M.b_minfiles["n___<_> <CR> "] = my.fs.minifiles.keymaps.go_in_plus
M.b_oil_____["n___<_> <CR> "] = my.fs.oil.keymaps.select
M.b_md_nvim_["n___<L> <CR> "] = my.ft.markdown.keymaps.toggle_checkbox_n_
M.b_md_nvim_["x___<L> <CR> "] = my.ft.markdown.keymaps.toggle_checkbox_x_
M.g_core____["all_<A> <CR> "] = my.keymap.keymaps.no_remap_cr
M.b_md_nvim_["il__<_> <CR> "] = my.ft.markdown.keymaps.super_newline_below_i_
M.b_core____["n___<C> <DOWN> "] = my.win.keymaps.shrink_win_y
M.g_core____["all_<A> <ESC> "] = my.keymap.keymaps.force_normal_mode
M.g_blinkcmp["!___<_> <ESC> "] = my.cmp.blink.keymaps.cancel_or_escape
M.b_core____["n___<C> <LEFT> "] = my.win.keymaps.shrink_win_x
M.b_core____["n___<C> <RIGHT> "] = my.win.keymaps.grow_win_x
M.g_blinkcmp["il__<_> <S-Tab> "] = my.cmp.blink.keymaps.snippet_backward
M.g_blinkcmp["!___<C> <SPACE> "] = my.cmp.blink.keymaps.show
M.g_blinkcmp["il__<_> <Tab> "] = my.cmp.blink.keymaps.snippet_forward
M.g_core____["all_<A> <TAB> "] = my.tab.keymaps.jump_by_label
M.g_core____["n___<L> <TAB> "] = { wk_group = "Tab actions" }
M.g_core____["n___<L> <TAB><TAB> "] = my.tab.keymaps.jump_by_label
M.g_core____["n___<L> <TAB>H "] = my.tab.keymaps.goto_first
M.g_core____["n___<L> <TAB>h "] = my.tab.keymaps.goto_left
M.g_core____["n___<L> <TAB>J "] = my.tab.keymaps.goto_first
M.g_core____["n___<L> <TAB>j "] = my.tab.keymaps.goto_left
M.g_core____["n___<L> <TAB>K "] = my.tab.keymaps.goto_last
M.g_core____["n___<L> <TAB>k "] = my.tab.keymaps.goto_right
M.g_core____["n___<L> <TAB>L "] = my.tab.keymaps.goto_last
M.g_core____["n___<L> <TAB>l "] = my.tab.keymaps.goto_right
M.g_core____["n___<L> <TAB>m "] = { wk_group = "Move tab" }
M.g_core____["n___<L> <TAB>mH "] = my.tab.keymaps.move_first
M.g_core____["n___<L> <TAB>mh "] = my.tab.keymaps.move_left
M.g_core____["n___<L> <TAB>mJ "] = my.tab.keymaps.move_first
M.g_core____["n___<L> <TAB>mj "] = my.tab.keymaps.move_left
M.g_core____["n___<L> <TAB>mK "] = my.tab.keymaps.move_last
M.g_core____["n___<L> <TAB>mk "] = my.tab.keymaps.move_right
M.g_core____["n___<L> <TAB>mL "] = my.tab.keymaps.move_last
M.g_core____["n___<L> <TAB>ml "] = my.tab.keymaps.move_right
M.g_core____["n___<L> <TAB>mm "] = my.tab.keymaps.move_alt
M.g_core____["n___<L> <TAB>n "] = my.tab.keymaps.set_name
M.g_core____["n___<L> <TAB>O "] = my.tab.keymaps.open_new_left
M.g_core____["n___<L> <TAB>o "] = { wk_group = "Open new tab" }
M.g_core____["n___<L> <TAB>oH "] = my.tab.keymaps.open_new_first
M.g_core____["n___<L> <TAB>oh "] = my.tab.keymaps.open_new_left
M.g_core____["n___<L> <TAB>oJ "] = my.tab.keymaps.open_new_first
M.g_core____["n___<L> <TAB>oj "] = my.tab.keymaps.open_new_left
M.g_core____["n___<L> <TAB>oK "] = my.tab.keymaps.open_new_last
M.g_core____["n___<L> <TAB>ok "] = my.tab.keymaps.open_new_right
M.g_core____["n___<L> <TAB>oL "] = my.tab.keymaps.open_new_last
M.g_core____["n___<L> <TAB>ol "] = my.tab.keymaps.open_new_right
M.g_core____["n___<L> <TAB>oo "] = my.tab.keymaps.open_new_right
M.g_core____["n___<L> <TAB>p "] = my.fs.cd.keymaps.tab_cd
M.g_core____["n___<L> <TAB>r "] = my.fs.cd.keymaps.tab_cd_root
M.g_core____["n___<L> <TAB>s "] = { wk_group = "Split to tab" }
M.g_core____["n___<L> <TAB>sH "] = my.win.keymaps.split_to_tab_first
M.g_core____["n___<L> <TAB>sh "] = my.win.keymaps.split_to_tab_left
M.g_core____["n___<L> <TAB>sJ "] = my.win.keymaps.split_to_tab_first
M.g_core____["n___<L> <TAB>sj "] = my.win.keymaps.split_to_tab_left
M.g_core____["n___<L> <TAB>sK "] = my.win.keymaps.split_to_tab_last
M.g_core____["n___<L> <TAB>sk "] = my.win.keymaps.split_to_tab_right
M.g_core____["n___<L> <TAB>sL "] = my.win.keymaps.split_to_tab_last
M.g_core____["n___<L> <TAB>sl "] = my.win.keymaps.split_to_tab_right
M.g_core____["n___<L> <TAB>ss "] = my.win.keymaps.split_to_tab_right
M.g_core____["n___<L> <TAB>x "] = my.tab.keymaps.close_current
M.b_core____["n___<C> <UP> "] = my.win.keymaps.grow_win_y
M.b_minfiles["n___<_> > "] = my.fs.minifiles.keymaps.trim_right
M.g_core____["nx__<L> ; "] = my.win.keymaps.open_cmd_win
M.g_core____["nx__<L> ? "] = my.win.keymaps.open_search_backword
M.b_md_nvim_["n___<_> [[ "] = my.ft.markdown.keymaps.prev_heading
M.b_gitsigns["n___<_> [C "] = my.git.gitsigns.keymaps.first_hunk_unstaged
M.b_gitsigns["n___<_> [c "] = my.git.gitsigns.keymaps.prev_hunk_unstaged
M.b_core_lsp["n___<_> [d "] = my.lsp.keymaps.diagnostic_jump_prev
M.b_core_lsp["n___<_> [e "] = my.lsp.keymaps.diagnostic_jump_prev_error
M.b_md_nvim_["n___<_> [F "] = my.ft.markdown.keymaps.current_heading
M.b_md_nvim_["n___<_> [f "] = my.ft.markdown.keymaps.parent_heading
M.b_gitsigns["n___<_> [G "] = my.git.gitsigns.keymaps.first_hunk_all
M.b_gitsigns["n___<_> [g "] = my.git.gitsigns.keymaps.prev_hunk_all
M.g_core____["nx__<_> [p "] = my.ypxcd.keymaps.paste_indented_after
M.g_core____["nx__<_> [P "] = my.ypxcd.keymaps.paste_indented_before
M.g_neotest_["n___<_> [t "] = my.testing.neotest.keymaps.prev
M.b_gitsigns["n___<_> [U "] = my.git.gitsigns.keymaps.first_hunk_staged
M.b_gitsigns["n___<_> [u "] = my.git.gitsigns.keymaps.prev_hunk_staged
M.b_core_lsp["n___<_> [w "] = my.lsp.keymaps.diagnostic_jump_prev_warn
M.g_ufo_____["n___<_> [z "] = my.win.ufo.keymaps.goPreviousClosedFold
M.b_md_nvim_["n___<_> ]] "] = my.ft.markdown.keymaps.next_heading
M.b_gitsigns["n___<_> ]C "] = my.git.gitsigns.keymaps.last_hunk_unstaged
M.b_gitsigns["n___<_> ]c "] = my.git.gitsigns.keymaps.next_hunk_unstaged
M.b_core_lsp["n___<_> ]d "] = my.lsp.keymaps.diagnostic_jump_next
M.b_core_lsp["n___<_> ]e "] = my.lsp.keymaps.diagnostic_jump_next_error
M.b_gitsigns["n___<_> ]G "] = my.git.gitsigns.keymaps.last_hunk_all
M.b_gitsigns["n___<_> ]g "] = my.git.gitsigns.keymaps.next_hunk_all
M.g_core____["nx__<_> ]p "] = my.ypxcd.keymaps.paste_indented_after
M.g_core____["nx__<_> ]P "] = my.ypxcd.keymaps.paste_indented_before
M.g_neotest_["n___<_> ]t "] = my.testing.neotest.keymaps.next
M.b_gitsigns["n___<_> ]U "] = my.git.gitsigns.keymaps.last_hunk_staged
M.b_gitsigns["n___<_> ]u "] = my.git.gitsigns.keymaps.next_hunk_staged
M.b_core_lsp["n___<_> ]w "] = my.lsp.keymaps.diagnostic_jump_next_warn
M.g_ufo_____["n___<_> ]z "] = my.win.ufo.keymaps.goNextClosedFold
M.g_core____["nxo_<_> ` "] = my.motion.keymaps.goto_mark_row
M.g_core____["nx__<L> a "] = { wk_group = "AI" }
M.g_coco_ai_["n___<L> aa "] = my.ai.coco.keymaps.inline_cmd_n_
M.g_coco_ai_["x___<L> aa "] = my.ai.coco.keymaps.inline_cmd_x_
M.g_core____["o___<_> al "] = my.motion.keymaps.text_object_all_buffer_o_
M.g_core____["x___<_> al "] = my.motion.keymaps.text_object_all_buffer_x_
M.g_core____["n___<L> ao "] = { wk_proxy = { km_group = M.g_core____, km_id = "n___<L> oa " } }
M.g_core____["il__<C> B "] = my.cmp.keymaps.insert_digraph
M.b_ufo_____["n___<C> B "] = my.win.ufo.keymaps.preview_win_scrollB
M.g_core____["n___<L> b "] = { wk_group = "buffer actions" }
M.g_core____["n___<L> bo "] = my.buf.keymaps.enew
M.g_core____["n___<L> bx "] = my.buf.keymaps.close_buf
M.g_core____["nx__<L> c "] = my.ypxcd.keymaps.black_hole_change
M.g_core____["nx__<L> C "] = my.ypxcd.keymaps.black_hole_change_to_end
M.b_ufo_____["n___<C> D "] = my.win.ufo.keymaps.preview_win_scrollD
M.g_core____["nx__<L> d "] = my.ypxcd.keymaps.black_hole_delete
M.g_core____["nx__<L> D "] = my.ypxcd.keymaps.black_hole_delete_to_end
M.g_blinkcmp["!___<C> E "] = my.cmp.blink.keymaps.cancel_and_clear_buf_vars
M.b_ufo_____["n___<C> E "] = my.win.ufo.keymaps.preview_win_scrollE
M.g_core____["n___<L> e "] = { wk_group = "tErminal/!Exec" }
M.g_core____["n___<L> ee "] = my.term.keymaps.exec_in_shell
M.g_core____["x___<L> ef "] = my.term.keymaps.filter_in_shell
M.g_core____["n___<L> eO "] = my.term.keymaps.open_term_exec_cmd
M.g_core____["n___<L> eo "] = { wk_group = "Open tErminal" }
M.g_core____["n___<L> eol "] = my.term.keymaps.open_term_buf
M.g_core____["n___<L> eoo "] = my.term.keymaps.open_term_pwd
M.g_core____["n___<L> eor "] = my.term.keymaps.open_term_root
M.g_core____["n___<L> er "] = my.term.keymaps.read_from_shell
M.g_core____["n___<L> ew "] = my.term.keymaps.write_to_shell
M.g_minfiles["n___<L> F "] = my.fs.minifiles.keymaps.open_from_input
M.b_ufo_____["n___<C> F "] = my.win.ufo.keymaps.preview_win_scrollF
M.g_core____["n___<L> f "] = { wk_group = "file managers" }
M.g_coco_ai_["n___<L> fa "] = my.ai.coco.keymaps.find_ai_actions_n_
M.g_coco_ai_["x___<L> fa "] = my.ai.coco.keymaps.find_ai_actions_x_
M.g_minfiles["n___<L> ff "] = my.fs.minifiles.keymaps.toggle
M.g_oil_____["n___<L> fo "] = my.fs.oil.keymaps.open_from_buf
M.g_oil_____["n___<L> fO "] = my.fs.oil.keymaps.open_from_input
M.g_minfiles["n___<L> fp "] = my.fs.minifiles.keymaps.open_pwd
M.g_minfiles["n___<L> fs "] = my.fs.minifiles.keymaps.open_from_buf
M.g_core____["nx__<L> g "] = { wk_group = "Git" }
M.b_oil_____["n___<_> g. "] = my.fs.oil.keymaps.toggle_hidden
M.b_minfiles["n___<_> g? "] = my.fs.minifiles.keymaps.show_help
M.b_oil_____["n___<_> g? "] = my.fs.oil.keymaps.show_help
M.g_coco_ai_["x___<_> ga "] = my.ai.coco.keymaps.add_to_chat
M.b_gitsigns["n___<L> gb "] = my.git.gitsigns.keymaps.blame_line
M.b_gitsigns["n___<L> gB "] = my.git.gitsigns.keymaps.blame_line_full
M.b_gitsigns["n___<L> gD "] = my.git.gitsigns.keymaps.diff_custom
M.b_gitsigns["n___<L> gdd "] = my.git.gitsigns.keymaps.diff_with_index
M.b_gitsigns["n___<L> gdh "] = my.git.gitsigns.keymaps.diff_with_head
M.b_gitsigns["n___<L> gdl "] = my.git.gitsigns.keymaps.diff_with_last_commit
M.g_core____["n___<_> gf "] = my.go_to.keymaps.n_goto_file
M.g_core____["x___<_> gf "] = my.go_to.keymaps.v_goto_file
M.g_core____["nxo_<_> gg "] = my.motion.keymaps.go_to_start_of_buffer
M.b_gitsigns["n___<L> gl "] = my.git.gitsigns.keymaps.setloclist
M.b_gitsigns["n___<L> gL "] = my.git.gitsigns.keymaps.setloclist_all
M.g_core____["n___<L> go "] = { wk_group = "Open fuGitive" }
M.g_fugitive["n___<L> gol "] = my.git.fugitive.keymaps.open_log_from_buf
M.g_fugitive["n___<L> goo "] = my.git.fugitive.keymaps.open_git_win_from_buf
M.b_gitsigns["n___<L> gP "] = my.git.gitsigns.keymaps.preview_hunk
M.b_gitsigns["n___<L> gp "] = my.git.gitsigns.keymaps.preview_hunk_inline
M.b_gitsigns["n___<L> gq "] = my.git.gitsigns.keymaps.setqflist
M.b_gitsigns["n___<L> gQ "] = my.git.gitsigns.keymaps.setqflist_all
M.b_gitsigns["n___<L> gR "] = my.git.gitsigns.keymaps.reset_buffer
M.b_gitsigns["n___<L> gr "] = my.git.gitsigns.keymaps.reset_hunk
M.b_gitsigns["x___<L> gr "] = my.git.gitsigns.keymaps.reset_hunk_visual
M.b_oil_____["n___<_> gs "] = my.fs.oil.keymaps.change_sort
M.b_gitsigns["n___<L> gS "] = my.git.gitsigns.keymaps.stage_buffer
M.b_gitsigns["n___<L> gs "] = my.git.gitsigns.keymaps.toggle_hunk
M.b_gitsigns["x___<L> gs "] = my.git.gitsigns.keymaps.toggle_hunk_visual
M.g_core____["n___<_> gx "] = my.go_to.keymaps.n_goto_external
M.g_core____["x___<_> gx "] = my.go_to.keymaps.v_goto_external
M.g_blinkcmp["!___<C> H "] = my.cmp.blink.keymaps.toggle_documentation_or_signature
M.b_minfiles["n___<_> h "] = my.fs.minifiles.keymaps.go_out
M.b_oil_____["n___<_> h "] = my.fs.oil.keymaps.parent
M.b_core_lsp["n___<C> H "] = my.lsp.keymaps.symbol_hover
M.g_core____["il__<A> H "] = my.motion.keymaps.head_line_i_
M.g_core____["nxo_<A> H "] = my.motion.keymaps.head_line_n_
M.g_core____["nxo_<_> H "] = my.motion.keymaps.left
M.g_core____["all_<A> h "] = my.win.keymaps.navigate_left
M.g_leap____["itl_<A> i "] = my.motion.leap.keymaps.jump_in_window_i_
M.g_leap____["nxo_<A> i "] = my.motion.leap.keymaps.jump_in_window_n_
M.g_core____["n___<L> i "] = { wk_group = "Insert" }
M.b_gitsigns["xo__<_> ig "] = my.git.gitsigns.keymaps.select_hunk
M.b_gitsigns["xo__<_> ih "] = my.git.gitsigns.keymaps.select_hunk
M.g_core____["o___<_> il "] = my.motion.keymaps.text_object_inner_line_o_
M.g_core____["x___<_> il "] = my.motion.keymaps.text_object_inner_line_x_
M.g_blinkcmp["!___<C> J "] = my.cmp.blink.keymaps.next_or_scroll_doc_down
M.g_core____["il__<A> J "] = my.cmp.keymaps.join_lines_i_
M.g_core____["nx__<A> J "] = my.cmp.keymaps.join_lines_n_
M.g_core____["nxo_<_> J "] = my.motion.keymaps.down_in_wrap
M.g_nv_ts___["n___<C> J "] = my.syntax.ts.keymaps.init_selection
M.g_nv_ts___["x___<C> J "] = my.syntax.ts.keymaps.node_decremental
M.g_core____["all_<A> j "] = my.win.keymaps.navigate_down
M.g_blinkcmp["!___<C> K "] = my.cmp.blink.keymaps.prev_or_scroll_doc_up
M.g_core____["il__<A> K "] = my.misc.keymaps.key_prog_i_
M.g_core____["nx__<A> K "] = my.misc.keymaps.key_prog_n_
M.g_core____["nxo_<_> K "] = my.motion.keymaps.up_in_wrap
M.g_nv_ts___["n___<C> K "] = my.syntax.ts.keymaps.init_selection
M.g_nv_ts___["x___<C> K "] = my.syntax.ts.keymaps.node_incremental
M.g_core____["all_<A> k "] = my.win.keymaps.navigate_up
M.g_core____["n___<L> k "] = { wk_group = "picKers" }
M.g_snkknvim['n___<L> k" '] = my.ui.picker.snacks.keymaps.find_registers
M.g_snkknvim["n___<L> k' "] = my.ui.picker.snacks.keymaps.find_marks
M.g_snkknvim["n___<L> k<CR> "] = my.ui.picker.snacks.keymaps.resume_previous_search
M.g_snkkbuf_["n___<L> kb "] = { wk_group = "buffer(s)" }
M.g_snkkbuf_["n___<L> kbb "] = my.ui.picker.snacks.keymaps.find_buffers
M.g_snkkbuf_["n___<L> kbl "] = my.ui.picker.snacks.keymaps.find_lines_in_buffer
M.g_snkknvim["n___<L> kc "] = my.ui.picker.snacks.keymaps.find_commands
M.g_snkkfs__["n___<L> kf "] = { wk_group = "Find files" }
M.g_snkkfs__["n___<L> kfa "] = my.ui.picker.snacks.keymaps.find_buffers_recent_files
M.g_snkkfs__["n___<L> kfc "] = my.ui.picker.snacks.keymaps.find_nvim_config_files
M.g_snkkfs__["n___<L> kfF "] = my.ui.picker.snacks.keymaps.find_files_pwdall
M.g_snkkfs__["n___<L> kff "] = my.ui.picker.snacks.keymaps.find_files_pwdnoall
M.g_snkkfs__["n___<L> kfr "] = my.ui.picker.snacks.keymaps.find_recent_files
M.g_snkkfs__["n___<L> kfR "] = my.ui.picker.snacks.keymaps.find_recent_files_pwd
M.g_snkkgit_["n___<L> kg "] = { wk_group = "Git" }
M.g_snkkgit_["n___<L> kgb "] = my.ui.picker.snacks.keymaps.find_git_branches
M.g_snkkgit_["n___<L> kgC "] = my.ui.picker.snacks.keymaps.find_git_commits_current_file
M.g_snkkgit_["n___<L> kgc "] = my.ui.picker.snacks.keymaps.find_git_commits_repository
M.g_snkkgit_["n___<L> kgf "] = my.ui.picker.snacks.keymaps.find_git_files
M.g_snkkgit_["n___<L> kgt "] = my.ui.picker.snacks.keymaps.find_git_status
M.g_snkkgit_["n___<L> kgz "] = my.ui.picker.snacks.keymaps.find_git_stash
M.g_snkknvim["n___<L> kh "] = my.ui.picker.snacks.keymaps.find_help
M.g_snkknvim["n___<L> kk "] = my.ui.picker.snacks.keymaps.find_keymaps
M.g_snkklsp_["n___<L> kl "] = { wk_group = "LSP" }
M.g_snkklsp_["n___<L> kld "] = my.ui.picker.snacks.keymaps.find_diagnostics
M.g_snkklsp_["n___<L> kls "] = my.ui.picker.snacks.keymaps.find_symbols
M.g_snkknvim["n___<L> km "] = my.ui.picker.snacks.keymaps.find_man
M.g_snkknvim["n___<L> kN "] = my.ui.picker.snacks.keymaps.find_notifications
M.g_snkknvim["n___<L> kp "] = my.ui.picker.snacks.keymaps.find_projects
M.g_snkkrg__["n___<L> kr "] = { wk_group = "gRep" }
M.g_snkkrg__["n___<L> krR "] = my.ui.picker.snacks.keymaps.find_ripgrep_pwdall
M.g_snkkrg__["n___<L> krr "] = my.ui.picker.snacks.keymaps.find_ripgrep_pwdnoall
M.g_snkkrg__["n___<L> krw "] = my.ui.picker.snacks.keymaps.find_word_under_cursor_pwd
M.g_rsession["n___<L> kS "] = my.ui.picker.snacks.keymaps.find_a_dirsession
M.g_rsession["n___<L> ks "] = my.ui.picker.snacks.keymaps.find_sessions
M.g_snkknvim["n___<L> kT "] = my.ui.picker.snacks.keymaps.find_themes
M.g_snkknvim["n___<L> ku "] = my.ui.picker.snacks.keymaps.find_undo_history
M.g_blinkcmp["!___<C> L "] = my.cmp.blink.keymaps.toggle_scroll_doc
M.b_minfiles["n___<_> l "] = my.fs.minifiles.keymaps.go_in
M.b_oil_____["n___<_> l "] = my.fs.oil.keymaps.select
M.g_core____["il__<A> L "] = my.motion.keymaps.last_line_i_
M.g_core____["nxo_<A> L "] = my.motion.keymaps.last_line_n_
M.g_core____["nxo_<_> L "] = my.motion.keymaps.right
M.g_nv_ts___["n___<C> L "] = my.syntax.ts.keymaps.init_selection
M.g_nv_ts___["x___<C> L "] = my.syntax.ts.keymaps.scope_incremental
M.g_core____["all_<A> l "] = my.win.keymaps.navigate_right
M.g_core____["nx__<L> l "] = { wk_group = "LSP actions" }
M.b_core_lsp["nx__<L> la "] = my.lsp.keymaps.code_action
M.b_core_lsp["n___<L> lA "] = my.lsp.keymaps.code_action_source_only
M.g_core____["n___<L> ld "] = my.lsp.keymaps.hover_diagnostics
M.b_core_lsp["n___<L> lf "] = my.lsp.keymaps.format_buffer_n_
M.b_core_lsp["x___<L> lf "] = my.lsp.keymaps.format_buffer_x_
M.b_core_lsp["n___<L> lG "] = my.lsp.keymaps.list_workspace_symbols
M.b_core_lsp["n___<L> lh "] = my.lsp.keymaps.signature_help
M.b_lspconfg["n___<L> li "] = my.lsp.lspconfig.keymaps.lsp_information
M.b_null_ls_["n___<L> lI "] = my.lsp.null_ls.keymaps.null_ls_information
M.b_core_lsp["n___<L> ll "] = my.lsp.keymaps.codelens_refresh
M.b_core_lsp["n___<L> lL "] = my.lsp.keymaps.codelens_run
M.b_core_lsp["n___<L> lR "] = my.lsp.keymaps.list_references
M.b_core_lsp["n___<L> lr "] = my.lsp.keymaps.rename_current_symbol
M.g_aerial__["n___<L> ls "] = my.ui.aerial.keymaps.symbols_outline
M.g_venvslct["n___<L> lv "] = my.ft.python.keymaps.select_virtualenv
M.g_core____["n___<L> m "] = { wk_group = "Move" }
M.g_core____["n___<L> m<TAB> "] = { wk_proxy = { km_group = M.g_core____, km_id = "n___<L> <TAB>m " } }
M.g_core____["n___<L> m<TAB><TAB> "] = my.tab.keymaps.move_alt
M.g_core____["n___<L> mw "] = { wk_proxy = { km_group = M.g_core____, km_id = "n___<L> wm " } }
M.g_blinkcmp["il__<C> N "] = my.cmp.blink.keymaps.cyctle_to_next_provider
M.g_core____["c___<C> N "] = my.cmp.keymaps.cmd_history_next
M.g_core____["all_<A> N "] = my.tab.keymaps.goto_last
M.g_core____["all_<A> n "] = my.tab.keymaps.goto_right
M.g_notes___["n___<L> n "] = { wk_group = "Notes/PKMS" }
M.g_notes___["n___<L> ne "] = my.pkms.keymaps.edit_note
M.g_notes___["n___<L> nlc "] = my.pkms.keymaps.add_ref_link_clipboard
M.g_notes___["n___<L> nll "] = my.pkms.keymaps.add_ref_link_input
M.g_core____["n___<L> O "] = my.cmp.keymaps.add_blank_line_above
M.g_leap____["all_<A> o "] = my.motion.leap.keymaps.jump_from_window
M.g_leap____["all_<A> O "] = my.motion.leap.keymaps.jump_omniwhere
M.b_md_nvim_["nx__<_> O "] = my.ft.markdown.keymaps.super_newline_above_n_
M.b_md_nvim_["nx__<_> o "] = my.ft.markdown.keymaps.super_newline_below_n_
M.g_core____["t___<C> o "] = my.term.keymaps.exec_single_normal_command
M.g_core____["n___<L> o "] = { wk_group = "Open ..." }
M.g_core____["n___<L> o<S-TAB> "] = my.tab.keymaps.open_new_left
M.g_core____["n___<L> o<TAB> "] = { wk_proxy = { km_group = M.g_core____, km_id = "n___<L> <TAB>o " } }
M.g_core____["n___<L> o<TAB><TAB> "] = my.tab.keymaps.open_new_right
M.g_core____["n___<L> oa "] = { wk_group = "Open AI chat" }
M.g_coco_ai_["nx__<L> oaa "] = my.ai.coco.keymaps.toggle_chat
M.g_coco_ai_["nx__<L> oan "] = my.ai.coco.keymaps.open_new_chat
M.g_coco_ai_["nx__<L> oaN "] = my.ai.coco.keymaps.open_new_chat_prompt
M.g_core____["n___<L> ob "] = my.buf.keymaps.enew
M.g_core____["n___<L> oE "] = my.term.keymaps.open_term_exec_cmd
M.g_core____["n___<L> oe "] = { wk_proxy = { km_group = M.g_core____, km_id = "n___<L> eo " } }
M.g_core____["n___<L> oee "] = my.term.keymaps.open_term_pwd
M.g_core____["n___<L> of "] = { wk_proxy = { km_group = M.g_core____, km_id = "n___<L> f " } }
M.g_core____["n___<L> og "] = { wk_proxy = { km_group = M.g_core____, km_id = "n___<L> go " } }
M.g_fugitive["n___<L> ogg "] = my.git.fugitive.keymaps.open_git_win_from_buf
M.g_core____["n___<L> oh "] = { wk_group = "Open nvim help" }
M.g_core____["n___<L> ohg "] = my.ft.nvim_help.keymaps.helpgrep
M.g_core____["n___<L> ohh "] = my.ft.nvim_help.keymaps.help
M.g_core____["n___<L> ol "] = my.win.keymaps.open_location_list
M.g_core____["n___<L> om "] = my.ft.manpage.keymaps.manpages
M.g_core____["n___<L> oo "] = my.cmp.keymaps.add_blank_line_below
M.g_core____["n___<L> oq "] = my.win.keymaps.open_quickfix_list
M.g_neotest_["n___<L> oT "] = my.testing.neotest.keymaps.output_pannel_toggle
M.g_neotest_["n___<L> ot "] = my.testing.neotest.keymaps.output_to_new_tab
M.g_core____["n___<L> ov "] = { wk_group = "preView" }
M.b_oil_____["n___<L> ovv "] = my.fs.oil.keymaps.preview
M.g_core____["n___<L> ow "] = { wk_proxy = { km_group = M.g_core____, km_id = "n___<L> wo " } }
M.g_blinkcmp["il__<C> P "] = my.cmp.blink.keymaps.cyctle_to_prev_provider
M.g_core____["c___<C> P "] = my.cmp.keymaps.cmd_history_prev
M.g_core____["all_<A> P "] = my.tab.keymaps.goto_first
M.g_core____["all_<A> p "] = my.tab.keymaps.goto_left
M.g_core____["n___<L> q "] = { wk_group = "Editor actions" }
M.g_core____["n___<L> qp "] = my.fs.cd.keymaps.active_cd
M.g_core____["n___<L> qP "] = my.fs.cd.keymaps.global_cd
M.g_core____["n___<L> qq "] = my.ws.keymaps.exit_with_confirm
M.g_core____["n___<L> qr "] = my.fs.cd.keymaps.active_cd_root
M.g_core____["n___<L> qR "] = my.fs.cd.keymaps.global_cd_root
M.g_core____["n___<L> qs "] = { wk_group = "Sessions" }
M.g_rsession["n___<L> qsd "] = my.ws.resession.keymaps.open_sessions_dir
M.g_rsession["n___<L> qsL "] = my.ui.picker.snacks.keymaps.find_a_dirsession
M.g_rsession["n___<L> qsl "] = my.ui.picker.snacks.keymaps.find_sessions
M.g_rsession["n___<L> qsS "] = my.ws.resession.keymaps.save_new_session
M.g_rsession["n___<L> qss "] = my.ws.resession.keymaps.save_current_session
M.g_rsession["n___<L> qsT "] = my.ws.resession.keymaps.save_new_tab_session
M.g_rsession["n___<L> qst "] = my.ws.resession.keymaps.save_current_tab_session
M.g_rsession["n___<L> qsX "] = my.ws.resession.keymaps.delete_a_dirsession
M.g_rsession["n___<L> qsx "] = my.ws.resession.keymaps.delete_a_session
M.g_core____["n___<L> qw "] = my.ws.keymaps.write_all
M.g_core____["n___<C> R "] = my.buf.keymaps.restore_line
M.g_leap____["all_<A> r "] = my.motion.keymaps.esc_and_remote_action
M.g_core____["nx__<L> r "] = { wk_group = "Run/Debug" }
M.g_core____["!___<C> r'' "] = my.ypxcd.keymaps.paste_unnamed_i_
M.g_core____["n___<C> r'' "] = my.ypxcd.keymaps.paste_unnamed_n_
M.g_core____["t___<C> r'' "] = my.ypxcd.keymaps.paste_unnamed_t_
M.g_core____["x___<C> r'' "] = my.ypxcd.keymaps.paste_unnamed_x_
M.g_core____["!___<C> r'c "] = my.ypxcd.keymaps.paste_clipboard_i_
M.g_core____["n___<C> r'c "] = my.ypxcd.keymaps.paste_clipboard_n_
M.g_core____["t___<C> r'c "] = my.ypxcd.keymaps.paste_clipboard_t_
M.g_core____["x___<C> r'c "] = my.ypxcd.keymaps.paste_clipboard_x_
M.g_core____["!___<C> r's "] = my.ypxcd.keymaps.paste_selection_i_
M.g_core____["n___<C> r's "] = my.ypxcd.keymaps.paste_selection_n_
M.g_core____["t___<C> r's "] = my.ypxcd.keymaps.paste_selection_t_
M.g_core____["x___<C> r's "] = my.ypxcd.keymaps.paste_selection_x_
M.g_dap_____["n___<L> rB "] = my.dap.keymaps.clear_breakpoints
M.g_dap_____["n___<L> rb "] = my.dap.keymaps.toggle_breakpoint
M.g_dap_____["n___<L> rC "] = my.dap.keymaps.conditional_breakpoint
M.g_dap_____["n___<L> rc "] = my.dap.keymaps.start_or_continue
M.g_dap_ui__["n___<L> rE "] = my.dap.ui.keymaps.evaluate_input_n_
M.g_dap_ui__["x___<L> rE "] = my.dap.ui.keymaps.evaluate_input_x_
M.g_dap_view["n___<L> rE "] = my.dap.view.keymaps.add_expression
M.g_dap_ui__["n___<L> rh "] = my.dap.ui.keymaps.debugger_hover
M.g_dap_____["n___<L> ri "] = my.dap.keymaps.step_into
M.g_dap_____["n___<L> rO "] = my.dap.keymaps.step_out
M.g_dap_____["n___<L> ro "] = my.dap.keymaps.step_over
M.g_dap_____["n___<L> rp "] = my.dap.keymaps.pause
M.g_dap_____["n___<L> rq "] = my.dap.keymaps.close_session
M.g_dap_____["n___<L> rQ "] = my.dap.keymaps.terminate_session
M.g_dap_____["n___<L> rr "] = my.dap.keymaps.restart
M.g_dap_____["n___<L> rR "] = my.dap.keymaps.toggle_repl
M.g_dap_____["n___<L> rs "] = my.dap.keymaps.run_to_cursor
M.g_dap_ui__["n___<L> ru "] = my.dap.ui.keymaps.toggle_debugger_ui
M.g_dap_view["n___<L> ru "] = my.dap.view.keymaps.toggle_debugger_view
M.g_surround["il__<A> s "] = my.cmp.surround.keymaps.add_i_
M.g_surround["il__<A> S "] = my.cmp.surround.keymaps.add_with_nl_i_
M.b_gitsigns["n___<_> s "] = my.git.gitsigns.keymaps.toggle_and_next_hunk
M.b_gitsigns["n___<_> S "] = my.git.gitsigns.keymaps.toggle_and_prev_hunk
M.b_gitsigns["x___<_> s "] = my.git.gitsigns.keymaps.toggle_hunk_visual
M.b_gitsigns["x___<_> S "] = my.git.gitsigns.keymaps.toggle_hunk_visual
M.g_core____["nxo_<L> s "] = { wk_group = "SSS" }
M.g_core____["n___<L> s<TAB> "] = { wk_proxy = { km_group = M.g_core____, km_id = "n___<L> <TAB>s " } }
M.g_core____["n___<L> s<TAB><TAB> "] = my.win.keymaps.split_to_tab_right
M.g_surround["n___<L> sa "] = my.cmp.surround.keymaps.add_n_
M.g_surround["n___<L> sA "] = my.cmp.surround.keymaps.add_with_nl
M.g_surround["x___<L> sa "] = my.cmp.surround.keymaps.add_x_
M.g_surround["nx__<L> sc "] = my.cmp.surround.keymaps.change
M.g_surround["nx__<L> sC "] = my.cmp.surround.keymaps.change_line
M.g_surround["nx__<L> sd "] = my.cmp.surround.keymaps.delete
M.g_leap____["nxo_<L> sF "] = my.motion.leap.keymaps.jump_backward_n_
M.g_leap____["nxo_<L> sf "] = my.motion.leap.keymaps.jump_forward_n_
M.g_leap____["nxo_<L> si "] = my.motion.leap.keymaps.jump_in_window_n_
M.g_surround["n___<L> sl "] = my.cmp.surround.keymaps.add_around_line
M.g_surround["n___<L> sL "] = my.cmp.surround.keymaps.add_around_line_with_nl
M.g_surround["x___<L> sl "] = my.cmp.surround.keymaps.add_with_nl_x_
M.b_md_nvim_["n___<L> smc "] = my.ft.markdown.keymaps.change_emphasis
M.b_md_nvim_["n___<L> smd "] = my.ft.markdown.keymaps.delete_emphasis
M.b_md_nvim_["n___<L> sml "] = my.ft.markdown.keymaps.toggle_emphasis_line
M.b_md_nvim_["n___<L> smm "] = my.ft.markdown.keymaps.toggle_emphasis_n_
M.b_md_nvim_["x___<L> smm "] = my.ft.markdown.keymaps.toggle_emphasis_x_
M.g_leap____["nxo_<L> so "] = my.motion.leap.keymaps.jump_from_window
M.g_leap____["nxo_<L> sO "] = my.motion.leap.keymaps.jump_omniwhere
M.g_leap____["nxo_<L> sr "] = my.motion.keymaps.esc_and_remote_action
M.g_leap____["nxo_<L> ss "] = my.motion.leap.keymaps.jump_in_window_n_
M.g_leap____["nxo_<L> sT "] = my.motion.leap.keymaps.jump_backward_till_n_
M.g_leap____["nxo_<L> st "] = my.motion.leap.keymaps.jump_forward_till_n_
M.g_core____["n___<L> sw "] = { wk_proxy = { km_group = M.g_core____, km_id = "n___<L> ws " } }
M.g_core____["n___<L> sww "] = my.win.keymaps.split_left_inner
M.g_core____["n___<L> t "] = { wk_group = "Test" }
M.g_neotest_["n___<L> t<CR> "] = my.testing.neotest.keymaps.toggle_summary
M.g_neotest_["n___<L> td "] = my.testing.neotest.keymaps.debug_test
M.g_neotest_["n___<L> tf "] = my.testing.neotest.keymaps.run_file_all
M.g_neotest_["n___<L> th "] = my.testing.neotest.keymaps.output_hover
M.g_neotest_["n___<L> tO "] = my.testing.neotest.keymaps.output_pannel_toggle
M.g_neotest_["n___<L> to "] = my.testing.neotest.keymaps.output_to_new_tab
M.g_neotest_["n___<L> tp "] = my.testing.neotest.keymaps.run_pwd_all
M.g_neotest_["n___<L> tt "] = my.testing.neotest.keymaps.run_test
M.g_neotest_["n___<L> twf "] = my.testing.neotest.keymaps.watch_toggle_file_all
M.g_neotest_["n___<L> twp "] = my.testing.neotest.keymaps.watch_toggle_pwd_all
M.g_neotest_["n___<L> twS "] = my.testing.neotest.keymaps.watch_stop_all
M.g_neotest_["n___<L> tww "] = my.testing.neotest.keymaps.watch_toggle
M.g_core____["n___<_> U "] = my.buf.keymaps.unundo
M.b_ufo_____["n___<C> U "] = my.win.ufo.keymaps.preview_win_scrollU
-- M.g_core____["n___<L> u "] = { wk_group = "UI/UX toggles" }
-- M.g_core____["n___<L> u> "] = my.config.toggles.foldcolumn
-- M.g_core____["n___<L> uA "] = my.config.toggles.auto_cd_root
-- M.g_aupairs_["n___<L> ua "] = my.config.toggles.autopairs
-- M.g_blinkcmp["n___<L> uc "] = my.config.toggles.cmp_buf
-- M.g_blinkcmp["n___<L> uC "] = my.config.toggles.cmp_global
-- M.g_core____["n___<L> ud "] = { wk_group = "Diagnostic toggles" }
-- M.g_core____["n___<L> udd "] = my.config.toggles.diagnostics_buf
-- M.g_core____["n___<L> udg "] = my.config.toggles.diagnostics_global
-- M.g_core____["n___<L> udl "] = my.config.toggles.virtual_lines
-- M.g_core____["n___<L> udv "] = my.config.toggles.virtual_text
-- M.g_core____["n___<L> uG "] = my.config.toggles.signcolumn
-- M.g_core____["n___<L> ug "] = { wk_group = "Git toggles" }
-- M.b_gitsigns["n___<L> ugb "] = my.git.gitsigns.keymaps.toggle_current_line_blame
-- M.b_gitsigns["n___<L> ugl "] = my.git.gitsigns.keymaps.toggle_linehl
-- M.b_gitsigns["n___<L> ugn "] = my.git.gitsigns.keymaps.toggle_numhl
-- M.b_gitsigns["n___<L> ugs "] = my.git.gitsigns.keymaps.toggle_signs
-- M.b_gitsigns["n___<L> ugw "] = my.git.gitsigns.keymaps.toggle_word_diff
-- M.g_core____["n___<L> uh "] = { wk_group = "hl toggles" }
-- M.g_illumint["n___<L> uhf "] = my.config.toggles.illuminate_buf_freeze
-- M.g_core____["n___<L> uhh "] = my.config.toggles.syntax_hl_full_buf
-- M.g_illumint["n___<L> uhi "] = my.config.toggles.illuminate_buf
-- M.g_illumint["n___<L> uhI "] = my.config.toggles.illuminate_global
-- M.g_core____["n___<L> uhl "] = my.config.toggles.syntax_hl_lsp_buf
-- M.g_core____["n___<L> uhr "] = my.config.toggles.syntax_hl_regex_buf
-- M.g_core____["n___<L> uht "] = my.config.toggles.syntax_hl_ts_buf
-- M.g_illumint["n___<L> uhv "] = my.config.toggles.illuminate_buf_visible
-- M.g_snkindnt["n___<L> ui "] = my.config.toggles.indent_buf
-- M.g_snkindnt["n___<L> uI "] = my.config.toggles.indent_global
-- M.g_core____["n___<L> ul "] = { wk_group = "LSP" }
-- M.g_core____["n___<L> ulf "] = my.config.toggles.lsp_format_buf
-- M.g_core____["n___<L> ulF "] = my.config.toggles.lsp_format_global
-- M.g_core____["n___<L> ulh "] = my.config.toggles.lsp_inlay_hint_buf
-- M.g_core____["n___<L> ulH "] = my.config.toggles.lsp_inlay_hint_global
-- M.g_core____["n___<L> ull "] = my.config.toggles.lsp_codelens_buf
-- M.g_core____["n___<L> ulL "] = my.config.toggles.lsp_codelens_global
-- M.g_core____["n___<L> uls "] = my.config.toggles.lsp_format_on_save_buf
-- M.g_core____["n___<L> ulS "] = my.config.toggles.lsp_format_on_save_global
-- M.g_core____["n___<L> uL "] = my.config.toggles.laststatus
-- M.g_core____["n___<L> uN "] = my.config.toggles.toggle_notify
-- M.g_core____["n___<L> un "] = { wk_group = "number toggles" }
-- M.g_core____["n___<L> unn "] = my.config.toggles.number
-- M.g_core____["n___<L> unr "] = my.config.toggles.relativenumber
-- M.g_core____["n___<L> uS "] = my.config.toggles.conceallevel
-- M.g_core____["n___<L> us "] = my.config.toggles.spell
-- M.g_core____["n___<L> ut "] = my.config.toggles.showtabline
-- M.g_core____["n___<L> uw "] = my.config.toggles.wrap
M.g_core____["all_<A> w "] = my.win.keymaps.switch_to_alternate
M.g_core____["n___<L> w "] = { wk_group = "window actions" }
M.b_ufo_____["n___<L> wff "] = my.win.ufo.keymaps.preview_win_switch
M.g_ufo_____["n___<L> wff "] = my.win.ufo.keymaps.preview_win_switch
M.g_ufo_____["n___<L> wfp "] = my.win.ufo.keymaps.peek_fold
M.b_ufo_____["n___<L> wft "] = my.win.ufo.keymaps.preview_win_trace
M.g_ufo_____["n___<L> wft "] = my.win.ufo.keymaps.preview_win_trace
M.g_core____["n___<L> wh "] = my.win.keymaps.navigate_left
M.g_core____["n___<L> wj "] = my.win.keymaps.navigate_down
M.g_core____["n___<L> wk "] = my.win.keymaps.navigate_up
M.g_core____["n___<L> wl "] = my.win.keymaps.navigate_right
M.g_core____["n___<L> wm "] = { wk_group = "Move window" }
M.g_core____["n___<L> wm<S-TAB> "] = my.win.keymaps.move_to_tab_previous
M.g_core____["n___<L> wm<TAB> "] = my.win.keymaps.move_to_tab_next
M.g_core____["n___<L> wmh "] = my.win.keymaps.move_left
M.g_core____["n___<L> wmH "] = my.win.keymaps.move_left
M.g_core____["n___<L> wmj "] = my.win.keymaps.move_down
M.g_core____["n___<L> wmJ "] = my.win.keymaps.move_down
M.g_core____["n___<L> wmk "] = my.win.keymaps.move_up
M.g_core____["n___<L> wmK "] = my.win.keymaps.move_up
M.g_core____["n___<L> wml "] = my.win.keymaps.move_right
M.g_core____["n___<L> wmL "] = my.win.keymaps.move_right
M.g_core____["n___<L> wo "] = { wk_group = "Open new window" }
M.g_core____["n___<L> woh "] = my.win.keymaps.open_new_left_inner
M.g_core____["n___<L> woH "] = my.win.keymaps.open_new_left_outer
M.g_core____["n___<L> woj "] = my.win.keymaps.open_new_down_inner
M.g_core____["n___<L> woJ "] = my.win.keymaps.open_new_down_outer
M.g_core____["n___<L> wok "] = my.win.keymaps.open_new_up_inner
M.g_core____["n___<L> woK "] = my.win.keymaps.open_new_up_outer
M.g_core____["n___<L> wol "] = my.win.keymaps.open_new_right_inner
M.g_core____["n___<L> woL "] = my.win.keymaps.open_new_right_outer
M.g_core____["n___<L> wp "] = my.fs.cd.keymaps.win_cd
M.g_core____["n___<L> wr "] = my.fs.cd.keymaps.win_cd_root
M.g_core____["n___<L> ws "] = { wk_group = "Split window" }
M.g_core____["n___<L> wsh "] = my.win.keymaps.split_left_inner
M.g_core____["n___<L> wsH "] = my.win.keymaps.split_left_outer
M.g_core____["n___<L> wsj "] = my.win.keymaps.split_down_inner
M.g_core____["n___<L> wsJ "] = my.win.keymaps.split_down_outer
M.g_core____["n___<L> wsk "] = my.win.keymaps.split_up_inner
M.g_core____["n___<L> wsK "] = my.win.keymaps.split_up_outer
M.g_core____["n___<L> wsl "] = my.win.keymaps.split_right_inner
M.g_core____["n___<L> wsL "] = my.win.keymaps.split_right_outer
M.g_core____["n___<L> wss "] = my.win.keymaps.split_left_inner
M.g_core____["n___<L> ww "] = my.win.keymaps.switch_to_alternate
M.g_core____["n___<L> wx "] = my.win.keymaps.close_current
M.g_core____["n___<L> wy "] = my.win.keymaps.sync_current_win
M.g_blinkcmp["!___<C> X "] = my.cmp.blink.keymaps.select_provider
M.g_core____["n___<L> X "] = my.tab.keymaps.close_current
M.g_core____["all_<A> X "] = my.tab.keymaps.close_current
M.g_core____["all_<A> x "] = my.win.keymaps.close_current
M.g_core____["n___<L> x "] = { wk_group = "close (eXit) ..." }
M.g_core____["n___<L> x<TAB> "] = my.tab.keymaps.close_current
M.g_core____["n___<L> xb "] = my.buf.keymaps.close_buf
M.b_ufo_____["n___<L> xf "] = my.win.ufo.keymaps.preview_win_close
M.g_ufo_____["n___<L> xf "] = my.win.ufo.keymaps.preview_win_close
M.g_core____["n___<L> xl "] = my.win.keymaps.close_location_list
M.g_snknotfy["n___<L> xn "] = my.notify.keymaps.dismiss_all
M.g_core____["n___<L> xq "] = my.win.keymaps.close_quickfix_list
M.g_core____["n___<L> xw "] = my.win.keymaps.close_current
M.g_core____["n___<L> xx "] = my.win.keymaps.close_current
M.b_ufo_____["n___<L> xx "] = my.win.ufo.keymaps.preview_win_close
M.g_blinkcmp["!___<C> Y "] = my.cmp.blink.keymaps.select_and_accept
M.b_ufo_____["n___<C> Y "] = my.win.ufo.keymaps.preview_win_scrollY
M.g_ufo_____["n___<_> zM "] = my.win.ufo.keymaps.closeAllFolds
M.g_ufo_____["n___<_> zm "] = my.win.ufo.keymaps.closeFoldsWith
M.g_ufo_____["n___<_> zR "] = my.win.ufo.keymaps.openAllFolds
M.g_ufo_____["n___<_> zr "] = my.win.ufo.keymaps.openFoldsExceptKinds
-- KEYMAPS END

return M
