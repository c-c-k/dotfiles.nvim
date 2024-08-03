-- ===========================================================================
-- TELESCOPE FZF NATIVE
-- ===========================================================================
-- see: <https://github.com/nvim-telescope/telescope-fzf-native.nvim>

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
