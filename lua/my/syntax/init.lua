local my = require "my"
---@class my.syntax: my.syntax._submodules
local M = {}

function M.syntax_hl_is_enabled_buf() -- Check if buffer treesitter highlighting is on.
  return (my.syntax.regex.syntax_hl_is_enabled_buf() or my.syntax.ts.syntax_hl_is_enabled_buf())
    and my.lsp.semantic_hl_is_enabled_buf()
end

--- Toggle buffer treessitter highlighting.
---@param enable boolean # if false turns highlighting off.
function M.syntax_hl_toggle_buf(enable)
  if my.syntax.ts.buf_has_parser() then
    my.syntax.ts.syntax_hl_toggle_buf(enable)
  else
    my.syntax.regex.syntax_hl_toggle_buf(enable)
  end
  my.lsp.semantic_hl_toggle_buf(enable)
end

return M
