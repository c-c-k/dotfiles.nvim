---@type LazyPluginSpec
local spec_astrolsp = {
  "AstroNvim/astrolsp",
  opts = { servers = { "gdscript" } },
}

---@type LazyPluginSpec
local spec_nvim_treesitter = {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    if opts.ensure_installed ~= "all" then
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "gdscript", "glsl", "godot_resource" })
    end
  end,
}

---@type LazyPluginSpec
local spec_nvim_dap = {
  "mfussenegger/nvim-dap",
  opts = function(_, _)
    local dap = require "dap"
    dap.adapters.godot = {
      type = "server",
      host = "127.0.0.1",
      port = vim.env.GDScript_Debug_Port or 6006,
    }
    dap.configurations.gdscript = {
      {
        type = "godot",
        request = "launch",
        name = "Launch scene",
        project = "${workspaceFolder}",
        launch_scene = true,
      },
    }
  end,
}

---@type LazyPluginSpec[]
return {
  spec_astrolsp,
  spec_nvim_treesitter,
  spec_nvim_dap,
}
