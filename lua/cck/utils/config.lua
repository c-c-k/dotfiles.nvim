local M = {}

--- Sources a file depending on its extension.
-- Supports both '.vim' and '.lua' files.
-- For '.vim' files, it uses the standard Neovim source command, ensuring they're sourced from the correct directory within your configuration.
-- For '.lua' files, it clears the module cache and requires the module.
-- @param path The path to the file to source.
function M.source(path)
  if vim.endswith(path, ".vim") then
    -- Source VimL files from the user's config directory
    vim.cmd("source " .. vim.fn.stdpath "config" .. "/viml/" .. path)
  elseif vim.endswith(path, ".lua") then
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
function M.has(feat) return vim.fn.has(feat) == 1 end

--- Generates a keymapping table and a mapping function for AstroNvim v4.0
-- The mapping function handles:
--   - Replacing `<leader>` with `vim.g.usermapleader` (if `uleader` is not explicitly set to false).
--   - Copying mappings from existing tables (using the `copy` option).
-- @return table: The initialized mappings table
-- @return function: The mapping function
function M.get_astrocore_mapper()
  local astrocore = require "astrocore"
  local maps = astrocore.empty_map_table() -- Initialize the mappings table
  local astromaps = astrocore.config.mappings -- AstroNvim's default mappings

  --- Replaces '<leader>' with 'vim.g.usermapleader' in the LHS of a keymapping
  -- Also performs checks to ensure 'usermapleader' is defined and doesn't conflict with 'mapleader'
  -- @param lhs string: The left-hand side of the keymapping
  -- @return string: The modified LHS with '<leader>' replaced
  local function replace_lhs_leader(lhs)
    if vim.g.usermapleader == nil then
      error "Error: usermapleader is not defined. Please define it in your init.lua before loading plugin configurations."
    end

    if vim.g.usermapleader == vim.g.mapleader then
      vim.notify(
        "Warning: usermapleader and mapleader have the same value. This may lead to conflicts with AstroNvim's default mappings.",
        vim.log.levels.WARN
      )
    end

    return lhs:gsub("<[Ll][Ee][Aa][Dd][Ee][Rr]>", vim.g.usermapleader)
  end

  --- Copies a keymapping from an existing table (either 'maps' or 'astromaps')
  -- Handles leader replacement and extends the copied options with any provided options
  -- @param options table: The options table containing copy instructions
  -- @return table: The extended options table
  local function copy_map(options)
    local mode, lhs = unpack(options.copy, 1, 2) -- Extract mode and lhs from copy table
    local use_astro = options.copy.astro -- Whether to copy from AstroNvim's mappings
    local uleader = options.uleader -- uleader setting from the main options
    local copy_uleader = options.copy.uleader -- uleader setting from the copy options
    local source_maps = use_astro and astromaps or maps -- Determine the source mappings table

    -- Logic for leader replacement in copied mappings
    local replace_leader = copy_uleader or (copy_uleader == nil and not (use_astro or uleader == false))
    if replace_leader then lhs = replace_lhs_leader(lhs) end

    if source_maps[mode] and source_maps[mode][lhs] then
      -- Copy and extend options if the mapping exists in the source table
      return astrocore.extend_tbl(source_maps[mode][lhs], options)
    else
      -- Notify if the mapping to copy is not found
      vim.notify('Warning: Mapping to copy not found: "' .. mode .. '","' .. lhs .. '"', vim.log.levels.WARN)
      return { desc = "ERROR" } -- Return an error options table
    end
  end

  --- Cleans up the options table by removing 'uleader' and 'copy' keys
  -- @param options table: The options table to clean up
  local function cleanup(options)
    options.uleader = nil
    options.copy = nil
  end

  --- Defines a keymapping
  -- Handles leader replacement, copying mappings, and setting up the final options table
  -- @param modes string|table: The mode(s) for the mapping
  -- @param lhs string: The left-hand side of the mapping
  -- @param rhs any: The right-hand side of the mapping (optional)
  -- @param options table: Additional options for the mapping (optional)
  local function map(modes, lhs, rhs, options)
    -- Handle missing rhs and options, or rhs being a table (treated as options)
    if rhs == nil and options == nil then
      vim.notify("Warning: mapping '" .. lhs .. "' is missing both `rhs` and `options` parameters", vim.log.levels.WARN)
      return
    elseif type(rhs) == "table" then
      options = rhs
      rhs = nil
    else
      options = options or {}
    end

    -- Replace leader in LHS if uleader is not explicitly false
    if options.uleader ~= false then lhs = replace_lhs_leader(lhs) end

    -- Copy mapping if the 'copy' option is present
    if options.copy then options = copy_map(options) end

    -- Set the rhs as the first item in the options table
    if rhs ~= nil then options[1] = rhs end

    -- Remove uleader and copy keys
    cleanup(options)

    -- Add the mapping to the 'maps' table for the specified mode(s)
    if type(modes) == "string" then
      maps[modes][lhs] = options
    else
      for _, mode in ipairs(modes) do
        maps[mode][lhs] = options
      end
    end
  end

  return maps, map
end

return M
