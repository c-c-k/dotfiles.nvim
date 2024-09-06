-- ==================================================
-- ASTRONVIM ASTROLSP (FEATURES, CAPABILITIES, ETC..)
-- ==================================================

-- repo url: <https://github.com/AstroNvim/astrolsp>
-- nvim help: `:help astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      -- -- Configuration table of features provided by AstroLSP
      -- features = {
      --   codelens = true, -- enable/disable codelens refresh on start
      --   inlay_hints = false, -- enable/disable inlay hints on start
      --   semantic_tokens = true, -- enable/disable semantic token highlighting
      -- },

      -- -- Configure default capabilities for language servers (`:h vim.lsp.protocol.make_client.capabilities()`)
      -- capabilities = {
      --   textDocument = {
      --     foldingRange = { dynamicRegistration = false },
      --   },
      -- },

      -- -- customize language server configuration options passed to `lspconfig`
      -- ---@diagnostic disable: missing-fields
      -- config = {
      --   lua_ls = {
      --     settings = {
      --       Lua = {
      --         hint = { enable = true, arrayIndex = "Disable" },
      --       },
      --     },
      --   },
      --   clangd = {
      --     capabilities = {
      --       offsetEncoding = "utf-8",
      --     },
      --   },
      -- },

      -- -- A custom flags table to be passed to all language servers  (`:h lspconfig-setup`)
      -- flags = {
      --   exit_timeout = 5000,
      -- },

      -- -- Configuration options for controlling formatting with language servers
      -- formatting = {
      --   -- control auto formatting on save
      --   format_on_save = {
      --     -- enable or disable format on save globally
      --     enabled = true,
      --     -- enable format on save for specified filetypes only
      --     allow_filetypes = {
      --       "go",
      --     },
      --     -- disable format on save for specified filetypes
      --     ignore_filetypes = {
      --       "python",
      --     },
      --   },
      --   -- disable formatting capabilities for specific language servers
      --   disabled = {
      --      -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
      --     "lua_ls",
      --   },
      --   -- default format timeout
      --   timeout_ms = 1000,
      --   -- fully override the default formatting function
      --   filter = function(client) return true end,
      -- },

      -- -- Customize how language servers are attached
      -- handlers = {
      --   -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      --   function(server, opts) require("lspconfig")[server].setup(opts) end,
      --   -- the key is the server that is being setup with `lspconfig`
      --   -- custom function handler for pyright
      --   pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end,
      --   -- set to false to disable the setup of a language server
      --   rust_analyzer = false,
      -- },

      -- -- Configure `vim.lsp.handlers`
      -- lsp_handlers = {
      --   ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", silent = true }),
      --   ["textDocument/signatureHelp"] = false, -- set to false to disable any custom handlers
      -- },

      -- -- A list like table of servers that should be setup, useful for enabling language servers not installed with Mason.
      -- servers = { "dartls" },

      -- -- A custom `on_attach` function to be run after the default `on_attach` function, takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
      -- on_attach = function(client, bufnr)
      --   -- this would disable semanticTokensProvider for all clients
      --   client.server_capabilities.semanticTokensProvider = nil
      -- end,
    } --[[@as AstroLSPOpts]])
  end,
}
