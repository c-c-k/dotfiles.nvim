-- ====================
-- ASTRONVIM ASTROTHEME
-- ====================

-- repo url: <https://github.com/AstroNvim/astrotheme>
-- nvim help: `:help astrotheme`

---@type LazySpec
return {
  "AstroNvim/astrotheme",
  lazy = true,
  opts = {
    -- String of the default palette to use when calling `:colorscheme astrotheme`
    -- palette = "astrodark",
    -- :h background, palettes to use when using the core vim background colors
    -- background = {
    --   light = "astrolight",
    --   dark = "astrodark",
    -- },

    -- style = {
    --   -- Bool value, toggles transparency.
    --   transparent = false,        
    --   -- Bool value, toggles inactive window color.
    --   inactive = true,            
    --   -- Bool value, toggles floating windows background colors.
    --   float = true,               
    --   -- Bool value, toggles neo-trees background color.
    --   neotree = true,             
    --   -- Bool value, toggles borders.
    --   border = true,              
    --   -- Bool value, swaps text and background colors.
    --   title_invert = true,        
    --   -- Bool value, toggles italic comments.
    --   italic_comments = true,     
    --   -- Bool value, simplifies the amounts of colors used for syntax highlighting.
    --   simple_syntax_colors = true,
    -- },


    -- Bool value, toggles if termguicolors are set by AstroTheme.
    -- termguicolors = true,

    -- Bool value, toggles if terminal_colors are set by AstroTheme.
    -- terminal_color = true,

    -- Sets how all plugins will be loaded
    -- "auto": Uses lazy / packer enabled plugins to load highlights.
    -- true: Enables all plugins highlights.
    -- false: Disables all plugins.
    -- plugin_default = "auto",

    -- Allows for individual plugin overrides using plugin name and value from above.
    -- plugins = {             
    --   ["bufferline.nvim"] = false,
    -- },

    -- palettes = {
    --   -- Globally accessible palettes, theme palettes take priority.
    --   global = {            
    --     my_grey = "#ebebeb",
    --     my_color = "#ffffff"
    --   },
    --   -- Extend or modify astrodarks palette colors
    --   astrodark = {         
    --     ui = {
    --       -- Overrides astrodarks red UI color
    --       red = "#800010",
    --       -- Changes the accent color of astrodark.
    --       accent = "#CC83E3" 
    --     },
    --     syntax = {
    --       -- Overrides astrodarks cyan syntax color
    --       cyan = "#800010",
    --       -- Overrides astrodarks comment color.
    --       comments = "#CC83E3" 
    --     },
    --     -- Overrides global.my_color
    --     my_color = "#000000"
    --   },
    -- },

    -- highlights = {
    --   -- Add or modify hl groups globally, theme specific hl groups take priority.
    --   global = {            
    --     modify_hl_groups = function(hl, c)
    --       hl.PluginColor4 = {fg = c.my_grey, bg = c.none }
    --     end,
    --     ["@String"] = {fg = "#ff00ff", bg = "NONE"},
    --   },
    --   astrodark = {
    --     -- modify_hl_groups function allows you to modify hl groups,
    --     -- first parameter is the highlight table and the second parameter is the color palette table
    --     modify_hl_groups = function(hl, c)
    --       hl.Comment.fg = c.my_color
    --       hl.Comment.italic = true
    --     end,
    --     ["@String"] = {fg = "#ff00ff", bg = "NONE"},
    --   },
    -- },
  }
}
