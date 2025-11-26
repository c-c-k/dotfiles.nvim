---@type LazyPluginSpec
local spec_snacks_nvim = {
  "folke/snacks.nvim",
  ---@param opts snacks.Config
  opts = function(_, opts)
    opts["dashboard"] = nil
    local astrocore = require "astrocore"
    return astrocore.extend_tbl(opts, {
      -- PLACEHOLDER
    })
  end,
}

---@type LazyPluginSpec
local spec_snacks_nvim__astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local my = require "my"
    local astrocore = require "astrocore"
    local astromaps = opts.mappings
    local maps, map = my.keymap.get_astrocore_mapper()

    -- Snacks.indent mappings
    map("n", "<LEADER>u|", { copy = { "n", "<Leader>u|", source = astromaps } }) -- desc = "Toggle indent guides"

    -- Snacks.notifier mappings
    map("n", "<LEADER>uD", { copy = { "n", "<Leader>uD", source = astromaps } }) -- desc = "Dismiss notifications"

    -- Snacks.picker
    -- find buffer/in buffer
    map("n", "<LEADER>fb", { desc = "buffer(s)" })
    map("n", "<LEADER>fbb", { copy = { "n", "<Leader>fb", source = astromaps } }) -- desc = "Find buffers"
    map("n", "<LEADER>fbl", { copy = { "n", "<Leader>fl", source = astromaps }, desc = "Find lines in buffer" })

    -- find nvim stuff
    map("n", "<LEADER>f<CR>", { copy = { "n", "<Leader>f<CR>", source = astromaps } }) -- desc = "Resume previous search"
    map("n", "<LEADER>f'", { copy = { "n", "<Leader>f'", source = astromaps } }) -- desc = "Find marks"
    map("n", '<LEADER>f"', { copy = { "n", "<Leader>fr", source = astromaps } }) -- desc = "Find registers"
    map("n", "<LEADER>fc", { copy = { "n", "<Leader>fC", source = astromaps } }) -- desc = "Find commands"
    map("n", "<LEADER>fu", { copy = { "n", "<Leader>fu", source = astromaps } }) -- desc = "Find undo history"
    map("n", "<LEADER>fh", { copy = { "n", "<Leader>fh", source = astromaps } }) -- desc = "Find help"
    map("n", "<LEADER>fk", { copy = { "n", "<Leader>fk", source = astromaps } }) -- desc = "Find keymaps"
    map("n", "<LEADER>fm", { copy = { "n", "<Leader>fm", source = astromaps } }) -- desc = "Find man"
    map("n", "<LEADER>fN", { copy = { "n", "<Leader>fn", source = astromaps } }) -- desc = "Find notifications"
    map("n", "<LEADER>fT", { copy = { "n", "<Leader>ft", source = astromaps } }) -- desc = "Find themes"
    map("n", "<LEADER>fp", { copy = { "n", "<Leader>fp", source = astromaps } }) -- desc = "Find projects"

    -- find files
    map("n", "<LEADER>ff", { desc = "Find files" })
    map("n", "<LEADER>ffa", {
      copy = { "n", "<Leader>fs", source = astromaps },
      desc = "Find all (buffers/recent/files)",
    })
    map("n", "<LEADER>ffc", { copy = { "n", "<Leader>fa", source = astromaps }, desc = "Find nvim config files" })
    map("n", "<LEADER>ffh", { copy = { "n", "<Leader>fo", source = astromaps }, desc = "Find recent files" })
    map("n", "<LEADER>ffH", { copy = { "n", "<Leader>fO", source = astromaps }, desc = "Find recent files (PWD)" })
    map("n", "<LEADER>ffr", { copy = { "n", "<LEADER>ffh" } })
    map("n", "<LEADER>ffR", { copy = { "n", "<LEADER>ffH" } })
    map("n", "<LEADER>fff", { copy = { "n", "<Leader>ff", source = astromaps }, desc = "Find files (PWD-noall)" })
    map("n", "<LEADER>ffF", { copy = { "n", "<Leader>fF", source = astromaps }, desc = "Find files (PWD-all)" })

    -- find git stuff
    if vim.fn.executable "git" == 1 then
      map("n", "<LEADER>fg", { desc = "Git" })
      map("n", "<LEADER>fgb", { copy = { "n", "<Leader>gb", source = astromaps } }) -- desc = "Git branches"
      map("n", "<LEADER>fgc", { copy = { "n", "<Leader>gc", source = astromaps } }) -- desc = "Git commits (repository)"
      map("n", "<LEADER>fgC", { copy = { "n", "<Leader>gC", source = astromaps } }) -- desc = "Git commits (current file)"
      map("n", "<LEADER>fgt", { copy = { "n", "<Leader>gt", source = astromaps } }) -- desc = "Git status"
      map("n", "<LEADER>fgz", { copy = { "n", "<Leader>gT", source = astromaps } }) -- desc = "Git stash"
    end
    map("n", "<LEADER>fgf", { copy = { "n", "<Leader>fg", source = astromaps } }) -- desc = "Find git files"

    -- find grep
    map("n", "<LEADER>fr", { desc = "gRep" })
    map("n", "<LEADER>frw", {
      copy = { "n", "<Leader>fc", source = astromaps },
      desc = "Find word under cursor (PWD)",
    })
    if vim.fn.executable "rg" == 1 then
      map("n", "<LEADER>frr", { copy = { "n", "<Leader>fw", source = astromaps }, desc = "Ripgrep (PWD-noall)" })
      map("n", "<LEADER>frg", { copy = { "n", "<LEADER>frr" } })
      map("n", "<LEADER>frR", { copy = { "n", "<Leader>fW", source = astromaps }, desc = "Ripgrep (PWD-all)" })
      map("n", "<LEADER>frG", { copy = { "n", "<LEADER>frR" } })
    end

    -- find lsp
    map("n", "<LEADER>fl", { desc = "lsp" })
    map("n", "<LEADER>fld", { copy = { "n", "<Leader>lD", source = astromaps } }) -- desc = "Search diagnostics"
    map("n", "<LEADER>fls", { copy = { "n", "<Leader>ls", source = astromaps } }) -- desc = "Search symbols"

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

spec_snacks_nvim.specs = {
  spec_snacks_nvim__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_snacks_nvim,
}
