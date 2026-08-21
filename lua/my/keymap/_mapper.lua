local M = {}

local my = require "my"

---@type table<MyKeymapModeSlugs, MyKeymapModes[]>
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
---@param ctx MyKeymapLoaderCtx?
local function _normalize_ctx_buffer(ctx)
  if not ctx then return end

  local buffer = ctx.buffer
  local ev = ctx.ev

  if ev and ev.buf then
    if buffer == nil or buffer == true then
      buffer = ev.buf
    elseif buffer ~= ev.buf then
      local _msg = string.format("discrepancy between `ctx.buf_id` and `ctx.ev.buf`\n%s", vim.inspect(ctx))
      error(_msg, 2)
    end
  elseif buffer == true then
    buffer = vim.api.nvim_get_current_buf()
  end

  ctx.buffer = buffer
end

--- TODO: description
---@param km_id string
local function _get_mode_and_lhs_from_id(km_id)
  local sub = string.sub

  local mode_slug = sub(km_id, 1, 4)
  local modifier = sub(km_id, 5, 7)
  local lhs = sub(km_id, 9, -2)

  if modifier == "<L>" then
    lhs = "<LEADER>" .. lhs
  elseif modifier == "<A>" or modifier == "<C>" then
    modifier = sub(modifier, 1, 2) .. "-"
    if string.find(lhs, "^<%a.*>.*") then
      lhs = modifier .. sub(lhs, 2)
    else
      lhs = modifier .. sub(lhs, 1, 1) .. ">" .. sub(lhs, 2)
    end
  elseif modifier ~= "<_>" then
    local _msg = string.format('invalid modifier " %s " in keymap id "%s"', modifier, km_id)
    my.notify.error(_msg, { title = "keymap set" })
    lhs = modifier .. lhs
    -- else (modifier == "<_>") do nothing (no LHS modifier)
  end

  return MODE_SLUG_MODES[mode_slug], lhs
end

--- TODO: description
---@param km_spec MyKeymapKeymapSpecFull
---@param buf_id BufId?
local function _set_normal_mapping(km_spec, buf_id)
  vim.keymap.set(km_spec.mode, km_spec.lhs, km_spec.rhs, {
    nowait = km_spec.nowait,
    silent = km_spec.silent,
    script = km_spec.script,
    expr = km_spec.expr,
    unique = km_spec.unique,
    desc = km_spec.desc,
    buffer = buf_id,
    replace_keycodes = km_spec.replace_keycodes,
    remap = km_spec.remap,
    noremap = km_spec.noremap,
  })
end

--- TODO: description
---@param km_spec MyKeymapKeymapSpecFull
local function _set_snacks_toggle_mapping(km_spec)
  local has_snacks, snacks = pcall(require, "snacks")
  if not has_snacks then return end
  local has_wk, _ = pcall(require, "which-key")

  local opts = km_spec.wk_toggle ---@cast opts -nil # should be filtered by `_set`

  local snacks_toggle = snacks.toggle

  local toggle_type = opts.type
  local toggle

  if toggle_type == "basic" then
    toggle = snacks_toggle.new(opts --[[@as snacks.toggle.Opts]])
  elseif toggle_type == "option" then
    local vim_option = opts.vim_option
    local ok, err = pcall(vim.api.nvim_get_option_value, vim_option, {})
    if not ok then error("Invalid toggle keymap: Invalid vim option: " .. err) end
    ---@cast vim_option string
    toggle = snacks_toggle.option(vim_option, opts --[[@as snacks.toggle.Opts]])
  end

  km_spec.rhs = function() toggle:toggle() end
  km_spec.desc = "Toggle " .. toggle.opts.name
  _set_normal_mapping(km_spec)
  if has_wk then toggle:_wk(km_spec.lhs, km_spec.mode) end
end

--- TODO: description
---@param km_spec MyKeymapKeymapSpecFull
local function _set_whichkey_group_mapping(km_spec)
  local has_wk, whichkey = pcall(require, "which-key")
  if not has_wk then return end
  whichkey.add { km_spec.lhs, mode = km_spec.mode, group = km_spec.wk_group }
end

--- TODO: description
---@param km_spec MyKeymapKeymapSpecFull
local function _set_whichkey_proxy_mapping(km_spec)
  local has_wk, whichkey = pcall(require, "which-key")
  if not has_wk then return end

  local src_km_group = km_spec.wk_proxy.km_group
  local src_km_id = km_spec.wk_proxy.km_id
  local src_spec = src_km_group[src_km_id]
  if not src_spec then
    local _msg = string.format("missing src spec for wk_proxy in.\n%s", vim.inspect(km_spec))
    return my.notify.warn(_msg, { title = "Keymap set" })
  end
  local _, src_lhs = _get_mode_and_lhs_from_id(src_km_id)
  whichkey.add { km_spec.lhs, mode = km_spec.mode, proxy = src_lhs, group = src_spec.wk_group }
end

--- TODO: description
---@param km_id string
---@param km_spec MyKeymapKeymapSpec
---@param ctx MyKeymapLoaderCtx?
local function _set(km_id, km_spec, ctx)
  -- NOTE: Currently buffer mappings are only intended to be set
  --       via a buffer km_group but this is not a final decision.
  --       The following is a runtime reminder about this.
  if km_spec.buffer ~= nil then
    local _msg = string.format("MEMO: km_spec.buffer not currently supportet.\n%s\n%s", km_id, vim.inspect(km_spec))
    my.notify.warn(_msg, { title = "Keymap set" })
  end
  -- NOTE: MEMO: Decided not to do dedicated super mappings.
  --       Rationale: While super mappings feel cool they also tend
  --       to misbehave, do the wrong thing in edge cases that are
  --       frequent enough to become annoying, as such it seems better
  --       to apply them on a case specific basis and think twice if they
  --       are really necessary in those cases too.

  local buf_id, ev
  if ctx then
    buf_id, ev = ctx.buffer, ctx.ev
    ---@cast buf_id BufId? # should be normalized in `M.load_km_group`
  end
  if km_spec.cond and not km_spec.cond(buf_id, ev) then return end

  ---@cast km_spec MyKeymapKeymapSpecFull
  km_spec = vim.deepcopy(km_spec, false)
  km_spec.mode, km_spec.lhs = _get_mode_and_lhs_from_id(km_id)

  if km_spec.rhs then
    _set_normal_mapping(km_spec, buf_id)
  elseif km_spec.wk_group then
    _set_whichkey_group_mapping(km_spec)
  elseif km_spec.wk_proxy then
    _set_whichkey_proxy_mapping(km_spec)
  elseif km_spec.wk_toggle then
    _set_snacks_toggle_mapping(km_spec)
  else
    local _msg = string.format("invalid keymap spec.\n%s\n%s", km_id, vim.inspect(km_spec))
    my.notify.warn(_msg, { title = "Keymap set" })
  end
end

--- Delete all keymaps belonging to a keymaps group.
---@param group_spec MyKeymapKeymapsLoaderGroup
---@param ctx MyKeymapLoaderCtx?
function M.delete_by_km_group(group_spec, ctx)
  -- TODO:
end

--- Load keymaps group.
---@param group_spec MyKeymapKeymapsLoaderGroup
---@param ctx MyKeymapLoaderCtx?
function M.load_km_group(group_spec, ctx)
  _normalize_ctx_buffer(ctx)
  for km_id, km_spec in pairs(group_spec) do
    _set(km_id, km_spec, ctx)
  end
end

--- Load queued keymaps groups.
function M.load_queued_km_groups()
  for _, loader_args in ipairs(km_groups_load_queue) do
    M.load_km_group(unpack(loader_args))
  end
  did_load_queued_km_groups = true
  km_groups_load_queue = nil
end

--- Queue keymaps group for loading.
---@param group_spec MyKeymapKeymapsLoaderGroup
---@param ctx MyKeymapLoaderCtx?
function M.queue_km_group_load(group_spec, ctx)
  -- vim.print("added km.group: ", group_spec)
  if did_load_queued_km_groups then
    M.load_km_group(group_spec, ctx)
  else
    km_groups_load_queue[#km_groups_load_queue + 1] = { group_spec, ctx }
  end
end

return M
