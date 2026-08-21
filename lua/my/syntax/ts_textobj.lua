---@class MySyntaxTreesitterTextobjects
local M = {}
M.init = { no_init = false, recurse = false } ---@type MyModuleInit

local my = require "my"

M.init.plugins = function()
  local specks = my.config.lzsetup_plugin_specs

  specks[#specks + 1] = M._spec_ts_textobj
end

M._spec_ts_textobj = function()
  local make_lzspec = my.setup.lazy_nvim.resolve_spec
  local plugins = my.config.lzplugins_manifest
  local spec = make_lzspec {
    source = plugins["nvim-treesitter-textobjects"],
    init = function() --
      vim.api.nvim_set_var("no_plugin_maps", true)
    end,
    opts = {
      set_jumps = true,
    },
    config = function(_, opts) --
      require("nvim-treesitter-textobjects").setup(opts)

      M._init_shorcut_vars()

      my.keymap.queue_km_group_load(my.config.keymaps.g_nv_ts_to)
    end,
  }
  return spec
end

---@module "nvim-treesitter-textobjects.select"
local ts_select = my.setup.utils.requires_init "ts_select"
---@module "nvim-treesitter-textobjects.swap"
local ts_swap = my.setup.utils.requires_init "ts_swap"
---@module "nvim-treesitter-textobjects.move"
local ts_move = my.setup.utils.requires_init "ts_move"
---@module "nvim-treesitter-textobjects.repeatable_move"
local ts_repeat_move = my.setup.utils.requires_init "ts_repeat_move"

M._init_shorcut_vars = function()
  ts_select = require "nvim-treesitter-textobjects.select"
  ts_swap = require "nvim-treesitter-textobjects.swap"
  ts_move = require "nvim-treesitter-textobjects.move"
  ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"
end

M.keymaps = {}

-- map: "ic", { "x", "o" }, M.keymaps.select_class_inner
M.keymaps.select_class_inner = {
  desc = "inner class",
  rhs = function() ts_select.select_textobject("@class.inner", "textobjects") end,
}
-- map: "ac", { "x", "o" }, M.keymaps.select_class_outer
M.keymaps.select_class_outer = {
  desc = "outer class",
  rhs = function() ts_select.select_textobject("@class.outer", "textobjects") end,
}
-- map: "i?", { "x", "o" }, M.keymaps.select_conditional_inner
M.keymaps.select_conditional_inner = {
  desc = "inner conditional",
  rhs = function() ts_select.select_textobject("@conditional.inner", "textobjects") end,
}
-- map: "a?", { "x", "o" }, M.keymaps.select_conditional_outer
M.keymaps.select_conditional_outer = {
  desc = "outer conditional",
  rhs = function() ts_select.select_textobject("@conditional.outer", "textobjects") end,
}
-- map: "az", { "x", "o" }, M.keymaps.select_fold
M.keymaps.select_fold = {
  desc = "fold",
  rhs = function() ts_select.select_textobject("@fold", "folds") end,
}
-- map: "if", { "x", "o" }, M.keymaps.select_function_inner
M.keymaps.select_function_inner = {
  desc = "inner function",
  rhs = function() ts_select.select_textobject("@function.inner", "textobjects") end,
}
-- map: "af", { "x", "o" }, M.keymaps.select_function_outer
M.keymaps.select_function_outer = {
  desc = "outer function",
  rhs = function() ts_select.select_textobject("@function.outer", "textobjects") end,
}
-- map: "io", { "x", "o" }, M.keymaps.select_loop_inner
M.keymaps.select_loop_inner = {
  desc = "inner loop",
  rhs = function() ts_select.select_textobject("@loop.inner", "textobjects") end,
}
-- map: "ao", { "x", "o" }, M.keymaps.select_loop_outer
M.keymaps.select_loop_outer = {
  desc = "outer loop",
  rhs = function() ts_select.select_textobject("@loop.outer", "textobjects") end,
}
-- map: "ix", { "x", "o" }, M.keymaps.select_parameter_inner
M.keymaps.select_parameter_inner = {
  desc = "inner parameter (x)",
  rhs = function() ts_select.select_textobject("@parameter.inner", "textobjects") end,
}
-- map: "ax", { "x", "o" }, M.keymaps.select_parameter_outer
M.keymaps.select_parameter_outer = {
  desc = "outer parameter (x)",
  rhs = function() ts_select.select_textobject("@parameter.outer", "textobjects") end,
}
-- map: "ak", { "x", "o" }, M.keymaps.select_scope
M.keymaps.select_scope = {
  desc = "scope (skope)",
  rhs = function() ts_select.select_textobject("@local.scope", "locals") end,
}
-- map: "<leader>sw", "n", M.keymaps.swap_next_parameter_inner
M.keymaps.swap_next_parameter_inner = {
  desc = "swap next parameter inner",
  rhs = function() ts_swap.swap_next("@parameter.inner", "textobjects") end,
}
-- map: "<leader>sW", "n", M.keymaps.swap_next_parameter_outer
M.keymaps.swap_next_parameter_outer = {
  desc = "swap next parameter outer",
  rhs = function() ts_swap.swap_next("@parameter.outer", "textobjects") end,
}
-- map: "<leader>sb", "n", M.keymaps.swap_previous_parameter_inner
M.keymaps.swap_previous_parameter_inner = {
  desc = "swap previous parameter inner",
  rhs = function() ts_swap.swap_previous("@parameter.inner", "textobjects") end,
}
-- map: "<leader>sB", "n", M.keymaps.swap_previous_parameter_outer
M.keymaps.swap_previous_parameter_outer = {
  desc = "swap previous parameter outer",
  rhs = function() ts_swap.swap_previous("@parameter.outer", "textobjects") end,
}

-- map: "][", { "n", "x", "o" }, M.keymaps.goto_class_next_end_outer
M.keymaps.goto_class_next_end_outer = {
  desc = "goto class next end outer",
  rhs = function() ts_move.goto_next_end("@class.outer", "textobjects") end,
}
-- map: "]]", { "n", "x", "o" }, M.keymaps.goto_class_next_start_outer
M.keymaps.goto_class_next_start_outer = {
  desc = "goto class next start outer",
  rhs = function() ts_move.goto_next_start("@class.outer", "textobjects") end,
}
-- map: "[]", { "n", "x", "o" }, M.keymaps.goto_class_prev_end_outer
M.keymaps.goto_class_prev_end_outer = {
  desc = "goto class prev end outer",
  rhs = function() ts_move.goto_previous_end("@class.outer", "textobjects") end,
}
-- map: "[[", { "n", "x", "o" }, M.keymaps.goto_class_prev_start_outer
M.keymaps.goto_class_prev_start_outer = {
  desc = "goto class prev start outer",
  rhs = function() ts_move.goto_previous_start("@class.outer", "textobjects") end,
}
-- map: "]/", { "n", "x", "o" }, M.keymaps.goto_conditional_next_end_outer
M.keymaps.goto_conditional_next_end_outer = {
  desc = "goto conditional next end outer",
  rhs = function() ts_move.goto_next_end("@conditional.outer", "textobjects") end,
}
-- map: "]?", { "n", "x", "o" }, M.keymaps.goto_conditional_next_start_outer
M.keymaps.goto_conditional_next_start_outer = {
  desc = "goto conditional next start outer",
  rhs = function() ts_move.goto_next_start("@conditional.outer", "textobjects") end,
}
-- map: "[/", { "n", "x", "o" }, M.keymaps.goto_conditional_prev_end_outer
M.keymaps.goto_conditional_prev_end_outer = {
  desc = "goto conditional prev end outer",
  rhs = function() ts_move.goto_previous_end("@conditional.outer", "textobjects") end,
}
-- map: "[?", { "n", "x", "o" }, M.keymaps.goto_conditional_prev_start_outer
M.keymaps.goto_conditional_prev_start_outer = {
  desc = "goto conditional prev start outer",
  rhs = function() ts_move.goto_previous_start("@conditional.outer", "textobjects") end,
}
-- map: "]Z", { "n", "x", "o" }, M.keymaps.goto_fold_next
M.keymaps.goto_fold_next = {
  desc = "goto fold next",
  rhs = function() ts_move.goto_next_start("@fold", "folds") end,
}
-- map: "[Z", { "n", "x", "o" }, M.keymaps.goto_fold_prev
M.keymaps.goto_fold_prev = {
  desc = "goto fold prev",
  rhs = function() ts_move.goto_previous_start("@fold", "folds") end,
}
-- map: "]F", { "n", "x", "o" }, M.keymaps.goto_function_next_end_outer
M.keymaps.goto_function_next_end_outer = {
  desc = "goto function next end outer",
  rhs = function() ts_move.goto_next_end("@function.outer", "textobjects") end,
}
-- map: "]f", { "n", "x", "o" }, M.keymaps.goto_function_next_start_outer
M.keymaps.goto_function_next_start_outer = {
  desc = "goto function next start outer",
  rhs = function() ts_move.goto_next_start("@function.outer", "textobjects") end,
}
-- map: "[F", { "n", "x", "o" }, M.keymaps.goto_function_prev_end_outer
M.keymaps.goto_function_prev_end_outer = {
  desc = "goto function prev end outer",
  rhs = function() ts_move.goto_previous_end("@function.outer", "textobjects") end,
}
-- map: "[f", { "n", "x", "o" }, M.keymaps.goto_function_prev_start_outer
M.keymaps.goto_function_prev_start_outer = {
  desc = "goto function prev start outer",
  rhs = function() ts_move.goto_previous_start("@function.outer", "textobjects") end,
}
-- map: "]O", { "n", "x", "o" }, M.keymaps.goto_loop_next_end_outer
M.keymaps.goto_loop_next_end_outer = {
  desc = "goto loop next end outer",
  rhs = function() ts_move.goto_next_end("@loop.outer", "textobjects") end,
}
-- map: "]o", { "n", "x", "o" }, M.keymaps.goto_loop_next_start_outer
M.keymaps.goto_loop_next_start_outer = {
  desc = "goto loop next start outer",
  rhs = function() ts_move.goto_next_start("@loop.outer", "textobjects") end,
}
-- map: "[O", { "n", "x", "o" }, M.keymaps.goto_loop_prev_end_outer
M.keymaps.goto_loop_prev_end_outer = {
  desc = "goto loop prev end outer",
  rhs = function() ts_move.goto_previous_end("@loop.outer", "textobjects") end,
}
-- map: "[o", { "n", "x", "o" }, M.keymaps.goto_loop_prev_start_outer
M.keymaps.goto_loop_prev_start_outer = {
  desc = "goto loop prev start outer",
  rhs = function() ts_move.goto_previous_start("@loop.outer", "textobjects") end,
}
-- map: "]X", { "n", "x", "o" }, M.keymaps.goto_parameter_next_end_outer
M.keymaps.goto_parameter_next_end_outer = {
  desc = "goto parameter next end outer",
  rhs = function() ts_move.goto_next_end("@parameter.outer", "textobjects") end,
}
-- map: "]x", { "n", "x", "o" }, M.keymaps.goto_parameter_next_start_outer
M.keymaps.goto_parameter_next_start_outer = {
  desc = "goto parameter next start outer",
  rhs = function() ts_move.goto_next_start("@parameter.outer", "textobjects") end,
}
-- map: "[X", { "n", "x", "o" }, M.keymaps.goto_parameter_prev_end_outer
M.keymaps.goto_parameter_prev_end_outer = {
  desc = "goto parameter prev end outer",
  rhs = function() ts_move.goto_previous_end("@parameter.outer", "textobjects") end,
}
-- map: "[x", { "n", "x", "o" }, M.keymaps.goto_parameter_prev_start_outer
M.keymaps.goto_parameter_prev_start_outer = {
  desc = "goto parameter prev start outer",
  rhs = function() ts_move.goto_previous_start("@parameter.outer", "textobjects") end,
}
-- map: "]K", { "n", "x", "o" }, M.keymaps.goto_scope_next_end
M.keymaps.goto_scope_next_end = {
  desc = "goto scope next end",
  rhs = function() ts_move.goto_next_end("@local.scope", "locals") end,
}
-- map: "]k", { "n", "x", "o" }, M.keymaps.goto_scope_next_start
M.keymaps.goto_scope_next_start = {
  desc = "goto scope next start",
  rhs = function() ts_move.goto_next_start("@local.scope", "locals") end,
}
-- map: "[K", { "n", "x", "o" }, M.keymaps.goto_scope_prev_end
M.keymaps.goto_scope_prev_end = {
  desc = "goto scope prev end",
  rhs = function() ts_move.goto_previous_end("@local.scope", "locals") end,
}
-- map: "[k", { "n", "x", "o" }, M.keymaps.goto_scope_prev_start
M.keymaps.goto_scope_prev_start = {
  desc = "goto scope prev start",
  rhs = function() ts_move.goto_previous_start("@local.scope", "locals") end,
}

-- map: ";", { "n", "x", "o" }, M.keymaps.repeat_last_move
M.keymaps.repeat_last_move = {
  desc = "repeat last movement",
  rhs = function()
    -- ts_repeat_move.repeat_last_move_next()
    ts_repeat_move.repeat_last_move()
  end,
}
-- map: ",", { "n", "x", "o" }, M.keymaps.repeat_last_move_opposite
M.keymaps.repeat_last_move_opposite = {
  desc = "repeat last movement (opposite)",
  rhs = function()
    -- ts_repeat_move.repeat_last_move_previous()
    ts_repeat_move.repeat_last_move_opposite()
  end,
}
-- map: "f", { "n", "x", "o" }, M.keymaps.builtin_f_expr
M.keymaps.builtin_f_expr = {
  desc = "TS `f` override",
  expr = true,
  rhs = function() return ts_repeat_move.builtin_f_expr() end,
}
-- map: "F", { "n", "x", "o" }, M.keymaps.builtin_s_f_expr
M.keymaps.builtin_s_f_expr = {
  desc = "TS `F` override",
  expr = true,
  rhs = function() return ts_repeat_move.builtin_F_expr() end,
}
-- map: "t", { "n", "x", "o" }, M.keymaps.builtin_t_expr
M.keymaps.builtin_t_expr = {
  desc = "TS `t` override",
  expr = true,
  rhs = function() return ts_repeat_move.builtin_t_expr() end,
}
-- map: "T", { "n", "x", "o" }, M.keymaps.builtin_s_t_expr
M.keymaps.builtin_s_t_expr = {
  desc = "TS `T` override",
  expr = true,
  rhs = function() return ts_repeat_move.builtin_T_expr() end,
}

return M
