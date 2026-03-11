---@meta _
error "Cannot require a meta file"

---@class my.autocmd.add_autocmd.opts: vim.api.keyset.create_autocmd
---@field event string | string[]
---@field group integer | string | [string, boolean?]
