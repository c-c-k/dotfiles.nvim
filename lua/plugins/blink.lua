local my = require "my"

---@type LazyPluginSpec
local spec_blink_cmp = {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<CR>"] = {
        function(cmp)
          if vim.fn.win_gettype() ~= "command" then return cmp.accept() end
        end,
        "fallback",
      },
      ["<C-A>"] = {
        "select_and_accept",
        "fallback",
      },
      ["<C-Y>"] = {
        "select_and_accept",
        "fallback",
      },
      ["<C-H>"] = {
        "show_documentation",
        "hide_documentation",
        "show_signature",
        "hide_signature",
        "fallback",
      },
      ["<C-L>"] = {
        -- Toggle flag for <C-J> and <C-K> scrolling help or completion list
        function(cmp)
          if cmp.is_menu_visible() then
            vim.b.my_cmp_scroll_doc = not vim.b.my_cmp_scroll_doc
            return true
          end
        end,
        "fallback",
      },
      ["<C-J>"] = {
        function(cmp)
          if cmp.is_menu_visible() then
            if vim.b.my_cmp_scroll_doc then return cmp.scroll_documentation_down(4) end
          end
        end,
        "select_next",
        "fallback",
      },
      ["<C-K>"] = {
        function(cmp)
          if cmp.is_menu_visible() then
            if vim.b.my_cmp_scroll_doc then return cmp.scroll_documentation_up(4) end
          end
        end,
        "select_prev",
        "fallback",
      },
      ["<Tab>"] = {
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = {
        "snippet_backward",
        "fallback",
      },
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
  },
}

---@type LazyPluginSpec
local spec_blink_cmp__astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local astromaps = opts.mappings
    local maps, map = my.keymap.get_astrocore_mapper()

    map("n", "<LEADER>uc", { copy = { "n", "<Leader>uc", source = astromaps } }) -- desc = "Toggle autocompletion (buffer)"
    map("n", "<LEADER>uC", { copy = { "n", "<Leader>uC", source = astromaps } }) -- desc = "Toggle autocompletion (global)"

    opts.mappings = my.tbl.merge("dDFn", opts.mappings, maps)
  end,
}

spec_blink_cmp.specs = {
  spec_blink_cmp__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_blink_cmp,
}
