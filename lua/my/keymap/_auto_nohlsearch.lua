local my = require "my"

local hls_keep_keys = vim.iter(my.g.hlsearch_keep_keys):fold({}, function(acc, key)
  acc[key] = true
  return acc
end)
local hls_auto_off_modes = vim.iter(my.g.hlsearch_auto_off_modes):fold({}, function(acc, key)
  acc[key] = true
  return acc
end)
local mid_auto_nohls = false

local function auto_nohlsearch_via_cmd(key, _)
  -- if mid_auto_nohls then return end
  if hls_auto_off_modes[vim.fn.keytrans(vim.fn.mode())] and not hls_keep_keys[vim.fn.keytrans(key)] then
    vim.cmd "nohlsearch"
  end
  -- vim.schedule(function() mid_auto_nohls = false end)
end

-- Disabled in favor of `auto_nohlsearch_via_cmd`.
-- TODO: Remove?
-- selene: allow(unused_variable)
---@diagnostic disable-next-line: unused-local, unused-function
local function auto_nohlsearch_via_opt(key, _)
  if mid_auto_nohls then return end
  local new_hlsearch
  if vim.fn.mode() == "n" then
    -- enable highlight search when actively searching in normal mode
    new_hlsearch = hls_keep_keys[vim.fn.keytrans(key)] or false
  elseif vim.fn.mode() == "R" then
    -- always enable highlight search in replace mode
    new_hlsearch = true
  elseif vim.fn.mode() == "c" and vim.fn.keytrans(key) == "<CR>" then
    -- enable highlight search when searching in command mode
    local cmd = vim.fn.getcmdline()
    if (cmd:match "^s" or cmd:match "^%%s" or cmd:match "^'<,'>s") and vim.o.incsearch then new_hlsearch = true end
  else
    return
  end
  -- vim.print(vim.fn.keytrans(key), hlsearch_keep_keys_set[vim.fn.keytrans(key)], new_hlsearch, vim.o.hlsearch)
  if vim.o.hlsearch ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
  mid_auto_nohls = true
  vim.schedule(function() mid_auto_nohls = false end)
end

vim.on_key(auto_nohlsearch_via_cmd, vim.api.nvim_create_namespace "auto_nohlsearch", {})
