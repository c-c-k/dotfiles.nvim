---@meta _
--# selene: allow(unused_variable)
---@diagnostic disable: unused-local
error "Cannot require a meta file"

---@class my.lsp.format_buf.opts: vim.lsp.buf.format.Opts
---@field silence_format_disabled? boolean

---@class my.lsp.lsp_attach_args: vim.api.keyset.create_autocmd.callback_args
---@field data { client_id: integer }
