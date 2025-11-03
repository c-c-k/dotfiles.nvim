-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazyPluginSpec
local spec_astrocommunity = {
  "AstroNvim/astrocommunity",
  -- import/override with your plugins folder
}

---@type LazyPluginSpec[]
return {
  spec_astrocommunity,
}
