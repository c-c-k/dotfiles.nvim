local M = {}

--- Deeply merges two tables, combining values recursively.
-- If both tables have the same key and the value is a table, this function will merge those tables recursively.
-- If the values are not tables, the value from the second table will overwrite the value in the first table.
-- @param t1 The first table.
-- @param t2 The second table.
-- @return The merged table.
function M.deepMerge(t1, t2)
  local t3 = {}

  for k, v in pairs(t1) do
    t3[k] = v
  end

  for k, v in pairs(t2) do
    if type(v) == "table" then
      if type(t3[k]) == "table" then
        t3[k] = M.deepMerge(t3[k], v) -- Recursive merge
      else
        t3[k] = v
      end
    else
      t3[k] = v -- Overwrite with t2's value
    end
  end

  return t3
end

--- Deeply updates a table with values from another table.
-- This function is similar to `deepMerge`, but it modifies the first table in place.
-- @param t1 The table to be updated.
-- @param t2 The table containing values to update with.
-- @return The updated table.
function M.deepUpdate(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" and type(t1[k]) == "table" then
      M.deepUpdate(t1[k], v)  -- Recursive update
    else
      t1[k] = v  -- Overwrite with t2's value
    end
  end
  return t1
end

return M
