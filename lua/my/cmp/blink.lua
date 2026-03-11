local my = require "my"
---@class my.cmp.blink
local M = {}

M.config = {}
M.config.min_providers_help_win_width = 20
M.config.original_buf_providers_char_id = "O"
M.config.sources = {
  default = { "lsp", "buffer", "snippets", "path" },
  per_filetype = {
    lua = { inherit_defaults = true, "lazydev" },
  },
}
---@type table<string, string | string[] | {desc: string?, providers?: string | string[]}>
M.config.providers_by_char_id = {
  b = "buffer",
  D = {
    desc = "global default providers:\n  %s",
    providers = M.config.sources.default,
  },
  l = "lsp",
  O = { desc = "Original buffer providers:\n  %s" },
  p = "path",
  s = "snippets",
  z = "lazydev",
}

M.opts = {}
M.opts.general = function(_, opts) ---@cast opts MyNoOptsSpec
  return my.tbl.merge_dicts_into_last(opts, {
    enabled = M.cmp_is_enabled_buf,
    keymap = {
      preset = "none",
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
      ghost_text = {
        enabled = false,
        show_with_selection = false,
        show_without_selection = true,
        show_with_menu = true,
        show_without_menu = true,
      },
    },
    signature = {
      enabled = true,
      trigger = {
        enabled = true,
        show_on_trigger_character = false,
        show_on_insert = false,
        show_on_insert_on_trigger_character = false,
      },
    },
    sources = {
      providers = {
        path = {
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            -- get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
            show_hidden_files_by_default = true,
            ignore_root_slash = false,
          },
        },
      },
    },
  } --[[@as MyNoOptsSpec]])
end
M.opts.core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_blinkcmp)
end

--- Get the next/previous cmp provider.
---@param reverse boolean? Get previous provider instead of next one.
---@return string[]? cmp_provider or nil if cmp providers list boundary reached.
local function _get_next_provider(reverse)
  local blink = require "blink"
  ---@type string[]?
  local providers = vim.b.my_cmp_providers
  ---@type integer?
  local provider_index = vim.b.my_cmp_provider_index
  ---@type string|string[]?
  local provider = nil
  ---@type string
  local msg

  if provider_index == nil or providers == nil then
    providers = blink.get_context().providers
    vim.b.my_cmp_providers = providers
    provider_index = reverse and #providers or 1
  else
    provider_index = provider_index + (reverse and -1 or 1)
  end

  if provider_index >= 1 and provider_index <= #providers then
    provider = providers[provider_index]
    if not (type(provider) == "table") then provider = { provider } end
  else
    provider = providers
    provider_index = nil
    vim.b.my_cmp_providers = nil
  end

  vim.b.my_cmp_provider_index = provider_index
  msg = string.format("set cmp provider to: %s", vim.inspect(provider))
  vim.api.nvim_echo({ { msg } }, false, {})
  return provider
end

local next_provider = function() --
  return _get_next_provider()
end

local prev_provider = function() --
  return _get_next_provider(true)
end

local function _get_provider_by_char_key()
  local blink = require "blink"
  if vim.b.my_cmp_orig_providers == nil then vim.b.my_cmp_orig_providers = blink.get_context().providers end

  local providers_by_char_id = M.config.providers_by_char_id
  local orig_cid = M.config.original_buf_providers_char_id
  if not providers_by_char_id[orig_cid] or type(providers_by_char_id[orig_cid]) ~= "table" then
    providers_by_char_id[orig_cid] = {}
  end
  providers_by_char_id[orig_cid].providers = vim.b.my_cmp_orig_providers
  local char_ids = vim.fn.sort(vim.tbl_keys(providers_by_char_id), "i")

  local provider_char_ids_str = table.concat(char_ids)
  local msg = string.format('Enter cmp provider("%s", "?" for help):', provider_char_ids_str)
  vim.api.nvim_echo({ { msg } }, false, {})
  local provider_key = vim.fn.keytrans(vim.fn.getcharstr(-1, { cursor = "msg", simplify = true }))

  ---@type integer?, integer?
  local help_win, help_buf
  local max_help_line_width = M.config.min_providers_help_win_width

  local function close_help_win()
    if help_win then
      vim.api.nvim_win_close(help_win, true)
      vim.api.nvim__redraw { flush = true }
      help_win = nil
      return true
    end
  end
  while provider_key == "?" do
    if not help_buf then
      local help_lines = {} ---@type string[]
      for _, char_id in ipairs(char_ids) do
        local desc ---@type string?
        local providers = providers_by_char_id[char_id]
        if type(providers) == "table" then
          if providers.providers then providers = providers.providers end
          desc = providers.desc ---@diagnostic disable-line: need-check-nil
        end
        if type(providers) == "table" then providers = table.concat(providers, ", ") end
        desc = string.format(desc or "%s", providers)
        local new_help_lines =
          vim.split(string.format("%s = %s", char_id, desc), "\n", { plain = true, trimempty = true })
        vim.list_extend(help_lines, new_help_lines)
      end
      help_buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_text(help_buf, 0, 0, 0, 0, help_lines)
      vim.bo[help_buf].modifiable = false
      for _, line in ipairs(help_lines) do
        if string.len(line) > max_help_line_width then max_help_line_width = string.len(line) end
      end
    end

    if not close_help_win() then
      local opts = {
        relative = "laststatus",
        width = max_help_line_width,
        height = vim.api.nvim_buf_line_count(help_buf),
        col = 0,
        row = 1,
        anchor = "SW",
        focusable = false,
        zindex = 2000,
        style = "minimal",
        border = "rounded",
      }
      help_win = vim.api.nvim_open_win(help_buf, false, opts)
      vim.api.nvim__redraw { flush = true }
    end

    provider_key = vim.fn.keytrans(vim.fn.getcharstr(-1, { cursor = "msg", simplify = true }))
  end
  close_help_win()
  if provider_key == "<Esc>" then return end

  local providers = providers_by_char_id[provider_key]
  if type(providers) == "string" then
    providers = { providers = { providers } }
  elseif type(providers) == "table" and not providers.providers then
    providers = { providers = providers }
  end
  if providers then
    local desc = providers.desc or "%s"
    providers = providers.providers ---@cast providers string[]
    desc = string.format(desc, table.concat(providers, ", ")):gsub("\n", " ")
    msg = string.format("set cmp provider/s to: %s", desc)
  else
    msg = string.format('Invalid cmp provider: "%s"', provider_key)
  end
  --
  vim.api.nvim_echo({ { msg } }, false, {})
  return providers
end

function M.cancel_and_clear_buf_vars() --
  return require("blink").cancel() and M.clear_buf_vars()
end

function M.clear_buf_vars()
  if vim.b.my_cmp_scroll_doc ~= nil then vim.b.my_cmp_scroll_doc = nil end
  if vim.b.my_cmp_provider_index ~= nil then vim.b.my_cmp_provider_index = nil end
  if vim.b.my_cmp_orig_providers ~= nil then vim.b.my_cmp_orig_providers = nil end
  return true
end

---@param bufnr? integer
---@return boolean
function M.cmp_is_enabled_buf(bufnr) --
  return my.bp[bufnr or 0].cmp_enabled:get_top()
end

---@param enable boolean
function M.cmp_toggle_buf(enable) --
  my.ui.toggle.toggle_priority_var(my.bp[0].cmp_enabled, enable)
end

M.keymaps = {}

M.keymaps.cancel_and_clear_buf_vars = { ---@type my.keymap.keymap_spec
  desc = "cmp cancel",
  rhs = M.cancel_and_clear_buf_vars,
}
M.keymaps.cancel_or_escape = { ---@type my.keymap.keymap_spec
  desc = "cmp cancel or ESC",
  expr = true,
  rhs = function() return M.cancel_and_clear_buf_vars() and "" or "<ESC>" end,
}
M.keymaps.cyctle_to_next_provider = { ---@type my.keymap.keymap_spec
  desc = "cmp next provider",
  rhs = function()
    local blink = require "blink"
    return blink.is_menu_visible() and blink.show { providers = next_provider() } or blink.show()
  end,
}
M.keymaps.cyctle_to_prev_provider = { ---@type my.keymap.keymap_spec
  desc = "cmp prev provider",
  rhs = function()
    local blink = require "blink"
    return blink.is_menu_visible() and blink.show { providers = prev_provider() } or blink.show()
  end,
}
M.keymaps.next_or_scroll_doc_down = { ---@type my.keymap.keymap_spec
  desc = "cmp next or docs down",
  rhs = function()
    local blink = require "blink"
    if blink.is_menu_visible() then
      if vim.b.my_cmp_scroll_doc then
        return blink.scroll_documentation_down(4)
      else
        return blink.select_next()
      end
    end
  end,
}
M.keymaps.prev_or_scroll_doc_up = { ---@type my.keymap.keymap_spec
  desc = "cmp next or docs up",
  rhs = function()
    local blink = require "blink"
    if blink.is_menu_visible() then
      if vim.b.my_cmp_scroll_doc then
        return blink.scroll_documentation_up(4)
      else
        return blink.select_prev()
      end
    end
  end,
}
M.keymaps.select_and_accept = { ---@type my.keymap.keymap_spec
  desc = "cmp select and accept",
  rhs = function() return require("blink").select_and_accept() end,
}
M.keymaps.select_provider = { ---@type my.keymap.keymap_spec
  desc = "cmp select provider",
  rhs = function() return require("blink").show { providers = _get_provider_by_char_key() } end,
}
M.keymaps.show = { ---@type my.keymap.keymap_spec
  desc = "cmp show list",
  rhs = function() return require("blink").show() end,
}
M.keymaps.snippet_backward = { ---@type my.keymap.keymap_spec
  desc = "snippet backward",
  rhs = function() return require("blink").snippet_backward() end,
}
M.keymaps.snippet_forward = { ---@type my.keymap.keymap_spec
  desc = "snippet forward",
  rhs = function() return require("blink").snippet_forward() end,
}
M.keymaps.toggle_documentation_or_signature = { ---@type my.keymap.keymap_spec
  desc = "cmp toggle docs",
  rhs = function()
    local blink = require "blink"
    return blink.hide_documentation() or blink.show_documentation() or blink.hide_signature() or blink.show_signature()
  end,
}
M.keymaps.toggle_scroll_doc = { ---@type my.keymap.keymap_spec
  desc = "cmp toggle list/docs",
  rhs = function()
    if require("blink").is_menu_visible() then
      vim.b.my_cmp_scroll_doc = not vim.b.my_cmp_scroll_doc
      return true
    end
  end,
}

return M
