-- This supposedly makes nvim load faster see `:help vim.loader`
if vim.loader then
	vim.loader.enable()
end

local source = require("cck.utils.config").source

-- Load sub-configuration files

local sub_conf_files = {
  "cck/config/globals.lua", -- user defined Global variables
  "cck/config/options.lua", -- user defined Options
  -- "cck/config/vim_plug.lua", -- load plugins and their configurations using the vim-plug plugin manager
  "cck/config/autocommands.vim", -- user defined autocommands
  "cck/config/autocommands.lua", -- user defined autocommands
  "cck/config/commands.lua", -- user defined commands
  "cck/config/keymaps.lua", -- user defined global key mappings
}

for _, file_name in ipairs(sub_conf_files) do
  source(file_name)
end
