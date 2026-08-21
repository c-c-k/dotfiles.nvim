---@class MySyntax
---@field illuminate MySyntaxIlluminate
---@field indent MySyntaxIndent
---@field nvim_ts MySyntaxNvimTS
---@field regex MySyntaxRegex
---@field ts MySyntaxTS
---@field ts_textobj MySyntaxTreesitterTextobjects
local M = {}
M.init = { no_init = true, recurse = true } ---@type MyModuleInit

local my = require "my"

function M.syntax_hl_is_enabled_buf() -- Check if buffer treesitter highlighting is on.
  return (my.syntax.ts.syntax_hl_is_enabled_buf() or my.syntax.regex.syntax_hl_is_enabled_buf())
    and my.lsp.semantic_hl_is_enabled_buf()
end

--- Toggle buffer treessitter highlighting.
---@param enable boolean # if false turns highlighting off.
function M.syntax_hl_toggle_buf(enable)
  if not pcall(my.syntax.ts.syntax_hl_toggle_buf, enable) then my.syntax.regex.syntax_hl_toggle_buf(enable) end
  my.lsp.semantic_hl_toggle_buf(enable)
end

M.autocmds = {}
M.autocmds.autostart_syntax_hl = function() --
  local group = my.autocmd.get_augroup("my.syntax.autostart_syntax_hl", true)
  my.autocmd.add_autocmd {
    desc = "Autostart syntax highlighting and related features",
    group = group,
    event = "FileType",
    callback = function(args)
      local buf_id = args.buf
      local start_regex = my.config.syntax_autostart_regex_filetype_buf[buf_id]
      local start_ts = my.config.syntax_autostart_ts_filetype_buf[buf_id]
      local use_ts_indent = my.config.syntax_use_ts_indent_filetype_buf[buf_id]

      if start_ts == nil or start_ts then --
        local ok = pcall(vim.treesitter.start, buf_id)
        if ok then --
          my.keymap.load_km_group(my.config.keymaps.b_core_ts_, { buffer = buf_id })
        end
      end

      if use_ts_indent then --
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end

      my.syntax.regex.syntax_hl_toggle_buf(start_regex, buf_id)
    end,
  }
end
return M
