-- ==========================
--  YCM EXTERNAL LSP EXAMPLES
-- ==========================

-- repo url: <https://github.com/ycm-core/lsp-examples>
-- nvim help: ``

return {
  'ycm-core/lsp-examples',
  init = function()      
    local ycm_lsp_dir = vim.fn.stdpath('data') .. '/lazy/lsp-examples'
    vim.g['ycm_lsp_dir'] = ycm_lsp_dir
    vim.g['ycm_language_server'] = {
      {
         { name = 'docker',
           filetypes = { 'dockerfile' },
           cmdline = { vim.fn.expand( ycm_lsp_dir .. '/docker/node_modules/.bin/docker-langserver' ), '--stdio' }
         },
      },
      {
         {
           name = 'css',
           cmdline = { vim.fn.expand( ycm_lsp_dir .. '/css/node_modules/.bin/vscode-css-language-server' ), '--stdio' },
           filetypes = { 'css', 'sass' },
         },
      },
      {
         {
           name = 'bash',
           cmdline = { 'node', vim.fn.expand( ycm_lsp_dir .. '/bash/node_modules/.bin/bash-language-server' ), 'start' },
           filetypes = { 'sh', 'bash' },
         },
      },
      {
         { name = 'vim',
           filetypes = { 'vim' },
           cmdline = { vim.fn.expand( ycm_lsp_dir .. '/viml/node_modules/.bin/vim-language-server' ), '--stdio' }
         },
      },
    }
  end,
}
