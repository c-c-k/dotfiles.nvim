---@type LazyPluginSpec
local spec_nvim_dap = {
  "mfussenegger/nvim-dap",
}

---@type LazyPluginSpec
local spec_nvim_dap__astrocore = {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local astromaps = opts.mappings

    local maps, map = require("cck.utils.config").get_astrocore_mapper()

    map("n", "<LEADER>rb", { copy = { "n", "<Leader>db", source = astromaps } }) -- desc = "Toggle Breakpoint (F9)"
    map("n", "<LEADER>rB", { copy = { "n", "<Leader>dB", source = astromaps } }) -- desc = "Clear Breakpoints"
    map("n", "<LEADER>rc", { copy = { "n", "<Leader>dc", source = astromaps } }) -- desc = "Start/Continue (F5)"
    map("n", "<LEADER>rC", { copy = { "n", "<Leader>dC", source = astromaps } }) -- desc = "Conditional Breakpoint (S-F9)"
    map("n", "<LEADER>ri", { copy = { "n", "<Leader>di", source = astromaps } }) -- desc = "Step Into (F11)"
    map("n", "<LEADER>ro", { copy = { "n", "<Leader>do", source = astromaps } }) -- desc = "Step Over (F10)"
    map("n", "<LEADER>rO", { copy = { "n", "<Leader>dO", source = astromaps } }) -- desc = "Step Out (S-F11)"
    map("n", "<LEADER>rq", { copy = { "n", "<Leader>dq", source = astromaps } }) -- desc = "Close Session"
    map("n", "<LEADER>rQ", { copy = { "n", "<Leader>dQ", source = astromaps } }) -- desc = "Terminate Session (S-F5)"
    map("n", "<LEADER>rp", { copy = { "n", "<Leader>dp", source = astromaps } }) -- desc = "Pause (F6)"
    map("n", "<LEADER>rr", { copy = { "n", "<Leader>dr", source = astromaps } }) -- desc = "Restart (C-F5)"
    map("n", "<LEADER>rR", { copy = { "n", "<Leader>dR", source = astromaps } }) -- desc = "Toggle REPL"
    map("n", "<LEADER>rs", { copy = { "n", "<Leader>ds", source = astromaps } }) -- desc = "Run To Cursor"

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

---@type LazyPluginSpec
local spec_nvim_dap_ui = {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap" },
}

---@type LazyPluginSpec
local spec_nvim_dap_ui__astrocore = {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local astromaps = opts.mappings

    local maps, map = require("cck.utils.config").get_astrocore_mapper()

    map("n", "<LEADER>rE", { copy = { "n", "<Leader>dE", source = astromaps } }) -- desc = "Evaluate Input"
    map("v", "<LEADER>rE", { copy = { "v", "<Leader>dE", source = astromaps } }) -- desc = "Evaluate Input"
    map("n", "<LEADER>ru", { copy = { "n", "<Leader>du", source = astromaps } }) -- desc = "Toggle Debugger UI"
    map("n", "<LEADER>rh", { copy = { "n", "<Leader>dh", source = astromaps } }) -- desc = "Debugger Hover"

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

---@type LazyPluginSpec
local spec_nvim_dap_view = {
  "igorlfs/nvim-dap-view",
}

---@type LazyPluginSpec
local spec_nvim_dap_view__astrocore = {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    local astrocore = require "astrocore"

    local maps, map = require("cck.utils.config").get_astrocore_mapper()

    map("n", "<LEADER>rE", { function() require("dap-view").add_expr() end, desc = "Add expression" })
    map("n", "<LEADER>ru", { function() require("dap-view").toggle() end, desc = "Toggle Debugger UI" })

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

---@type LazyPluginSpec
local spec_nvim_dap_view__nvim_dap = {
  "mfussenegger/nvim-dap",
  dependencies = "igorlfs/nvim-dap-view",
  opts = function()
    local dap, dap_view = require "dap", require "dap-view"
    dap.listeners.after.event_initialized.dapview_config = function() dap_view.open() end
    -- dap.listeners.before.event_terminated.dapview_config = function() dap_view.close() end
    -- dap.listeners.before.event_exited.dapview_config = function() dap_view.close() end
  end,
}

spec_nvim_dap.specs = {
  spec_nvim_dap__astrocore,
}
spec_nvim_dap_ui.specs = {
  spec_nvim_dap_ui__astrocore,
}
spec_nvim_dap_view.specs = {
  spec_nvim_dap_view__astrocore,
  spec_nvim_dap_view__nvim_dap,
}

---@type LazyPluginSpec[]
return {
  spec_nvim_dap,
  spec_nvim_dap_ui,
  spec_nvim_dap_view,
}
