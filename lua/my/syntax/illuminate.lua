local my = require "my"
---@class my.syntax.illuminate
local M = {}

M.opts = {}
M.opts.core_integration = function() --
  my.keymap.queue_km_group_load(my.config.keymaps.g_illumint)
  M.autocmds.setup_vars()
end

function M.is_freeze_buf(bufnr) --
  return my.bp[bufnr or 0].illuminate_freeze:get_top()
end

function M.is_invisible_buf(bufnr) --
  return my.bp[bufnr or 0].illuminate_invisible:get_top()
end

function M.is_pause_buf(bufnr) --
  return my.bp[bufnr or 0].illuminate_pause:get_top()
end

function M.is_invisible_global() --
  return my.bp.illuminate_invisible:get(my.vp.GLOBAL_DEFAULT)
end

function M.is_pause_global() --
  return my.bp.illuminate_pause:get(my.vp.GLOBAL_DEFAULT)
end

function M.toggle_freeze_buf(enable) --
  my.ui.toggle.toggle_priority_var(my.bp[0].illuminate_freeze, enable)
end

function M.toggle_invisible_buf(enable) --
  my.ui.toggle.toggle_priority_var(my.bp[0].illuminate_invisible, enable)
end

function M.toggle_pause_buf(enable) --
  my.ui.toggle.toggle_priority_var(my.bp[0].illuminate_pause, enable)
end

function M.toggle_invisible_global(enable) --
  my.bp.illuminate_invisible:set(my.vp.GLOBAL_DEFAULT, enable)
end

function M.toggle_pause_global(enable) --
  my.bp.illuminate_pause:set(my.vp.GLOBAL_DEFAULT, enable)
end

M.autocmds = {}
M.autocmds.setup_vars = function() --
  local illuminate_engine = require "illuminate.engine"
  local illuminate_var_funcs = {
    illuminate_pause = {
      illuminate_engine.pause_buf,
      illuminate_engine.resume_buf,
    },
    illuminate_freeze = {
      illuminate_engine.freeze_buf,
      illuminate_engine.unfreeze_buf,
    },
    illuminate_invisible = {
      illuminate_engine.invisible_buf,
      illuminate_engine.visible_buf,
    },
  }

  local group = my.autocmd.get_augroup("my.syntax.illuminate.vars", true)
  my.autocmd.add_autocmd {
    desc = "Apply Vim.illuminate vars on buf enter",
    group = group,
    -- Using `BufEnter` because none of the other buffer events trigger for
    -- a terminal buffer opened in a new window.
    event = "BufEnter",
    callback = function(args)
      local bufnr = args.buf
      if my.buf.is_normal_or_term(bufnr) then
        for var_name, var_funcs in pairs(illuminate_var_funcs) do
          my.vars.apply_pvar_to_handles {
            handles = bufnr,
            p_scope = "bp",
            var_name = var_name,
            on_func = var_funcs[1],
            off_func = var_funcs[2],
          }
        end
      end
    end,
  }
  my.autocmd.add_autocmd {
    desc = "Apply Vim.illuminate var on var changes",
    group = group,
    event = "User",
    pattern = "MyVarModified",
    callback = function(args)
      for var_name, var_funcs in pairs(illuminate_var_funcs) do
        if args.data.var_name == var_name then
          local handles = args.data.handle or my.buf.get_normal_or_term_bufs()
          my.vars.apply_pvar_to_handles {
            handles = handles,
            p_scope = args.data.scope,
            var_name = var_name,
            on_func = var_funcs[1],
            off_func = var_funcs[2],
          }
        end
      end
    end,
  }
end

M.keymaps = {}

M.keymaps.next = { ---@type my.keymap.keymap_spec
  desc = "next <cword>",
  rhs = function() require("illuminate").goto_next_reference(true) end,
}
M.keymaps.prev = { ---@type my.keymap.keymap_spec
  desc = "prev <cword>",
  rhs = function() require("illuminate").goto_prev_reference(true) end,
}

return M
