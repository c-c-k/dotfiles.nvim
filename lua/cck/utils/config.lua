local M = {}

--- Sources a file depending on its extension.
-- Supports both '.vim' and '.lua' files.
-- For '.vim' files, it uses the standard Neovim source command, ensuring they're sourced from the correct directory within your configuration.
-- For '.lua' files, it clears the module cache and requires the module.
-- @param path The path to the file to source.
function M.source(path)
  if vim.endswith(path, '.vim') then
    -- Source VimL files from the user's config directory
    vim.cmd("source " .. vim.fn.stdpath("config") .. "/viml/" .. path)
  elseif vim.endswith(path, '.lua') then
    -- Reload Lua modules to ensure changes take effect
    local module_name = path:gsub("%.lua$", "")
    package.loaded[module_name] = nil
    require(module_name)
  else
    error("Error: Unsupported file type for sourcing: " .. path)
  end
end

--- Checks if a feature is available in Neovim.
-- This is a wrapper around vim.fn.has() that returns a boolean value.
-- @param feat The feature to check for.
-- @return `true` if the feature is available, `false` otherwise.
function M.has(feat)
  return vim.fn.has(feat) == 1
end

return M
