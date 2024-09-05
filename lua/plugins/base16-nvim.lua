-- ===========
-- NVIM-BASE16
-- ===========

-- repo url: <https://github.com/RRethy/base16-nvim>
-- nvim help: `:help base16`

return {
  'RRethy/base16-nvim',
  lazy = false,
  priority = 1000,
  config = function(_, opts)      
    -- You can provide a table specifying your colors to the setup function.
    require('base16-colorscheme').setup()
    -- require('base16-colorscheme').setup({
    --     base00 = '#16161D', base01 = '#2c313c', base02 = '#3e4451', base03 = '#6c7891',
    --     base04 = '#565c64', base05 = '#abb2bf', base06 = '#9a9bb3', base07 = '#c5c8e6',
    --     base08 = '#e06c75', base09 = '#d19a66', base0A = '#e5c07b', base0B = '#98c379',
    --     base0C = '#56b6c2', base0D = '#0184bc', base0E = '#c678dd', base0F = '#a06949',
    -- })
    
    -- To disable highlights for supported plugin(s), call the `with_config`
    -- function **before** setting the colorscheme. These are the defaults.
    -- require('base16-colorscheme').with_config({
    --     telescope = true,
    --     indentblankline = true,
    --     notify = true,
    --     ts_rainbow = true,
    --     cmp = true,
    --     illuminate = true,
    --     dapui = true,
    -- })
    
    vim.cmd.colorscheme("base16-solarized-dark")
  end,
}
