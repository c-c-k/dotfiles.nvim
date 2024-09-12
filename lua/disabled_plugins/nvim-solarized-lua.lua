-- =================
-- VIM-SOLARIZED-LUA
-- =================

-- repo url: <https://github.com/ishan9299/nvim-solarized-lua>
-- nvim help: ``

return {
  'c-c-k/forks-nvim-solarized-lua',
  -- == PLUGIN DISABLED ==
  -- Switched to base16-nvim
  enabled = false,
  name = 'nvim-solarized-lua',
  branch = 'personal_customization',
  lazy = false,
  priority = 1000,
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
