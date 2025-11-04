-- ================
-- VIM-REST-CONSOLE
-- ================

-- repo url: <https://github.com/diepm/vim-rest-console>
-- nvim help: `:help vim-rest-console`

---@type LazyPluginSpec
local spec_vim_rest_console = {
  "diepm/vim-rest-console",
  init = function()
    -- vim.g['vrc_trigger'] =  '<LEADER>ue'
    vim.g["vrc_set_default_mapping"] = 0
    -- the following option allows to use key=value pairs instead of query
    -- parameters, it can/should be set on a buffer level.
    vim.g["vrc_split_request_body"] = 1
  end,
}

---@type LazyPluginSpec[]
return {
  spec_vim_rest_console,
}
