local my = require "my"
---@class my.keymap._mapper
local M = {}

---@type table<my.keymap.mode_slugs, my.keymap.modes[]>
local MODE_SLUG_MODES = {
  ["n___"] = { "n" },
  ["i___"] = { "i" },
  ["c___"] = { "c" },
  ["x___"] = { "x" },
  ["s___"] = { "s" },
  ["o___"] = { "o" },
  ["t___"] = { "t" },
  ["l___"] = { "l" },
  ["nx__"] = { "n", "x" },
  ["nxo_"] = { "n", "x", "o" },
  ["nv__"] = { "n", "x", "s" }, -- { "n", "v" }
  ["____"] = { "n", "x", "s", "o" }, -- { "" }
  ["v___"] = { "x", "s" }, -- { "v" }
  ["xo__"] = { "x", "o" },
  ["!___"] = { "i", "c" }, -- { "!" }
  ["it__"] = { "i", "t" },
  ["il__"] = { "i", "l" },
  ["!t__"] = { "i", "c", "t" }, -- { "!", "t" }
  ["!l__"] = { "i", "c", "l" }, -- { "!", "l" }
  ["!tl_"] = { "i", "c", "t", "l" }, -- { "!", "t", "l" }
  ["itl_"] = { "i", "t", "l" },
  ["all_"] = { "n", "i", "c", "x", "s", "o", "t", "l" }, -- { "", "!", "t", "l" }
}

local km_groups_load_queue = {}
local did_load_queued_km_groups = false

--- TODO: description
---@param ctx my.keymap.loader_ctx?
local function _normalize_ctx_buffer(ctx)
  if not ctx then return end
  local bufnr = ctx.buffer
  local args = ctx.args
  if args and args.buf then
    if bufnr == nil and bufnr == true then
      bufnr = args.buf
    elseif bufnr ~= args.buf then
      local msg = ("discrepancy between `ctx.buffer` and `ctx.args.buf`\n%s"):format(vim.inspect(ctx))
      my.notify.warn(msg, { title = "Keymap set" })
    end
  elseif bufnr == true then
    bufnr = vim.api.nvim_get_current_buf()
  end
end

--- TODO: description
---@param km_id string
local function _get_mode_and_lhs_from_id(km_id)
  local mode_slug = km_id:sub(1, 4)
  local modifier = km_id:sub(5, 7)
  local lhs = km_id:sub(9, -2)

  if modifier == "<L>" then
    lhs = "<LEADER>" .. lhs
  elseif modifier == "<A>" or modifier == "<C>" then
    modifier = modifier:sub(1, 2) .. "-"
    if lhs:find "^<%a.*>.*" then
      lhs = modifier .. lhs:sub(2)
    else
      lhs = modifier .. lhs:sub(1, 1) .. ">" .. lhs:sub(2)
    end
  elseif modifier ~= "<_>" then
    local msg = ('invalid modifier " %s " in keymap id "%s"'):format(modifier, km_id)
    my.notify.error(msg, { title = "keymap set" })
    lhs = modifier .. lhs
    -- else (modifier == "<_>") do nothing (no LHS modifier)
  end

  return MODE_SLUG_MODES[mode_slug], lhs
end
--- TODO: description
---@param km_spec my.keymap.keymap_spec_full
local function _set_whichkey_group_mapping(km_spec)
  require("which-key").add { km_spec.lhs, mode = km_spec.mode, group = km_spec.wk_group }
end

--- TODO: description
---@param km_spec my.keymap.keymap_spec_full
local function _set_whichkey_proxy_mapping(km_spec)
  local src_km_group = km_spec.wk_proxy.km_group
  local src_km_id = km_spec.wk_proxy.km_id
  local src_spec = src_km_group[src_km_id]
  if not src_spec then
    local msg = ("missing src spec for wk_proxy in.\n%s"):format(vim.inspect(km_spec))
    return my.notify.warn(msg, { title = "Keymap set" })
  end
  local _, src_lhs = _get_mode_and_lhs_from_id(src_km_id)
  require("which-key").add { km_spec.lhs, mode = km_spec.mode, proxy = src_lhs, group = src_spec.wk_group }
end

--- TODO: description
---@param km_spec my.keymap.keymap_spec_full
---@param bufnr integer?
local function _set_normal_mapping(km_spec, bufnr)
  vim.keymap.set(km_spec.mode, km_spec.lhs, km_spec.rhs, {
    nowait = km_spec.nowait,
    silent = km_spec.silent,
    script = km_spec.script,
    expr = km_spec.expr,
    unique = km_spec.unique,
    desc = km_spec.desc,
    buffer = bufnr,
    replace_keycodes = km_spec.replace_keycodes,
    remap = km_spec.remap,
    noremap = km_spec.noremap,
  })
end

--- TODO: description
---@param km_id string
---@param km_spec my.keymap.keymap_spec
---@param ctx my.keymap.loader_ctx?
local function _set(km_id, km_spec, ctx)
  -- NOTE: Currently buffer mappings are only intended to be set
  --       via a buffer km_group but this is not a final decision.
  --       The following is a runtime reminder about this.
  if km_spec.buffer ~= nil then
    local msg = ("MEMO: km_spec.buffer not currently supportet.\n%s\n%s"):format(km_id, vim.inspect(km_spec))
    my.notify.warn(msg, { title = "Keymap set" })
  end
  -- NOTE: MEMO: Decided not to do dedicated super mappings.
  --       Rationale: While super mappings feel cool they also tend
  --       to misbehave, do the wrong thing in edge cases that are
  --       frequent enough to become annoying, as such it seems better
  --       to apply them on a case specific basis and think twice if they
  --       are really necessary in those cases too.

  local bufnr, args
  if ctx then
    bufnr, args = ctx.buffer, ctx.args
    ---@cast bufnr integer? # should be normalized in `M.load_km_group`
  end
  if km_spec.cond and not km_spec.cond(bufnr, args) then return end

  ---@cast km_spec my.keymap.keymap_spec_full
  km_spec = vim.deepcopy(km_spec, false)
  km_spec.mode, km_spec.lhs = _get_mode_and_lhs_from_id(km_id)

  if km_spec.rhs then
    _set_normal_mapping(km_spec, bufnr)
  elseif km_spec.wk_group then
    _set_whichkey_group_mapping(km_spec)
  elseif km_spec.wk_proxy then
    _set_whichkey_proxy_mapping(km_spec)
  elseif false and "toggle" then
  -- TODO: Toggle
  else
    local msg = ("invalid keymap spec.\n%s\n%s"):format(km_id, vim.inspect(km_spec))
    my.notify.warn(msg, { title = "Keymap set" })
  end
end

--- Delete all keymaps belonging to a keymaps group.
---@param group_spec my.keymap.keymaps_loader_group
---@param ctx my.keymap.loader_ctx?
function M.delete_by_km_group(group_spec, ctx)
  -- TODO:
end

--- Load keymaps group.
---@param group_spec my.keymap.keymaps_loader_group
---@param ctx my.keymap.loader_ctx?
function M.load_km_group(group_spec, ctx)
  _normalize_ctx_buffer(ctx)
  for km_id, km_spec in pairs(group_spec) do
    _set(km_id, km_spec, ctx)
  end
end

--- Load queued keymaps groups.
function M.load_queued_km_groups()
  for _, args in ipairs(km_groups_load_queue) do
    M.load_km_group(unpack(args))
  end
  did_load_queued_km_groups = true
  km_groups_load_queue = nil
end

--- Queue keymaps group for loading.
---@param group_spec my.keymap.keymaps_loader_group
---@param ctx my.keymap.loader_ctx?
function M.queue_km_group_load(group_spec, ctx)
  -- vim.print("added km.group: ", group_spec)
  if did_load_queued_km_groups then
    M.load_km_group(group_spec, ctx)
  else
    km_groups_load_queue[#km_groups_load_queue + 1] = { group_spec, ctx }
  end
end

return M
