-- ========================
-- ASTRONVIM ASTROCOMMUNITY
-- ========================

-- repo url: <https://github.com/AstroNvim/astrocommunity>
-- nvim help: ``

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python" },
  -- import/override with your plugins folder
}
