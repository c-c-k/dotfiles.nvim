-- =================
-- VIM-SOLARIZED-LUA
-- =================

-- repo url: <https://github.com/ishan9299/nvim-solarized-lua>
-- nvim help: ``

return {
  'ishan9299/nvim-solarized-lua',
  -- == PLUGIN DISABLED ==
  -- This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one.
  -- It is temporarily disabled until it passed manual inspection to check that it has been converted correctly.
  enabled = false,
  opts = {
    -- alignment placeholder
  },
  config = function(_, opts)      
    
    vim.g.solarized_italics = 1
    
    -- visibility SpecialChars (like trailing whitespace and tabs) visibility
    -- low/normal/high
    vim.g.solarized_visibility = 'normal'
    
    -- diffmode low/normal/high
    vim.g.solarized_diffmode = 'normal'
    
    -- termtrans If you want to keep the transparency in your terminal (default: disabled)
    -- To enable transparency
    if vim.fn.has('gui_running') == 0 then
        vim.g.solarized_termtrans = 1
    else
        vim.g.solarized_termtrans = 1
    end
    
    -- statusline low/flat/normal
    vim.g.solarized_statusline = 'normal'
    
    vim.cmd.colorscheme("solarized")
  end,
}
