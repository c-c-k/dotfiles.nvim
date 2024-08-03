-- Set the nvim internal python venv to be inside the nvim config because it's
-- easier to maintain this way.
vim.g.python3_host_prog = vim.fn.stdpath("config") .. "/.venv/bin/python3"

-- Set map leader to the <SPACE> key because it's convenient to press.
-- Also set local map leader to "\" because that seems to be the norm.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


