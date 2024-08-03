" ---------------------------------------------------------------------------
"  YCM EXTERNAL LSP EXAMPLES
" ---------------------------------------------------------------------------
" see: <https://github.com/ycm-core/lsp-examples>

let g:ycm_lsp_dir = expand('$NVIM_VIM_PLUG_ROOT/lsp-examples')
let g:ycm_language_server = []
let g:ycm_language_server += [
  \   { 'name': 'docker',
  \     'filetypes': [ 'dockerfile' ],
  \     'cmdline': [ expand( g:ycm_lsp_dir . '/docker/node_modules/.bin/docker-langserver' ), '--stdio' ]
  \   },
  \ ]
let g:ycm_language_server += [
  \   {
  \     'name': 'css',
  \     'cmdline': [ expand( g:ycm_lsp_dir . '/css/node_modules/.bin/vscode-css-language-server' ), '--stdio' ],
  \     'filetypes': [ 'css', 'sass' ],
  \   },
  \ ]
let g:ycm_language_server += [
  \   {
  \     'name': 'bash',
  \     'cmdline': [ 'node', expand( g:ycm_lsp_dir . '/bash/node_modules/.bin/bash-language-server' ), 'start' ],
  \     'filetypes': [ 'sh', 'bash' ],
  \   },
  \ ]
let g:ycm_language_server += [
  \   { 'name': 'vim',
  \     'filetypes': [ 'vim' ],
  \     'cmdline': [ expand( g:ycm_lsp_dir . '/viml/node_modules/.bin/vim-language-server' ), '--stdio' ]
  \   },
  \ ]
