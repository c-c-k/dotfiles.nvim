-- == PLUGIN DISABLED ==
-- MEMO: This is a new plugin config file that needs to be double-checked before enabling.
if true then return {} end

---@type LazyPluginSpec
local spec_plugin_name = {
  "PLUGIN",
  -- opts = {
  --   -- yank/paste alignment placeholder
  -- },
  opts = function(_, opts)
    local astrocore = require "astrocore"
    return astrocore.extend_tbl(opts, {
      -- yank/paste alignment placeholder
    })
  end,
  -- config = function(plugin, opts)
  --   -- require("PLUGIN").setup(opts)
  --   require("astronvim.plugins.configs.PLUGIN")(plugin, opts)
  --
  --   -- ...
  -- end,
}

---@type LazyPluginSpec
local spec_plugin_name__astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local g = {}
    local maps, map = require("cck.core.keymaps").get_astrocore_mapper()

    opts.autocmds = astrocore.extend_tbl(opts.autocmds, {
      placeholder_augroup = {
        {
          event = { "placeholder_event" },
          pattern = "placeholder_pattern",
          desc = "placeholder description",
          callback = function(args)
            -- selene: allow(shadowing)
            ---@diagnostic disable-next-line: redefined-local
            local maps, map = require("cck.core.keymaps").get_astrocore_mapper()

            map("n", "<LEADER>", "", { desc = "" })

            astrocore.set_mappings(maps, { buffer = args.data.buf_id })
          end,
        },
      },
    })
    map("n", "<LEADER>", "", { desc = "" })

    g.placeholder = {}

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
    opts.options.g = astrocore.extend_tbl(opts.options.g, g)
  end,
}

spec_plugin_name.specs = {
  spec_plugin_name__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_plugin_name,
}
