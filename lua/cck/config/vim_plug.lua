local source = require("cck.utils.config").source

local plug_config_dir = "cck/plugins/vim_plug"

-- Plugins configurations that should be set before the plugins themselves are loaded

local pre_plug_configs = {
  "ale.vim",
  -- "jedi-vim.vim",
  "ycm.vim",
  "ultisnips.vim",
  "supertab.vim",
  "vim-rest-console.vim",
  -- "vim-wiki.vim",
  -- "vim-zettel.vim",
}

-- Plugins configurations that should be set after the plugins themselves are loaded

local post_plug_configs = {
  "copilotchat-nvim.lua",
  "copilot-vim.lua",
  "fzf.vim",
  "fzf-vim.vim",
  "lsp-examples.vim",
  "nerdtree.vim",
  -- "notational-fzf-vim.vim",
  "riv-vim.vim",
  "tabular.vim",
  "vim-airline.vim",
  -- "vim-markdown.vim",
  "plenary.lua",
  "nvim-web-devicons.lua",
  "nvim-treesitter.lua",
  -- "nvim-solarized-lua.lua",
  "base16-nvim.lua",
  "mkdnflow-nvim.lua",
  -- "nvim-cmp.lua",
  -- "telescope.lua",
  -- "telescope-fzf-native.lua",
  -- "telekasten.lua",
  -- "obsidian-nvim.lua",
}

-- Load plugins and their configurations in proper order using the vim-plug plugin manager

for _, file_name in ipairs(pre_plug_configs) do
  source(string.format("%s/%s", plug_config_dir, file_name))
end

source("cck/config/vim_plug_load.vim")

for _, file_name in ipairs(post_plug_configs) do
  source(string.format("%s/%s", plug_config_dir, file_name))
end
