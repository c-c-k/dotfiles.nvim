---@meta _
error "Cannot require a meta file"

---@alias my.tbl.merge.flags.supported
---| "dDE" # Deep dict merge, error on conflict, can return nil.
---| "dDF" # Deep dict merge, replace on conflict, can return nil.
---| "dDK" # Deep dict merge, keep on conflict, can return nil.
---| "dDEn" # Deep dict merge, error on conflict, always return table.
---| "dDFn" # Deep dict merge, replace on conflict, always return table.
---| "dDKn" # Deep dict merge, keep on conflict, always return table.
---| "lu" # Unique list merge, can return nil.
---| "lun" # Unique list merge, always return table.

---@class my.tbl.merge.flags.as_opts
---@field dict boolean
---@field deep boolean
---@field error boolean
---@field force boolean
---@field keep boolean
---@field list boolean
---@field unique boolean
---@field allow_nil_return boolean
