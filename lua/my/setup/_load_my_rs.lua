local my = require "my"

local cargo_target_root = vim.env.NVIM_CARGO_TARGET_DIR
local my_cpath = vim.fs.joinpath(cargo_target_root, "lib?.so;")

package.cpath = my_cpath .. package.cpath

local ok, result = pcall(require, "my_rs")
if not ok then
  local msg = string.format("Failed to load my_rs: %s", result)
  error(msg)
end

my.rs = result
