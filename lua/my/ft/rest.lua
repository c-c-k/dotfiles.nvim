---@class my.ft.rest
local M = {}

M.a0_init = function()
  -- NOTE:MEMO: NVIM has newer and better integrated REST plugins than
  --            "vim-rest-console", install them when NVIM REST client
  --            functionality is needed.
end

M.opts = {}

M.opts.vim_rest_console_init = function()
  if true then error "vim-rest-console should be disabled" end
  -- vim.g['vrc_trigger'] =  '<LEADER>ue'
  vim.g["vrc_set_default_mapping"] = 0
  -- the following option allows to use key=value pairs instead of query
  -- parameters, it can/should be set on a buffer level.
  vim.g["vrc_split_request_body"] = 1
end

return M
