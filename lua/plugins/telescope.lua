-- =========
-- TELESCOPE
-- =========

-- repo url: <https://github.com/nvim-telescope/telescope.nvim>
-- nvim help: ``

-- == PLUGIN DISABLED ==
-- MEMO: This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one and requires a manual inspection to check that it has been converted correctly.
-- MEMO: This plugin is part of the AstroNvim core defaults and needs to be adjusted accordingly.
if true then return {} end

return {
  'nvim-telescope/telescope.nvim',
  opts = {
    -- alignment placeholder
  },
  config = function(_, opts)      
    require('telescope').setup({
      defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        -- ..
      },
      pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
      },
      extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
      }
    })
  end,
}
