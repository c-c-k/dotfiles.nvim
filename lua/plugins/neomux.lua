---@type LazyPluginSpec
local spec_neomux = {
  "nikvdp/neomux",
  init = function()
    vim.fn.serverstart "nvim.neomux"
    vim.g["neomux_start_term_map"] = false
    vim.g["neomux_start_term_split_map"] = false
    vim.g["neomux_start_term_vsplit_map"] = false
    vim.g["neomux_winjump_map_prefix"] = false
    vim.g["neomux_winswap_map_prefix"] = false
    vim.g["neomux_yank_buffer_map"] = false
    vim.g["neomux_paste_buffer_map"] = false
    vim.g["neomux_term_sizefix_map"] = vim.g.usermapleader .. "tf"
    vim.g["neomux_exit_term_mode_map"] = false
    vim.g["neomux_default_shell"] = vim.env.SHELL
    vim.g["neomux_win_num_status"] = "W:[%{WindowNumber()}]"
    vim.g["neomux_dont_fix_term_ctrlw_map"] = 1
    vim.g["neomux_no_exit_term_map"] = 1
    vim.g["neomux_hitenter_fix"] = 0
  end,
}

---@type LazyPluginSpec
local spec_neomux__astrocore = {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"
    local my = require "my"
    local maps, map = my.keymap.get_astrocore_mapper()

    local aug_my_neomux_autodel_git_temp_buf = my.autocmd.get_augroup {
      name = "aug_my_neomux_autodel_git_temp_buf",
      clear = true,
    }
    my.autocmd.add_autocmd {
      group = aug_my_neomux_autodel_git_temp_buf,
      event = { "filetype" },
      pattern = "gitcommit,gitrebase,gitconfig",
      desc = "Neomux auto-del git temp buffers",
      callback = function(_) vim.opt_local.bufhidden = "delete" end,
    }

    map("n", "<LEADER>ott", "<CMD>Neomux<CR>", { desc = "Open terminal (PWD)" })
    map("n", "<LEADER>otl", "<CMD>lcd %:h|Neomux<CR>", { desc = "Open terminal (buffer dir)" })
    map("n", "<LEADER>oth", "<CMD>lcd ~|Neomux<CR>", { desc = "Open terminal (home)" })
    map("n", "<LEADER>oga", "<CMD>lcd %:h|Neomux<CR>lazygit&&exit<CR>", { desc = "Open Lazygit (root dir)" })

    opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
  end,
}

spec_neomux.specs = {
  spec_neomux__astrocore,
}

---@type LazyPluginSpec[]
return {
  spec_neomux,
}
