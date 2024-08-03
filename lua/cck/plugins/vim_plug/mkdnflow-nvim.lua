-- ===========================================================================
-- MKDNFLOW.NVIM
-- ===========================================================================
-- see: <https://github.com/jakewvincent/mkdnflow.nvim>
-- see: `:help Mkdnflow-help`

require('mkdnflow').setup({
    modules = {
        bib = false,  -- orig: true,
        buffers = false,  -- orig: true,
        conceal = false,
        cursor = true,
        folds = false,
        foldtext = false,
        links = true,  -- orig: true,
        lists = true,
        -- maps = false,  -- orig: true,
        maps = true,
        paths = false,  -- orig: true,
        tables = true,
        yaml = false,
        cmp = false
    },
    filetypes = {md = true},  -- orig: {md = true, rmd = true, markdown = true},
    create_dirs = true,
    perspective = {
        priority =  'current', -- orig: 'first',
        fallback = 'current',
        root_tell = false,
        nvim_wd_heel = true,  -- orig: false,
        update = false
    },
    wrap = false,
    bib = {
        default_path = nil,
        find_in_root = true
    },
    silent = false,
    cursor = {
        jump_patterns = nil
    },
    links = {
        style = 'markdown',
        name_is_source = false,
        conceal = false,
        context = 0,
        implicit_extension = nil,
        transform_implicit = false,
        transform_explicit = function(text)
            text = text:gsub(" ", "-")
            text = text:lower()
            text = os.date('%Y-%m-%d_')..text
            return(text)
        end,
        create_on_follow_failure = true
    },
    new_file_template = {
        use_template = false,
        template = [[
        # {{ title }}
        Date: {{ date }}
        Filename: {{ filename }}
        ]],
        placeholders = {
            before = {
                date = function()
                        return os.date("%A, %B %d, %Y") -- Wednesday, March 1, 2023
                        end
            },
            after = {
                filename = function()
                        return vim.api.nvim_buf_get_name(0)
                        end
            }
        }
    },
    to_do = {
        symbols = {' ', '-', 'x'},
        update_parents = true,
        not_started = ' ',
        in_progress = '-',
        complete = 'x'
    },
    foldtext = {
        object_count = true,
        object_count_icons = 'emoji',
        object_count_opts = function()
            return require('mkdnflow').foldtext.default_count_opts()
        end,
        line_count = true,
        line_percentage = true,
        word_count = false,
        title_transformer = nil,
        separator = ' · ',
        fill_chars = {
            left_edge = '⢾',
            right_edge = '⡷',
            left_inside = ' ⣹',
            right_inside = '⣏ ',
            middle = '⣿',
        },
    },
    tables = {
        trim_whitespace = true,
        format_on_move = true,
        auto_extend_rows = false,
        auto_extend_cols = false,
        style = {
            cell_padding = 1,
            separator_padding = 1,
            outer_pipes = true,
            mimic_alignment = true
        }
    },
    yaml = {
        bib = { override = false }
    },
    mappings = {
        MkdnEnter = {'i', '<CR>'},  -- orig: {{'n', 'v', 'i'}, '<CR>'},
        MkdnTab = {{'i', 'n'}, '<Tab>'},  -- orig: false
        MkdnSTab = {{'i', 'n'}, '<S-Tab>'},  -- orig: false
        MkdnNextLink = {'n', 'gl'},  -- orig: {'n', '<Tab>'},
        MkdnPrevLink =  {'n', 'gL'},  -- orig: {'n', '<S-Tab>'},
        MkdnNextHeading = false,  -- orig: {'n', ']]'},
        MkdnPrevHeading = false,  -- orig: {'n', '[['},
        MkdnGoBack = false,  -- orig: {'n', '<BS>'},
        MkdnGoForward = false,  -- orig: {'n', '<Del>'},
        MkdnCreateLink = false, -- see MkdnEnter
        MkdnCreateLinkFromClipboard = false, -- orig: {{'n', 'v'}, 'p'}, -- see MkdnEnter
        MkdnFollowLink = false, -- see MkdnEnter
        MkdnDestroyLink = false, -- orig: {'n', '<M-CR>'},
        MkdnTagSpan = false, -- orig: {'v', '<M-CR>'},
        MkdnMoveSource = false, -- orig: {'n', '<F2>'},
        MkdnYankAnchorLink = false, -- orig: {'n', 'yaa'},
        MkdnYankFileAnchorLink = false, -- orig: {'n', 'yfa'},
        MkdnIncreaseHeading = {'n', '+'},
        MkdnDecreaseHeading = {'n', '-'},
        MkdnToggleToDo = {{'n', 'v'}, '<leader><CR>'},  -- orig: '<C-Space>'
        MkdnNewListItem = false,
        MkdnNewListItemBelowInsert = {'n', 'o'},
        MkdnNewListItemAboveInsert = {'n', 'O'},
        MkdnExtendList = false,
        MkdnUpdateNumbering = {'n', '<leader>non'},  -- orig: {'n', '<leader>non'}
        MkdnTableNextCell = false,  -- orig: {'i', '<Tab>'},
        MkdnTablePrevCell = false,  -- orig: {'i', '<S-Tab>'},
        MkdnTableNextRow = false,
        MkdnTablePrevRow = {'i', '<M-CR>'},
        MkdnTableNewRowBelow = {'n', '<leader>ntr'},  -- orig: {'n', '<leader>ir'},
        MkdnTableNewRowAbove = {'n', '<leader>ntR'},  -- orig: {'n', '<leader>iR'},
        MkdnTableNewColAfter = {'n', '<leader>ntc'},  -- orig: {'n', '<leader>ic'},
        MkdnTableNewColBefore = {'n', '<leader>ntC'},  -- orig: {'n', '<leader>iC'},
        MkdnFoldSection = false,  -- orig: {'n', '<leader>f'},
        MkdnUnfoldSection = false,  -- orig: {'n', '<leader>F'}
    }
})
