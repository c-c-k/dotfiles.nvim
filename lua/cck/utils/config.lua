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

--- Retrieves a mapper function for AstroNvim v4.0 style key mappings.
-- 
-- This function returns two mapping functions, `map` and `mapf`.
-- 
-- * `map` replaces `<leader>` in the `lhs` of the mapping with `vim.g.usermapleader`. It is designed for most user key mappings.
-- * `mapf` leaves the `lhs` unchanged, allowing the use of the actual `<leader>`. It is intended for special cases where the actual leader key is needed.
-- 
-- @param maps An AstroNvim map table, typically initialized with `require("astrocore").empty_map_table()`.
-- @return `map`, `mapf` The two mapping functions.
function M.get_astrocore_mapper(maps)

  -- Helper function to replace <leader> (case-insensitive) with usermapleader
function M.has(feat) return vim.fn.has(feat) == 1 end
  local function replace_lhs_leader(lhs)
    -- Check if usermapleader is defined
    if vim.g.usermapleader == nil then
      error("Error: usermapleader is not defined. Please define it in your init.lua before loading plugin configurations.")
    end

    -- Check if usermapleader and mapleader are the same
    if vim.g.usermapleader == vim.g.mapleader then
      vim.notify("Warning: usermapleader and mapleader have the same value. This may lead to conflicts with AstroNvim's default mappings.", vim.log.levels.WARN)
    end

    return lhs:gsub("<[Ll][Ee][Aa][Dd][Ee][Rr]>", vim.g.usermapleader) 
  end

  -- Helper function to handle the actual mapping logic
  local function map_backend(modes, lhs, sub_lhs, rhs, options)
    if type(rhs) == "table" then
        options = rhs
        rhs = nil
    else
        options = options or {}
    end

    if sub_lhs then
      lhs = replace_lhs_leader(lhs)
    end

    -- Handle the 'copy' option if present
    if options.copy then
      local copy_mode, copy_lhs = unpack(options.copy)
      if sub_lhs then
        copy_lhs = replace_lhs_leader(copy_lhs)
      end

      if maps[copy_mode] and maps[copy_mode][copy_lhs] then
        -- Copy and overwrite (if necessary) the existing mapping's options
        options = vim.tbl_deep_extend("force", maps[copy_mode][copy_lhs], options)
      else
        vim.notify("Warning: Mapping to copy not found: " .. copy_mode .. " " .. copy_lhs, vim.log.levels.WARN)
        options = { desc = "ERROR" } -- Indicate an error in the mapping
      end

      -- Remove the 'copy' key from options
      options.copy = nil
    end

    if rhs then
        -- table.insert(options, 1, rhs)
        options[1] = rhs
    end
    
    if type(modes) == "string" then
        maps[modes][lhs] = options
    else
      for _, mode in ipairs(modes) do
          maps[mode][lhs] = options
      end
    end
  end

  --- Maps key sequences to actions, replacing `<leader>` with `usermapleader`.
  --
  -- @param modes A string or table of modes to map in.
  -- @param lhs The left-hand side of the mapping (key sequence). `<leader>` will be replaced with `usermapleader`.
  -- @param rhs The right-hand side of the mapping (action to execute).
  -- @param options (Optional) A table of options for the mapping. Can include a `copy` key with the value `{ "<MODE>", "<LHS>" }` to copy an existing mapping's options.
  local function map(modes, lhs, rhs, options)
    map_backend(modes, lhs, true, rhs, options)
  end

  --- Maps key sequences to actions, preserving `<leader>`.
  --
  -- @param modes A string or table of modes to map in.
  -- @param lhs The left-hand side of the mapping (key sequence). `<leader>` will be preserved.
  -- @param rhs The right-hand side of the mapping (action to execute).
  -- @param options (Optional) A table of options for the mapping. Can include a `copy` key with the value `{ "<MODE>", "<LHS>" }` to copy an existing mapping's options.
  local function mapf(modes, lhs, rhs, options)
    map_backend(modes, lhs, false, rhs, options)
  end

  return map, mapf
end

return M
