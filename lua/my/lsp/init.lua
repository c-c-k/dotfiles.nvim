local my = require "my"
---@class my.lsp: my.lsp._submodules
local M = {}

M.opts = {}
M.opts.mason_tool_installer_general = function(_, opts) ---@cast opts MyNoOptsSpec
  return my.tbl.merge_dicts_into_last(opts, {
    ensure_installed = {},
  } --[[@as MyNoOptsSpec]])
end

---@param bufnr? integer
---@param args? my.lsp.lsp_attach_args
function M.code_action_has_capability_buf(bufnr, args) --
  return M.has_capability_buf("textDocument/codeAction", bufnr, args)
end

---@param bufnr? integer
---@param args? my.lsp.lsp_attach_args
function M.codelens_has_capability_buf(bufnr, args) --
  return M.has_capability_buf("textDocument/codeLens", bufnr, args)
end

---@param bufnr? integer
---@return boolean
function M.codelens_is_enabled_buf(bufnr) --
  return my.bp[bufnr or 0].codelens_enabled:get_top()
end

function M.codelens_is_enabled_global() --
  return my.bp.codelens_enabled:get(my.vp.GLOBAL_DEFAULT)
end

---@param bufnr? integer
function M.codelens_refresh(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if M.codelens_is_enabled_buf(bufnr) then vim.lsp.codelens.refresh { bufnr = bufnr } end
end

---@param enable boolean
function M.codelens_toggle_buf(enable)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/codeLens" }
  if not clients or #clients == 0 then return my.notify.error "No LSP codelens available for current buffer." end
  my.ui.toggle.toggle_priority_var(my.bp[bufnr].codelens_enabled, enable)
end

---@param enable boolean
function M.codelens_toggle_global(enable) --
  my.bp.codelens_enabled:set(my.vp.GLOBAL_DEFAULT, enable)
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

---@param opts my.lsp.format_buf.opts
function M.format_buf(opts) --
  if not opts then opts = {} end
  local silence_format_disabled = opts.silence_format_disabled
  opts.silence_format_disabled = nil
  if not opts.bufnr then opts.bufnr = vim.api.nvim_get_current_buf() end
  if M.format_is_enabled_buf(opts.bufnr) then
    if not opts.timeout_ms then opts.timeout_ms = my.bp[opts.bufnr].format_timeout_ms:get_top() end
    vim.lsp.buf.format(opts)
  elseif not silence_format_disabled then
    local msg = string.format("Formatting is disabled for buffer %s", vim.api.nvim_buf_get_name(opts.bufnr))
    my.notify.error(msg, { title = "Format error" })
  end
end

---@param bufnr? integer
---@param args? my.lsp.lsp_attach_args
function M.format_has_capability_buf(bufnr, args) --
  return M.has_capability_buf("textDocument/formatting", bufnr, args)
end

function M.format_is_enabled_buf(bufnr) --
  return my.bp[bufnr or 0].format:get_top()
end

function M.format_is_enabled_global() --
  return my.bp.format:get(my.vp.GLOBAL_DEFAULT)
end

---@param enable boolean
function M.format_toggle_buf(enable)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/formatting" }
  if not clients or #clients == 0 then return my.notify.error "No LSP formatting available for current buffer." end
  my.ui.toggle.toggle_priority_var(my.bp[bufnr].format, enable)
end

---@param enable boolean
function M.format_toggle_global(enable) --
  my.bp.format:set(my.vp.GLOBAL_DEFAULT, enable)
end

---@param bufnr? integer
---@param args? my.lsp.lsp_attach_args
function M.format_range_has_capability_buf(bufnr, args) --
  return M.has_capability_buf("textDocument/rangesFormatting", bufnr, args)
end

function M.format_on_save_is_enabled_buf(bufnr) --
  return my.bp[bufnr or 0].format_on_save:get_top()
end

function M.format_on_save_is_enabled_global() --
  return my.bp.format_on_save:get(my.vp.GLOBAL_DEFAULT)
end

---@param enable boolean
function M.format_on_save_toggle_buf(enable)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = my.tbl.merge_lists_into_first(
    vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/formatting" },
    vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/willSaveWaitUntil" }
  )
  if not clients or #clients == 0 then return my.notify.error "No LSP formatting available for current buffer." end
  my.ui.toggle.toggle_priority_var(my.bp[bufnr].format_on_save, enable)
end

---@param enable boolean
function M.format_on_save_toggle_global(enable) --
  my.bp.format_on_save:set(my.vp.GLOBAL_DEFAULT, enable)
end

---@param method string
---@param bufnr? integer
---@param args? my.lsp.lsp_attach_args
function M.has_capability_buf(method, bufnr, args) --
  if args then
    bufnr = bufnr or args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    return client:supports_method(method, bufnr)
  end
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  return #vim.lsp.get_clients { bufnr = bufnr, method = method } > 0
end

function M.inlay_hint_is_enabled_buf(bufnr) --
  return vim.lsp.inlay_hint.is_enabled { bufnr = bufnr or 0 }
end

function M.inlay_hint_is_enabled_global() --
  return vim.lsp.inlay_hint.is_enabled()
end

---@param enable boolean
function M.inlay_hint_toggle_buf(enable)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.inlay_hint.enable(enable, { bufnr = bufnr })
end

---@param enable boolean
function M.inlay_hint_toggle_global(enable) --
  vim.lsp.inlay_hint.enable(enable)
end

function M.setup_lsp_autocmds()
  for name, func in pairs(M.autocmds) do
    if type(func) == "function" and string.match(name, "^lsp_attach") then func() end
  end
end

---@param bufnr? integer
---@param args? my.lsp.lsp_attach_args
function M.semantic_hl_has_capability_buf(bufnr, args) --
  return M.has_capability_buf("textDocument/semanticTokens/full", bufnr, args)
end

function M.semantic_hl_is_enabled_buf(bufnr) --
  return my.bp[bufnr or 0].lsp_semantic_hl:get_top()
end

--- Toggle buffer LSP semantic token highlighting.
---@param enable boolean # if false turns highlighting off.
function M.semantic_hl_toggle_buf(enable)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/semanticTokens/full" }
  if not clients then return my.notify.error "No semantic token highlighting available for current buffer." end
  enable = my.ui.toggle.toggle_priority_var(my.bp[bufnr].lsp_semantic_hl, enable)
  local toggle_func = enable and vim.lsp.semantic_tokens.start or vim.lsp.semantic_tokens.stop
  for _, client in ipairs(clients) do
    toggle_func(bufnr, client.id)
    vim.lsp.semantic_tokens.force_refresh(bufnr)
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
      local bufnr = args.buf
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      if client:supports_method("textDocument/codeLens", bufnr) then
        vim.api.nvim_clear_autocmds { buffer = bufnr, group = group }
        M.codelens_refresh(bufnr)
        my.autocmd.add_autocmd {
          desc = "LSP refresh CodeLens",
          group = group,
          event = { "TextChanged", "InsertLeave", "BufEnter" },
          buffer = bufnr,
          callback = function() M.codelens_refresh(bufnr) end,
        }
        my.autocmd.add_autocmd {
          desc = "LSP remove CodeLens autocommands",
          group = group,
          event = "LspDetach",
          buffer = bufnr,
          callback = function(detach_args)
            local clients = vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/codeLens" }
            if #clients == 1 and clients[1].id == detach_args.data.client_id then
              vim.api.nvim_clear_autocmds { buffer = bufnr, group = group }
            end
          end,
        }
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
      local bufnr = args.buf
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      if client:supports_method("textDocument/documentHighlight", bufnr) then
        vim.api.nvim_clear_autocmds { buffer = bufnr, group = group }
        my.autocmd.add_autocmd {
          desc = "LSP clear Document Highlighting",
          group = group,
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          buffer = bufnr,
          callback = function() vim.lsp.buf.clear_references() end,
        }
        my.autocmd.add_autocmd {
          desc = "LSP refresh Document Highlighting",
          group = group,
          event = { "CursorHold", "CursorHoldI", "BufEnter" },
          buffer = bufnr,
          callback = function() vim.lsp.buf.document_highlight() end,
        }
      end
      my.autocmd.add_autocmd {
        desc = "LSP remove Document Highlighting autocommands",
        group = group,
        event = "LspDetach",
        buffer = bufnr,
        callback = function(detach_args)
          local clients = vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/documentHighlight" }
          if #clients == 1 and clients[1].id == detach_args.data.client_id then
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { buffer = bufnr, group = group }
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
      local bufnr = args.buf
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      if client:supports_method("textDocument/willSaveWaitUntil", bufnr) then
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
          buffer = bufnr,
          callback = function()
            if M.format_on_save_is_enabled_buf(bufnr) then
              M.format_buf { bufnr = bufnr, id = client.id, silence_format_disabled = true }
            end
          end,
        }
        autocmd_ids[#autocmd_ids + 1] = my.autocmd.add_autocmd {
          desc = "LSP remove format buffer on save autocommands",
          group = group,
          event = "LspDetach",
          buffer = bufnr,
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
      local bufnr = args.buf
      my.keymap.load_km_group(my.config.keymaps.b_core_lsp, { args = args })
      my.autocmd.add_autocmd {
        desc = "remove LSP keymaps",
        group = group,
        event = "LspDetach",
        buffer = bufnr,
        callback = function(detach_args)
          local clients = vim.lsp.get_clients { bufnr = bufnr }
          if #clients == 1 and clients[1].id == detach_args.data.client_id then
            vim.api.nvim_clear_autocmds { buffer = bufnr, group = group }
            my.keymap.delete_by_km_group(my.config.keymaps.b_core_lsp, { args = args })
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
      local bufnr = args.buf
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      if client:supports_method("textDocument/semanticTokens/full", bufnr) and M.semantic_hl_is_enabled_buf(bufnr) then
        vim.lsp.semantic_tokens.start(bufnr, client.id)
      end
      my.autocmd.add_autocmd {
        desc = "LSP remove semantic highlighting",
        group = group,
        event = "LspDetach",
        buffer = bufnr,
        callback = function(detach_args)
          local clients = vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/semanticTokens/full" }
          if #clients == 1 and clients[1].id == detach_args.data.client_id then
            vim.lsp.semantic_tokens.stop(bufnr, client.id)
            vim.api.nvim_clear_autocmds { buffer = bufnr, group = group }
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
      local filename = my.buf.is_listed(args.buf) and vim.fn.expand("#" .. args.buf .. ":p")
      if filename and not vim.uv.fs_stat(filename) then
        my.b[args.buf].new_file = filename
        my.lsp.lsp_file_ops.files_will_create(filename)
      end
    end,
  }
  my.autocmd.add_autocmd {
    desc = "trigger didCreateFiles after writing a new file",
    group = augroup,
    event = "BufWritePost",
    callback = function(args)
      local filename = my.b[args.buf].new_file
      if filename then
        my.b[args.buf].new_file = false
        my.lsp.lsp_file_ops.files_did_create(filename)
      end
    end,
  }
end

M.keymaps = {}
M.keymaps.code_action = { ---@type my.keymap.keymap_spec
  desc = "LSP code action (cursor)",
  rhs = function() vim.lsp.buf.code_action() end,
  cond = M.code_action_has_capability_buf,
}
M.keymaps.code_action_source_only = { ---@type my.keymap.keymap_spec
  desc = "LSP code action (source)",
  rhs = function() vim.lsp.buf.code_action { context = { { "source" }, diagnostics = {} } } end,
  cond = M.code_action_has_capability_buf,
}
M.keymaps.codelens_refresh = { ---@type my.keymap.keymap_spec
  desc = "LSP CodeLens refresh",
  rhs = M.codelens_refresh,
  cond = M.codelens_has_capability_buf,
}
M.keymaps.codelens_run = { ---@type my.keymap.keymap_spec
  desc = "LSP CodeLens run",
  rhs = function() vim.lsp.codelens.run() end,
  cond = M.codelens_has_capability_buf,
}
M.keymaps.diagnostic_jump_next = { ---@type my.keymap.keymap_spec
  desc = "Next Diagnostic",
  rhs = M.diagnostic_jump(false),
}
M.keymaps.diagnostic_jump_next_error = { ---@type my.keymap.keymap_spec
  desc = "Next Error",
  rhs = M.diagnostic_jump(false, "ERROR"),
}
M.keymaps.diagnostic_jump_next_warn = { ---@type my.keymap.keymap_spec
  desc = "Next Warning",
  rhs = M.diagnostic_jump(false, "WARN"),
}
M.keymaps.diagnostic_jump_prev = { ---@type my.keymap.keymap_spec
  desc = "Prev Diagnostic",
  rhs = M.diagnostic_jump(true),
}
M.keymaps.diagnostic_jump_prev_error = { ---@type my.keymap.keymap_spec
  desc = "Prev Error",
  rhs = M.diagnostic_jump(true, "ERROR"),
}
M.keymaps.diagnostic_jump_prev_warn = { ---@type my.keymap.keymap_spec
  desc = "Prev Warning",
  rhs = M.diagnostic_jump(true, "WARN"),
}
M.keymaps.format_buffer_n_ = { ---@type my.keymap.keymap_spec
  desc = "Format buffer",
  rhs = M.format_buf,
  cond = M.format_has_capability_buf,
}
M.keymaps.format_buffer_x_ = { ---@type my.keymap.keymap_spec
  desc = "Format buffer",
  rhs = M.format_buf,
  cond = M.format_range_has_capability_buf,
}
M.keymaps.hover_diagnostics = { ---@type my.keymap.keymap_spec
  desc = "Hover diagnostics",
  rhs = vim.diagnostic.open_float,
}
M.keymaps.list_references = { ---@type my.keymap.keymap_spec
  desc = "List references",
  rhs = vim.lsp.buf.references,
}
M.keymaps.list_workspace_symbols = { ---@type my.keymap.keymap_spec
  desc = "List workspace symbols",
  rhs = vim.lsp.buf.workspace_symbol,
}
M.keymaps.rename_current_symbol = { ---@type my.keymap.keymap_spec
  desc = "Rename current symbol",
  rhs = vim.lsp.buf.rename,
}
M.keymaps.signature_help = { ---@type my.keymap.keymap_spec
  desc = "Signature help",
  rhs = vim.lsp.buf.signature_help,
}
M.keymaps.symbol_hover = { ---@type my.keymap.keymap_spec
  desc = "cmp toggle docs",
  rhs = vim.lsp.buf.hover,
}

return M
