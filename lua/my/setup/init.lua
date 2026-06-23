local my = require "my"

---@class my.setup: my.setup._submodules
---@overload fun(opts: my.setup.setup_opts_spec) # MEMO: If changing the setup signature also update it in `my.setup.setup`
local M = setmetatable({}, {
  __call = function(...) return require "my.setup._setup"(...) end,
  __apply_lazy_module_loader = true,
})

function M.setup_core_autocmds() --
  local core_setup_autocmds = my.g.core_setup_autocmds
  my.g.core_setup_autocmds = nil
  for _, core_setup_func in ipairs(core_setup_autocmds) do
    vim.validate("core_setup_func", core_setup_func, "callable")
    core_setup_func()
  end
end

return M
