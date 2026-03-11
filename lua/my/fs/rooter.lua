local my = require "my"
---@class my.fs.rooter
local M = {}

---@param path string
---@param bufnr integer
---@return string?
local function _get_lsp_root(path, bufnr)
  local roots = {} ---@type table<string, boolean>
  local longest_root ---@type string?
  local clients = vim.lsp.get_clients { bufnr = bufnr }
  if #clients == 0 then clients = vim.lsp.get_clients() end

  for _, client in ipairs(clients) do
    if client.root_dir then roots[client.root_dir] = true end
    for _, ws_folder in ipairs(client.config.workspace_folders) do
      roots[ws_folder.name] = true
    end
  end

  for root in pairs(roots) do
    root = vim.uv.fs_realpath(vim.fs.normalize(root)):gsub("([^/])/+", "%1")
    local match, len = path:find(root, 1, true)
    if match then
      if not longest_root or longest_root:len() < len then longest_root = root end
    end
  end
  return longest_root
end

--- Get root for given path and buffer.
---@param path string
---@param bufnr integer
---@return string?
function M.get_root(path, bufnr)
  local root ---@type string?

  -- if buf has LSP clients try them for path else try all LSP clients for path.
  -- if no LSP root found try global markers for root.
  root = _get_lsp_root(path, bufnr) or vim.fs.root(path, my.g.root_markers)

  if not root then
    local _msg = ("Buffer does not have root dir: %s"):format(vim.api.nvim_buf_get_name(0))
    vim.api.nvim_echo({ { _msg } }, true, { err = true })
  end

  return root
end

return M
