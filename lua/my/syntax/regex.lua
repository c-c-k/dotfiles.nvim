local my = require "my"
---@class my.syntax.regex
local M = {}

M.a0_init = function()
  local au_setups = my.g.core_setup_autocmds
  au_setups[#au_setups + 1] = M.autocmds.setup_vars
end

function M.syntax_hl_is_enabled_buf() --
  return vim.bo.syntax ~= "off"
end

--- Toggle buffer regex syntax highlighting.
---@param enable boolean # if false turns highlighting off.
function M.syntax_hl_toggle_buf(enable)
  if enable then
    vim.bo.syntax = my.b.syntax_prev or "on"
    my.b.syntax_prev = nil
  else
    my.b.syntax_prev = vim.bo.syntax ~= "off" and vim.bo.syntax or nil
    vim.bo.syntax = "off"
  end
end

M.autocmds = {}
M.autocmds.setup_vars = function() --
  local group = my.autocmd.get_augroup("my.syntax.regex.vars", true)
  my.autocmd.add_autocmd {
    desc = "Apply syntax regex var on buf enter",
    group = group,
    event = "BufEnter",
    callback = function(args)
      local bufnr = args.buf
      local pvalue = my.bp[bufnr].syntax:get_top()
      if vim.bo[bufnr].syntax ~= pvalue then vim.bo[bufnr].syntax = pvalue end
    end,
  }
  my.autocmd.add_autocmd {
    desc = "Apply syntax regex var on var changes",
    group = group,
    event = "User",
    pattern = "MyVarModified",
    callback = function(args)
      if args.data.var_name == "syntax" then
        -- local handles = args.data.handle and { args.data.handle } or vim.api.nvim_list_bufs()
        -- for _, handle in ipairs(handles) do
        --   local pvalue = my.bp[handle].syntax:get_top()
        --   if vim.bo[handle].syntax ~= pvalue then vim.bo[handle].syntax = pvalue end
        -- end
        my.vars.apply_pvar_to_handles {
          handles = args.data.handle or vim.api.nvim_list_bufs,
          p_scope = args.data.scope,
          var_name = args.data.var_name,
          on_func = var_funcs[1],
          off_func = var_funcs[2],
        }
      end
    end,
  }
end
return M
