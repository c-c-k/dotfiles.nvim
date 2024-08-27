-- ===============
-- NVIM TREESITTER
-- ===============

-- repo url: <https://github.com/nvim-treesitter/nvim-treesitter>
-- nvim help: `:help nvim-treesitter`

return {
  'nvim-treesitter/nvim-treesitter',
  -- == PLUGIN DISABLED ==
  -- This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one.
  -- It is temporarily disabled until it passed manual inspection to check that it has been converted correctly.
  enabled = false,
  opts = {
    -- alignment placeholder
  },
  config = function(_, opts)      
    -- vim.opt.runtimepath:append("~/.local/share/nvim/nvim-treesitter")
    
    require("nvim-treesitter.configs").setup({
      -- A directory to install the parsers into.
      -- If this is excluded or nil parsers are installed
      -- to either the package dir, or the "site" dir.
      -- If a custom path is used (not nil) it must be added to the runtimepath.
      -- parser_install_dir = "~/.local/share/nvim/nvim-treesitter",
    
      -- A list of parser names, or "all"
      ensure_installed = { "bash", "c", "lua", "markdown", "markdown_inline", "query", "vim", "vimdoc",  },
    
      -- Install parsers synchronously (only applied to `ensure_installed`)
      -- sync_install = false,
    
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed loally
      auto_install = true,
    
      -- List of parsers to ignore installing (for "all")
      -- ignore_install = { "javascript" },
    
      -- If you need to change the installation directory of the parsers (see -> Advanced Setup)
      -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
      -- parser_install_dir = "/some/path/to/store/parsers",
    
      highlight = {
        -- `false` will disable the whole extension
        enable = true,
    
        -- list of language that will be disabled
        --- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        -- disable = { "c", "rust" },
        disable = function(lang, buf)
            local max_filesize = 1 * 1024 * 1024 -- 1 MB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = { "markdown" },
        -- additional_vim_regex_highlighting = true,
      },
    
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-k>", -- normal mode
          node_incremental = "<C-k>", -- visual mode
          scope_incremental = "<C-l>", -- visual mode
          node_decremental = "<C-j>", -- visual mode
        },
      },
    
      indent = {
        enable = true
      },
    })
  end,
}
