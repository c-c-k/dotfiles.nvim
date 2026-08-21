---@class MySetupUtils
---@field config MySetupUtilsConfig
local M = {}

-- NOTE(MEMO): `my.setup.utils` is accessed from `my` so it can't require it directly.
local my ---@type My
my = setmetatable({}, {
  __index = function(_, key)
    local _my = require "my"
    my = _my
    return _my[key]
  end,
})

---@class MyInitLists
M.blank_init_lists = {
  core = {}, ---@type fun() | fun()[]
  filetypes = {}, ---@type fun() | fun()[]
  plugins = {}, ---@type fun() | fun()[]
  workspaces = {}, ---@type fun() | fun()[]
}

---@class MyModuleInit: MyInitLists
---@field recurse boolean?
---@field no_init boolean?

function M.collect_inits(base_dir_path, base_module_prefix)
  local init_lists = my.config.setup_init_lists
  for fname, ftype in vim.iter(vim.fs.dir(base_dir_path)) do
    ---@cast fname string
    ---@cast ftype string

    if
      fname:sub(1, 1) ~= "_"
      and (
        (ftype == "directory" and vim.uv.fs_stat(vim.fs.joinpath(base_dir_path, fname, "init.lua")))
        or (ftype == "file" and fname:find ".lua$" and fname ~= "init.lua")
      )
    then
      local module_name = string.format("%s.%s", base_module_prefix, fname:gsub(".lua$", ""))

      local valid_module, result = pcall(require, module_name)
      if not valid_module then
        local _msg = string.format("Failed to load initialization module \"%s\": %s", vim.fs.joinpath(base_dir_path, fname), result)
        error(_msg)
      end
      local module = result

      local module_init = rawget(module, "init") ---@type MyModuleInit
      if type(module_init) ~= "table" then
        local _msg = string.format("missing initialization for module: %s", vim.fs.joinpath(base_dir_path, fname))
        error(_msg)
      end

      local did_init = false

      if module_init.no_init then
        did_init = true
      else
        for group, global_group_inits in pairs(init_lists) do
          local module_group_inits = module_init[group]
          if module_group_inits then
            if type(module_group_inits) ~= "table" then module_group_inits = { module_group_inits } end
            for _, init_func in ipairs(module_group_inits) do
              vim.validate("init func", init_func, "function")
              global_group_inits[#global_group_inits + 1] = init_func
              did_init = true
            end
          end
        end
      end

      if not did_init then
        local _msg = string.format("invalid initialization for module: %s", vim.fs.joinpath(base_dir_path, fname))
        error(_msg)
      end

      if module_init.recurse and ftype == "directory" then
        M.collect_inits(vim.fs.joinpath(base_dir_path, fname), module_name)
      end
    end
  end
end

--- A placeholder for a table or a function that has been consumed
--- and should not be used again.
---@param var_name string
---@return unknown
function M.removed_after_use(var_name)
  local err_fn = function() error(string.format("`%s` has been removed after use", var_name), 2) end
  return setmetatable({}, {
    __call = err_fn,
    __index = err_fn,
    __newindex = err_fn,
  })
end

--- A placeholder for a table or a function that is initialized at a later point
--- in the configuration than it's declaration.
---@param var_name string
---@return unknown
function M.requires_init(var_name)
  local err_fn = function() error(string.format("`%s` used before initialized", var_name), 2) end
  return setmetatable({}, {
    __call = err_fn,
    __index = err_fn,
    __newindex = err_fn,
  })
end

--- Runs a list of setup functions
---@param name string
---@param funcs_list unknown
function M.run_funcs_list(name, funcs_list)
  vim.validate(name, funcs_list, "table")
  ---@cast funcs_list function[]
  for _, func in ipairs(funcs_list) do
    vim.validate(string.format("%s in %s", vim.inspect(func), name), func, "function")
    func()
  end
end

return M
