-- ===========================================================================
-- 
-- ===========================================================================

-- repo url: <>
-- nvim help: `:help `

-- == PLUGIN DISABLED ==
-- MEMO: This is a new plugin config file that needs to be double-checked before enabling.
if true then return {} end

return {
  {
    '_plugin_id_placeholder_',
    opts = {
      -- yank/paste alignment placeholder
    },
    config = function(_, opts)      
      -- yank/paste alignment placeholder
    end,
  },
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local astrocore = require "astrocore"
      local g = {}
      local maps = astrocore.empty_map_table()
      local map, mapf = require('cck.utils.config').get_astrocore_mapper(maps)

      opts.autocmds = astrocore.extend_tbl(opts.autocmds, {
        placeholder_augroup = {
          {
            event = { "placeholder_event" },
            pattern = "placeholder_pattern",
            desc = "placeholder description",
            callback = function(args)
              local maps = astrocore.empty_map_table()
              local map, mapf = require('cck.utils.config').get_astrocore_mapper(maps)

              map("n", "<LEADER>", "", { desc = "" } )

              astrocore.set_mappings(maps, { buffer = args.data.buf_id })
            end,
          }
        }
      })
      map("n", "<LEADER>", "", { desc = "" } )

      g.placeholder = {}

      opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
      opts.options.g = astrocore.extend_tbl(opts.options.g, g )
    end,
  }
}
