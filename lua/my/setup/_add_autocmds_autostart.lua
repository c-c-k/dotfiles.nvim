local my = require "my"

for name, func in pairs(my.lsp.autocmds) do
  if type(func) == "function" and string.match(name, "^lsp_attach") then func() end
end

my.syntax.autocmds.autostart_syntax_hl()
