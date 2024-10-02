-- ======
-- NEOMUX
-- ======

-- repo url: <https://github.com/nikvdp/neomux>
-- nvim help: `:help neomux`

---@type LazySpec
return {
  {
    "nikvdp/neomux",
    lazy = false,
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
  },
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local astrocore = require "astrocore"
      local maps, map = require("cck.utils.config").get_astrocore_mapper()

      opts.autocmds = astrocore.extend_tbl(opts.autocmds, {
        placeholder_augroup = {
          {
            event = { "filetype" },
            pattern = "gitcommit,gitrebase,gitconfig",
            desc = "Neomux auto-del git temp buffers",
            callback = function(_) vim.opt_local.bufhidden = "delete" end,
          },
        },
      })
      map("n", "<LEADER>ott", "<CMD>Neomux<CR>", { desc = "Open terminal (PWD)" })
      map("n", "<LEADER>otl", "<CMD>lcd %:h|Neomux<CR>", { desc = "Open terminal (buffer dir)" })
      map("n", "<LEADER>oth", "<CMD>lcd ~|Neomux<CR>", { desc = "Open terminal (home)" })
      map("n", "<LEADER>oga", "<CMD>lcd %:h|Neomux<CR>lazygit&&exit<CR>", { desc = "Open Lazygit (root dir)" })

      opts.mappings = astrocore.extend_tbl(opts.mappings, maps)
    end,
  },
}
