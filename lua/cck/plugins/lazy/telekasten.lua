-- ==========
-- TELEKASTEN
-- ==========

-- repo url: <https://github.com/renerocksai/telekasten.nvim>
-- nvim help: `:help telekasten.nvim`

return {
  'renerocksai/telekasten.nvim',
  -- == PLUGIN DISABLED ==
  -- This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one.
  -- It is temporarily disabled until it passed manual inspection to check that it has been converted correctly.
  enabled = false,
  opts = {
    -- alignment placeholder
  },
  config = function(_, opts)      
    require("telekasten").setup({
      -- Main paths
      home = vim.fn.expand("$NOTEBOOKS_TEST_NB_ROOT/telekasten/vault_1"),        -- path to main notes folder
      dailies = "diary/daily",       -- path to daily notes
      weeklies = "diary/weekly",      -- path to weekly notes
      templates = "templates/notes",   -- path to templates
    
      -- Specific note templates
        -- set to `nil` or do not specify if you do not want a template
      template_new_note = 'templates/notes/basenote.md',    -- template for new notes
      template_new_daily = 'templates/notes/daily.md',   -- template for new daily notes
      template_new_weekly = 'templates/notes/weekly.md',  -- template for new weekly notes
    
      -- Image subdir for pasting
        -- subdir name
        -- or nil if pasted images shouldn't go into a special subdir
      image_subdir = "img",
    
      -- File extension for note files
      extension    = ".md",
    
      -- file type overrides
      take_over_my_home = true,
      auto_set_filetype = true,
      auto_set_syntax = true,
    
      -- Generate note filenames. One of:
        -- "title" (default) - Use title if supplied, uuid otherwise
        -- "uuid" - Use uuid
        -- "uuid-title" - Prefix title by uuid
        -- "title-uuid" - Suffix title with uuid
      new_note_filename = "title",
      -- file uuid type ("rand" or input for os.date such as "%Y%m%d%H%M")
      -- uuid_type = "%Y%m%d%H%M",
      uuid_type = "%s",
      -- UUID separator
      uuid_sep = "-",
      filename_space_subst = "_",
    
      -- Flags for creating non-existing notes
      follow_creates_nonexisting = true,    -- create non-existing on follow
      dailies_create_nonexisting = true,    -- create non-existing dailies
      weeklies_create_nonexisting = true,   -- create non-existing weeklies
    
      -- template usage options
      -- 'smart': auto select note/daily/weekly
      -- 'prefer_new_note': use the new note template.
      -- 'always_ask': always ask for a template via template picker.
      template_handling = "smart",
    
      -- path for new notes, options: 'smart', 'prefer_home', 'same_as_current'
      new_note_location = "smart",
    
      -- Image link style",
        -- wiki:     ![[image name]]
        -- markdown: ![](image_subdir/xxxxx.png)
      image_link_style = "wiki",
    
      -- Default sort option: 'filename', 'modified'
      sort = "filename",
    
      -- Make syntax available to markdown buffers and telescope previewers
      install_syntax = true,
    
      -- Tag notation: '#tag', '@tag', ':tag:', 'yaml-bare'
      tag_notation = "yaml-bare",
    
      -- When linking to a note in subdir/, create a [[subdir/title]] link
      -- instead of a [[title only]] link
      subdirs_in_links = true,
    
      -- automaticaly rename all links after file rename
      rename_update_links = true,
    
      -- Command palette theme: dropdown (window) or ivy (bottom panel)
      command_palette_theme = "ivy",
    
      -- Tag list theme:
        -- get_cursor (small tag list at cursor)
        -- dropdown (window)
        -- ivy (bottom panel)
      show_tags_theme = "ivy",
    
      -- Previewer for media files (images mostly)
        -- "telescope-media-files" if you have telescope-media-files.nvim installed
        -- "catimg-previewer" if you have catimg installed
        -- "viu-previewer" if you have viu installed
      media_previewer = "telescope-media-files",
    
      -- custom url handler, when nil `xdg-open` or `open` are used
      -- Example: `"call jobstart('firefox --new-window {{url}}')"`
      follow_url_fallback = nil,
    
      -- picker options
      insert_after_inserting = true,
      close_after_yanking = true,
    
      -- Calendar integration
      plug_into_calendar = true,         -- use calendar integration
      calendar_opts = {
        weeknm = 4,                      -- calendar week display mode:
                                         --   1 .. 'WK01'
                                         --   2 .. 'WK 1'
                                         --   3 .. 'KW01'
                                         --   4 .. 'KW 1'
                                         --   5 .. '1'
    
        calendar_monday = 0,             -- use monday as first day of week:
                                         --   1 .. true
                                         --   0 .. false
    
        calendar_mark = 'left-fit',      -- calendar mark placement
                                         -- where to put mark for marked days:
                                         --   'left'
                                         --   'right'
                                         --   'left-fit'
      },
    
      vaults = {
        vault_2 = {
          home = vim.fn.expand("$NOTEBOOKS_TEST_NB_ROOT/telekasten/vault_2"),
        },
      },
    
    })
    
  end,
}
