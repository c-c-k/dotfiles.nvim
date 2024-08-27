-- ===
-- ALE
-- ===

-- repo url: <https://github.com/dense-analysis/ale>
-- nvim help: `:help ale`

return {
  -- == PLUGIN DISABLED ==
  -- This plugin has been automatically converted from vim-plug style configuration to lazy.nvim style one.
  -- It is temporarily disabled until it passed manual inspection to check that it has been converted correctly.
  enabled = false,
  'dense-analysis/ale',
  init = function()      
    -- vim.g['ale_disable_lsp'] = 1
    vim.g['ale_set_quickfix'] = 0
    vim.g['ale_set_loclist'] = 0
    vim.g['ale_completion_enabled'] = 0
    vim.g['ale_linters_explicit'] = 1
    vim.g['ale_sign_column_always'] = 1
    vim.g['ale_lint_on_text_changed'] = 0
    vim.g['ale_lint_on_insert_leave'] = 0
    vim.g['ale_linter_aliases'] = {
    html = {'html', 'javascript', 'css'}
    }
    vim.g['ale_linters'] = {
    css = {'eslint'},
    javascript = {'eslint'},
    json = {'eslint'},
    html = {'eslint'},
    python = {'flake8', 'mypy'},
    sh = {'shellcheck'},
    sql = {'sqlfluff'},
    typescript = {'eslint'},
    vue = {'eslint'},
    }
    vim.g['ale_fixers'] = {
    css = {
    'prettier', 'trim_whitespace', 'remove_trailing_lines'
    },
    javascript = {
    'prettier', 'trim_whitespace', 'remove_trailing_lines'
    },
    javascriptreact = {
    'prettier', 'trim_whitespace', 'remove_trailing_lines'
    },
    json = {
    'prettier', 'trim_whitespace', 'remove_trailing_lines'
    },
    html = {
    'prettier', 'trim_whitespace', 'remove_trailing_lines'
    },
    python = {
    'yapf', 'trim_whitespace', 'remove_trailing_lines'
    },
    sh = {
    'shfmt', 'trim_whitespace', 'remove_trailing_lines'
    },
    sql = {
    'sqlfluff', 'trim_whitespace', 'remove_trailing_lines'
    },
    typescript = {
    'prettier', 'trim_whitespace', 'remove_trailing_lines'
    },
    vue = {
    'prettier', 'trim_whitespace', 'remove_trailing_lines'
    },
    }
  end,
}