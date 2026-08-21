local my = require "my"

---@alias kmlg MyKeymapKeymapsLoaderGroup

---@class MyKeymapLoaderGroups
local keymap_groups = {
  -- sort with `/-- KEYGROUPS START/+1,/-- KEYGROUPS END/-1sort /M.\w_/`
  -- KEYGROUPS START
  g_aerial__ = {}, ---@type kmlg # "stevearc/aerial.nvim"
  g_aupairs_ = {}, ---@type kmlg # "windwp/nvim-autopairs"
  g_blinkcmp = {}, ---@type kmlg # "saghen/blink.cmp"
  b_core____ = {}, ---@type kmlg # core NVIM buffer
  g_core____ = {}, ---@type kmlg # core NVIM global
  b_core_lsp = {}, ---@type kmlg # core NVIM LSP buffer
  b_core_ts_ = {}, ---@type kmlg # core NVIM Treesitter buffer
  g_dap_____ = {}, ---@type kmlg # "mfussenegger/nvim-dap"
  g_dap_ui__ = {}, ---@type kmlg # "rcarriga/nvim-dap-ui"
  g_dap_view = {}, ---@type kmlg # "igorlfs/nvim-dap-view"
  g_fugitive = {}, ---@type kmlg # "tpope/vim-fugitive"
  b_gitsigns = {}, ---@type kmlg # "lewis6991/gitsigns.nvim"
  g_illumint = {}, ---@type kmlg # "RRethy/vim-illuminate"
  g_leap____ = {}, ---@type kmlg # "ggandor/leap.nvim"
  b_lspconfg = {}, ---@type kmlg # "neovim/nvim-lspconfig"
  g_minfiles = {}, ---@type kmlg # "nvim-mini/mini.files"
  b_minfiles = {}, ---@type kmlg # "nvim-mini/mini.files"
  b_null_ls_ = {}, ---@type kmlg # "nvimtools/none-ls.nvim"
  g_nv_ts___ = {}, ---@type kmlg # "nvim-treesitter/nvim-treesitter"
  g_nv_ts_to = {}, ---@type kmlg # "nvim-treesitter/nvim-treesitter-textobjects"
  g_oil_____ = {}, ---@type kmlg # "stevearc/oil.nvim"
  b_oil_____ = {}, ---@type kmlg # "stevearc/oil.nvim"
  g_rsession = {}, ---@type kmlg # "stevearc/resession.nvim"
  g_snkindnt = {}, ---@type kmlg # "folke/snacks.nvim": indent
  g_snkkbuf_ = {}, ---@type kmlg # "folke/snacks.nvim": picker: buffers
  g_snkkfs__ = {}, ---@type kmlg # "folke/snacks.nvim": picker: files/filesystem
  g_snkkgit_ = {}, ---@type kmlg # "folke/snacks.nvim": picker: git
  g_snkklsp_ = {}, ---@type kmlg # "folke/snacks.nvim": picker: LSP
  g_snkknvim = {}, ---@type kmlg # "folke/snacks.nvim": picker: NVIM stuff
  g_snkkrg__ = {}, ---@type kmlg # "folke/snacks.nvim": picker: RipGrep
  g_snknotfy = {}, ---@type kmlg # "folke/snacks.nvim": notifications
  g_surround = {}, ---@type kmlg # "kylechui/nvim-surround"
  g_ufo_____ = {}, ---@type kmlg # "kevinhwang91/nvim-ufo"
  b_ufo_____ = {}, ---@type kmlg # "kevinhwang91/nvim-ufo"
  g_venvslct = {}, ---@type kmlg # "linux-cultist/venv-selector.nvim"
  g_wkey____ = {}, ---@type kmlg # "folke/which-key.nvim"
  -- KEYGROUPS END
}

my.config.keymaps = keymap_groups
require "my.setup.__keymaps"
