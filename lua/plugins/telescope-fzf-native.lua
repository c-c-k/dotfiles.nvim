-- ====================
-- TELESCOPE FZF NATIVE
-- ====================

-- repo url: <https://github.com/nvim-telescope/telescope-fzf-native.nvim>
-- nvim help: ``

return {
  'nvim-telescope/telescope-fzf-native.nvim',
  -- == PLUGIN DISABLED ==
  -- MEMO: This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one and requires a manual inspection to check that it has been converted correctly.
  -- TODO: Switch fzf for telescope
  enabled = false,
  opts = {
    -- alignment placeholder
  },
  config = function(_, opts)      
    -- NOTE: this should possibly be done in the telescope config file
    -- You dont need to set any of these options. These are the default ones. Only
    -- the loading is important
    -- require('telescope').setup({
    --   extensions = {
    --     fzf = {
    --       fuzzy = true,                    -- false will only do exact matching
    --       override_generic_sorter = true,  -- override the generic sorter
    --       override_file_sorter = true,     -- override the file sorter
    --       case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    --                                        -- the default case_mode is "smart_case"
    --     }
    --   }
    -- })
    
    -- To get fzf loaded and working with telescope, you need to call
    -- load_extension, somewhere after setup function:
    require('telescope').load_extension('fzf')
  end,
}
