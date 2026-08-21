---@class MyLsp
---@field lspconfig MyLspLspconfig
---@field lsp_file_ops MyLspLspFileOps
---@field mason MyLspMason
---@field null_ls MyLspNullLs
local M = {}
M.init = { no_init = true, recurse = true } ---@type MyModuleInit

local my = require "my"

---@class MyLspFormatBufOpts: vim.lsp.buf.format.Opts
---@field silence_format_disabled? boolean

---@class MyLspAttachEvent: vim.api.keyset.create_autocmd.callback_args
---@field data { client_id: integer }

-- ---@alias MyLspLspAttachEvent
-- ---|vim.api.keyset.create_autocmd.callback_args
-- ---| {data: { client_id: integer }}

---@param buf_id? integer
---@param ev? MyLspAttachEvent
function M.code_action_has_capability_buf(buf_id, ev) --
  return M.has_capability_buf("textDocument/codeAction", buf_id, ev)
end

---@param buf_id? integer
---@param ev? MyLspAttachEvent
function M.codelens_has_capability_buf(buf_id, ev) --
  return M.has_capability_buf("textDocument/codeLens", buf_id, ev)
end

---@param buf_id? integer
---@return boolean
function M.codelens_is_enabled_buf(buf_id) --
  buf_id = buf_id or vim.api.nvim_get_current_buf()
  return my.ui.toggle.is_enabled_buf_override_glob(my.config.codelens_enabled_buf[buf_id], my.config.codelens_enabled)
end

---@return boolean
function M.codelens_is_enabled_global() --
  return my.config.codelens_enabled
end

---@param buf_id? integer
function M.codelens_refresh_buf(buf_id)
  buf_id = buf_id or vim.api.nvim_get_current_buf()
  -- if M.codelens_is_enabled_buf(buf_id) then vim.lsp.codelens.refresh { bufnr = buf_id } end
  vim.lsp.codelens.enable(M.codelens_is_enabled_buf(buf_id), { bufnr = buf_id })
end

function M.codelens_refresh_global() vim.lsp.codelens.enable(M.codelens_is_enabled_global()) end

---@param enable boolean
---@param buf_id? integer
function M.codelens_toggle_buf(enable, buf_id)
  buf_id = buf_id or vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = buf_id, method = "textDocument/codeLens" }
  if not clients or #clients == 0 then return my.notify.error "No LSP codelens available for current buffer." end
  my.config.codelens_enabled_buf[buf_id] = enable
  M.codelens_refresh_buf(buf_id)
end

---@param enable boolean
function M.codelens_toggle_global(enable) --
  my.config.codelens_enabled = enable
  M.codelens_refresh_global()
end

---@return boolean
function M.diagnostics_virtual_lines_is_enabled_global() --
  return vim.diagnostic.config().virtual_lines and true or false
end

---@param enable boolean
function M.diagnostics_virtual_lines_toggle_global(enable) --
  local new_virtual_lines = false
  local prev_virtual_lines = my.config.lsp_prev_diagnostic_virtual_lines
  if enable then
    new_virtual_lines = prev_virtual_lines or true
    prev_virtual_lines = false
  else
    prev_virtual_lines = vim.diagnostic.config().virtual_lines
  end
  my.config.lsp_prev_diagnostic_virtual_lines = prev_virtual_lines
  vim.diagnostic.config { virtual_lines = new_virtual_lines }
end

---@return boolean
function M.diagnostics_virtual_text_is_enabled_global() --
  return vim.diagnostic.config().virtual_text and true or false
end

---@param enable boolean
function M.diagnostics_virtual_text_toggle_global(enable) --
  local new_virtual_text = false
  local prev_virtual_text = my.config.lsp_prev_diagnostic_virtual_text
  if enable then
    new_virtual_text = prev_virtual_text or true
    prev_virtual_text = false
  else
    prev_virtual_text = vim.diagnostic.config().virtual_text
  end
  my.config.lsp_prev_diagnostic_virtual_text = prev_virtual_text
  vim.diagnostic.config { virtual_text = new_virtual_text }
end

--- Jump to previous/next LSP diagnostic
---@param reverse boolean
---@param severity? vim.diagnostic.Severity
---@return function
function M.diagnostic_jump(reverse, severity)
  local jump_opts = {
    severity = type(severity) == "string" and vim.diagnostic.severity[severity] or nil,
    count = reverse and -vim.v.count1 or vim.v.count1,
  }
  return function() vim.diagnostic.jump(jump_opts) end
end

---@param opts MyLspFormatBufOpts
function M.format_buf(opts) --
  if not opts then opts = {} end
  local silence_format_disabled = opts.silence_format_disabled
  opts.silence_format_disabled = nil
  local buf_id = opts.bufnr or vim.api.nvim_get_current_buf()
  opts.bufnr = buf_id
  if M.format_is_enabled_buf(buf_id) then
    if not opts.timeout_ms then
      opts.timeout_ms = my.config.format_timeout_ms_buf[buf_id] or my.config.format_timeout_ms
    end
    vim.lsp.buf.format(opts)
  elseif not silence_format_disabled then
    local msg = string.format("Formatting is disabled for buffer %s", vim.api.nvim_buf_get_name(buf_id))
    my.notify.error(msg, { title = "Format error" })
  end
end

---@param buf_id? integer
---@param ev? MyLspAttachEvent
function M.format_has_capability_buf(buf_id, ev) --
  return M.has_capability_buf("textDocument/formatting", buf_id, ev)
end

---@return boolean
function M.format_is_enabled_buf(buf_id) --
  buf_id = buf_id or vim.api.nvim_get_current_buf()
  return my.ui.toggle.is_enabled_buf_override_glob(my.config.format_buf[buf_id], my.config.format)
end

---@return boolean
function M.format_is_enabled_global() --
  return my.config.format
end

---@param enable boolean
---@param buf_id? integer
function M.format_toggle_buf(enable, buf_id)
  buf_id = buf_id or vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = buf_id, method = "textDocument/formatting" }
  if not clients or #clients == 0 then return my.notify.error "No LSP formatting available for current buffer." end
  my.config.format_buf[buf_id] = enable
end

---@param enable boolean
function M.format_toggle_global(enable) --
  my.config.format = enable
end

---@param buf_id? integer
---@param ev? MyLspAttachEvent
function M.format_range_has_capability_buf(buf_id, ev) --
  return M.has_capability_buf("textDocument/rangesFormatting", buf_id, ev)
end

---@return boolean
function M.format_on_save_is_enabled_buf(buf_id) --
  buf_id = buf_id or vim.api.nvim_get_current_buf()
  return my.ui.toggle.is_enabled_buf_override_glob(my.config.format_on_save_buf[buf_id], my.config.format_on_save)
end

---@return boolean
function M.format_on_save_is_enabled_global() --
  return my.config.format_on_save
end

---@param enable boolean
---@param buf_id? integer
function M.format_on_save_toggle_buf(enable, buf_id)
  buf_id = buf_id or vim.api.nvim_get_current_buf()
  local clients = my.tbl.merge(
    "lUF",
    vim.lsp.get_clients { bufnr = buf_id, method = "textDocument/formatting" },
    vim.lsp.get_clients { bufnr = buf_id, method = "textDocument/willSaveWaitUntil" }
  )
  if not clients or #clients == 0 then return my.notify.error "No LSP formatting available for current buffer." end
  my.config.format_on_save_buf[buf_id] = enable
end

---@param enable boolean
function M.format_on_save_toggle_global(enable) --
  my.config.format_on_save = enable
end

---@param method string
---@param buf_id? integer
---@param ev? MyLspAttachEvent
function M.has_capability_buf(method, buf_id, ev) --
  if ev then
    buf_id = buf_id or ev.buf
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    return client:supports_method(method, buf_id)
  end
  buf_id = buf_id or vim.api.nvim_get_current_buf()
  return #vim.lsp.get_clients { bufnr = buf_id, method = method } > 0
end

---@return boolean
function M.inlay_hint_is_enabled_buf(buf_id) --
  buf_id = buf_id or vim.api.nvim_get_current_buf()
  return vim.lsp.inlay_hint.is_enabled { bufnr = buf_id }
end

---@return boolean
function M.inlay_hint_is_enabled_global() --
  return vim.lsp.inlay_hint.is_enabled()
end

---@param enable boolean
---@param buf_id? integer
function M.inlay_hint_toggle_buf(enable, buf_id)
  buf_id = buf_id or vim.api.nvim_get_current_buf()
  vim.lsp.inlay_hint.enable(enable, { bufnr = buf_id })
end

---@param enable boolean
function M.inlay_hint_toggle_global(enable) --
  vim.lsp.inlay_hint.enable(enable)
end

---@param buf_id? integer
---@param ev? MyLspAttachEvent
function M.semantic_hl_has_capability_buf(buf_id, ev) --
  return M.has_capability_buf("textDocument/semanticTokens/full", buf_id, ev)
end

---@return boolean
function M.semantic_hl_is_enabled_buf(buf_id) --
  buf_id = buf_id or vim.api.nvim_get_current_buf()
  return my.ui.toggle.is_enabled_buf_nil_is_true(my.config.lsp_semantic_hl_buf[buf_id])
end

--- Toggle buffer LSP semantic token highlighting.
---@param enable boolean # if false turns highlighting off.
function M.semantic_hl_toggle_buf(enable)
  local buf_id = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = buf_id, method = "textDocument/semanticTokens/full" }
  if not clients then return my.notify.error "No semantic token highlighting available for current buffer." end
  for _, client in ipairs(clients) do
    vim.lsp.semantic_tokens.enable(enable, { bufnr = buf_id, client_id = client.id })
    vim.lsp.semantic_tokens.force_refresh(buf_id)
  end
end

M.autocmds = {}
M.autocmds.lsp_attach_codelens = function()
  local group = my.autocmd.get_augroup("my.lsp_attach.codelens", true)
  my.autocmd.add_autocmd {
    desc = "LSP on_attach setup for CodeLens capabilities",
    group = group,
    event = "LspAttach",
    callback = function(args)
      local buf_id = args.buf
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      if client:supports_method("textDocument/codeLens", buf_id) then
        vim.api.nvim_clear_autocmds { buffer = buf_id, group = group }
        M.codelens_refresh_buf(buf_id)
      end
    end,
  }
end
M.autocmds.lsp_attach_document_hl = function()
  local group = my.autocmd.get_augroup("my.lsp_attach.document_hl", true)
  my.autocmd.add_autocmd {
    desc = "LSP on_attach setup for documentHighlight capabilities",
    group = group,
    event = "LspAttach",
    callback = function(args)
      local buf_id = args.buf
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      if client:supports_method("textDocument/documentHighlight", buf_id) then
        vim.api.nvim_clear_autocmds { buffer = buf_id, group = group }
        my.autocmd.add_autocmd {
          desc = "LSP clear Document Highlighting",
          group = group,
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          buffer = buf_id,
          callback = function() vim.lsp.buf.clear_references() end,
        }
        my.autocmd.add_autocmd {
          desc = "LSP refresh Document Highlighting",
          group = group,
          event = { "CursorHold", "CursorHoldI", "BufEnter" },
          buffer = buf_id,
          callback = function() vim.lsp.buf.document_highlight() end,
        }
      end
      my.autocmd.add_autocmd {
        desc = "LSP remove Document Highlighting autocommands",
        group = group,
        event = "LspDetach",
        buffer = buf_id,
        callback = function(detach_args)
          local clients = vim.lsp.get_clients { bufnr = buf_id, method = "textDocument/documentHighlight" }
          if #clients == 1 and clients[1].id == detach_args.data.client_id then
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { buffer = buf_id, group = group }
          end
        end,
      }
    end,
  }
end
M.autocmds.lsp_attach_format_on_save = function()
  local group = my.autocmd.get_augroup("my.lsp_attach.format_on_save", true)
  my.autocmd.add_autocmd {
    desc = "LSP on_attach setup for format on save capabilities",
    group = group,
    event = "LspAttach",
    callback = function(args)
      local buf_id = args.buf
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      if client:supports_method("textDocument/willSaveWaitUntil", buf_id) then
        -- TODO: Figure out if and what to do with clients that actually support this.
        local msg = string.format('LSP client "%s" supports "textDocument/willSaveWaitUntil" capability', client.name)
        my.notify.warn(msg, { title = "TODO..." })
      end
      if client:supports_method "textDocument/formatting" then
        local autocmd_ids = {}
        autocmd_ids[#autocmd_ids + 1] = my.autocmd.add_autocmd {
          desc = "LSP format buffer on save",
          group = group,
          event = "BufWritePre",
          buffer = buf_id,
          callback = function()
            if M.format_on_save_is_enabled_buf(buf_id) then
              M.format_buf { bufnr = buf_id, id = client.id, silence_format_disabled = true }
            end
          end,
        }
        autocmd_ids[#autocmd_ids + 1] = my.autocmd.add_autocmd {
          desc = "LSP remove format buffer on save autocommands",
          group = group,
          event = "LspDetach",
          buffer = buf_id,
          callback = function(detach_args)
            if detach_args.data.client_id == client.id then my.autocmd.del_autocmds(autocmd_ids) end
          end,
        }
      end
    end,
  }
end
M.autocmds.lsp_attach_keymaps = function()
  local group = my.autocmd.get_augroup("my.lsp_attach.keymaps", true)
  my.autocmd.add_autocmd {
    desc = "LSP on_attach core keymaps setup",
    group = group,
    event = "LspAttach",
    callback = function(args) --
      local buf_id = args.buf
      my.keymap.load_km_group(my.config.keymaps.b_core_lsp, { ev = args })
      my.autocmd.add_autocmd {
        desc = "remove LSP keymaps",
        group = group,
        event = "LspDetach",
        buffer = buf_id,
        callback = function(detach_args)
          local clients = vim.lsp.get_clients { bufnr = buf_id }
          if #clients == 1 and clients[1].id == detach_args.data.client_id then
            vim.api.nvim_clear_autocmds { buffer = buf_id, group = group }
            my.keymap.delete_by_km_group(my.config.keymaps.b_core_lsp, { ev = args })
          end
        end,
      }
    end,
  }
end
M.autocmds.lsp_attach_semantic_hl = function()
  local group = my.autocmd.get_augroup("my.lsp_attach.semantic_hl", true)
  my.autocmd.add_autocmd {
    desc = "LSP on_attach setup for semantic highlighting capabilities",
    group = group,
    event = "LspAttach",
    callback = function(args)
      local buf_id = args.buf
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      if
        client:supports_method("textDocument/semanticTokens/full", buf_id) and M.semantic_hl_is_enabled_buf(buf_id)
      then
        vim.lsp.semantic_tokens.enable(true, { bufnr = buf_id, client_id = client.id })
      end
      my.autocmd.add_autocmd {
        desc = "LSP remove semantic highlighting",
        group = group,
        event = "LspDetach",
        buffer = buf_id,
        callback = function(detach_args)
          local clients = vim.lsp.get_clients { bufnr = buf_id, method = "textDocument/semanticTokens/full" }
          if #clients == 1 and clients[1].id == detach_args.data.client_id then
            vim.lsp.semantic_tokens.enable(false, { bufnr = buf_id, client_id = client.id })
            vim.api.nvim_clear_autocmds { buffer = buf_id, group = group }
          end
        end,
      }
    end,
  }
end
M.autocmds.lsp_file_ops = function()
  local augroup = my.autocmd.get_augroup("my.lsp.lsp_file_ops", true)
  my.autocmd.add_autocmd {
    desc = "trigger willCreateFiles before writing a new file",
    group = augroup,
    event = "BufWritePre",
    callback = function(args)
      local buf_id = args.buf
      local filename = my.buf.is_listed(buf_id) and vim.fn.expand("#" .. buf_id .. ":p")
      if filename and not vim.uv.fs_stat(filename) then
        my.config.new_file_buf[buf_id] = filename
        my.lsp.lsp_file_ops.files_will_create(filename)
      end
    end,
  }
  my.autocmd.add_autocmd {
    desc = "trigger didCreateFiles after writing a new file",
    group = augroup,
    event = "BufWritePost",
    callback = function(args)
      local buf_id = args.buf
      local filename = my.config.new_file_buf[buf_id]
      if filename then
        my.config.new_file_buf[buf_id] = false
        my.lsp.lsp_file_ops.files_did_create(filename)
      end
    end,
  }
end

M.keymaps = {}
M.keymaps.code_action = { ---@type MyKeymapKeymapSpec
  desc = "LSP code action (cursor)",
  rhs = function() vim.lsp.buf.code_action() end,
  cond = M.code_action_has_capability_buf,
}
M.keymaps.code_action_source_only = { ---@type MyKeymapKeymapSpec
  desc = "LSP code action (source)",
  rhs = function() vim.lsp.buf.code_action { context = { { "source" }, diagnostics = {} } } end,
  cond = M.code_action_has_capability_buf,
}
M.keymaps.codelens_refresh = { ---@type MyKeymapKeymapSpec
  desc = "LSP CodeLens refresh",
  rhs = M.codelens_refresh_buf,
  cond = M.codelens_has_capability_buf,
}
M.keymaps.codelens_run = { ---@type MyKeymapKeymapSpec
  desc = "LSP CodeLens run",
  rhs = function() vim.lsp.codelens.run() end,
  cond = M.codelens_has_capability_buf,
}
M.keymaps.diagnostic_jump_next = { ---@type MyKeymapKeymapSpec
  desc = "Next Diagnostic",
  rhs = M.diagnostic_jump(false),
}
M.keymaps.diagnostic_jump_next_error = { ---@type MyKeymapKeymapSpec
  desc = "Next Error",
  rhs = M.diagnostic_jump(false, "ERROR"),
}
M.keymaps.diagnostic_jump_next_warn = { ---@type MyKeymapKeymapSpec
  desc = "Next Warning",
  rhs = M.diagnostic_jump(false, "WARN"),
}
M.keymaps.diagnostic_jump_prev = { ---@type MyKeymapKeymapSpec
  desc = "Prev Diagnostic",
  rhs = M.diagnostic_jump(true),
}
M.keymaps.diagnostic_jump_prev_error = { ---@type MyKeymapKeymapSpec
  desc = "Prev Error",
  rhs = M.diagnostic_jump(true, "ERROR"),
}
M.keymaps.diagnostic_jump_prev_warn = { ---@type MyKeymapKeymapSpec
  desc = "Prev Warning",
  rhs = M.diagnostic_jump(true, "WARN"),
}
M.keymaps.format_buffer_n_ = { ---@type MyKeymapKeymapSpec
  desc = "Format buffer",
  rhs = M.format_buf,
  cond = M.format_has_capability_buf,
}
M.keymaps.format_buffer_x_ = { ---@type MyKeymapKeymapSpec
  desc = "Format buffer",
  rhs = M.format_buf,
  cond = M.format_range_has_capability_buf,
}
M.keymaps.hover_diagnostics = { ---@type MyKeymapKeymapSpec
  desc = "Hover diagnostics",
  rhs = vim.diagnostic.open_float,
}
M.keymaps.list_references = { ---@type MyKeymapKeymapSpec
  desc = "List references",
  rhs = vim.lsp.buf.references,
}
M.keymaps.list_workspace_symbols = { ---@type MyKeymapKeymapSpec
  desc = "List workspace symbols",
  rhs = vim.lsp.buf.workspace_symbol,
}
M.keymaps.rename_current_symbol = { ---@type MyKeymapKeymapSpec
  desc = "Rename current symbol",
  rhs = vim.lsp.buf.rename,
}
M.keymaps.signature_help = { ---@type MyKeymapKeymapSpec
  desc = "Signature help",
  rhs = vim.lsp.buf.signature_help,
}
M.keymaps.symbol_hover = { ---@type MyKeymapKeymapSpec
  desc = "cmp toggle docs",
  rhs = vim.lsp.buf.hover,
}

return M
