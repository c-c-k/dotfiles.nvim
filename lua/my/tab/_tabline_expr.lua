local my = require "my"
---@class my.tab._tabline_expr
local M = {}

local jump_labels = my.g.tab_labels

---@type (fun(name: string, bufnr: integer): (boolean, string))[]
local buf_name_filters = {}
--- Set nvim help buffer names to `help:<help file>`
buf_name_filters[#buf_name_filters + 1] = function(name, bufnr)
  if vim.bo[bufnr].filetype ~= "help" then return false, name end
  name = "help:" .. vim.fs.basename(name):gsub(".txt$", "")
  return true, name
end
--- Set Lua buffer names like `.../mymod/init.lua` to `.../mymod,lua`
buf_name_filters[#buf_name_filters + 1] = function(name, bufnr)
  if
    vim.bo[bufnr].filetype ~= "lua" --
    or vim.fs.basename(name) ~= "init.lua"
  then
    return false, name
  end
  local dir = vim.iter(vim.fs.parents(name)):next()
  if dir and dir ~= "." and dir ~= "/" then name = dir .. ",lua" end
  return false, name
end

local function buf_name(bufnr)
  local name = vim.fn.bufname(bufnr)
  local done = false

  for _, filter in ipairs(buf_name_filters) do
    done, name = filter(name, bufnr)
    if done then break end
  end

  return name
end

--- Standardize the tab name to `tab_width` chars
local function standarize_tab_name(name, tab_width)
  if name:len() > tab_width then
    name = ".." .. name:sub(-tab_width + 2)
    -- local base_name = vim.fs.basename(name)
    -- if base_name:len() > tab_width then
    --   local prefix = math.floor((tab_width - 2) / 2)
    --   local suffix = tab_width - prefix - 2
    --   name = base_name:sub(1, prefix) .. ".." .. base_name:sub(-suffix)
    -- else
    --   name = ".." .. name:sub(tab_width - 2)
    -- end
  else
    name = name .. "%#NonText#" .. string.rep(".", tab_width - name:len(), "")
  end
  return name
end

local function get_tabpage_label(tab_num, tab_width)
  local tab_id = vim.api.nvim_list_tabpages()[tab_num]
  local tp_items = {}
  local buflist = vim.fn.tabpagebuflist(tab_num)
  local cur_tab = tab_num == vim.fn.tabpagenr()
  local alt_tab = tab_num == vim.fn.tabpagenr "#"
  local tab_name = my.t[tab_id].name ---@type string
  local jump_label_hl = (cur_tab or alt_tab) and "TabLineSel" or "Title"
  local modified_hl = cur_tab and "TabLineSel" or "TabLine"
  local name_hl = (cur_tab and "TabLineSel") or (tab_name and "Underlined") or "TabLine"

  -- Add tab jump label
  local jump_label = tab_num < jump_labels:len() and jump_labels:sub(tab_num, tab_num) or " "
  tp_items[#tp_items + 1] = string.format("%%#%s#%s", jump_label_hl, jump_label)

  -- Add mark for unsaved buffers in tabpage.
  local bufs_modified = vim.iter(buflist):any(function(_bufnr) return vim.bo[_bufnr].modified end)
  tp_items[#tp_items + 1] = string.format("%%#%s#%s", modified_hl, bufs_modified and "+" or "*")

  -- Add tab file name label
  local winnr = vim.fn.tabpagewinnr(tab_num)
  local bufnr = buflist[winnr]
  local name ---@type string
  -- -1 for jump label, -1 for buffer modified label, -1 for separator
  tab_width = tab_width - 3
  if tab_width > 3 then
    name = tab_name or buf_name(bufnr) or ""
    name = standarize_tab_name(name, tab_width)
  else
    name = string.rep(".", tab_width, "")
  end
  tp_items[#tp_items + 1] = string.format("%%#%s#%s", name_hl, name)

  -- Add inter tab separator
  tp_items[#tp_items + 1] = tab_num == vim.fn.tabpagenr "$" and "" or "%#NonText#|"

  return table.concat(tp_items, "")
end

function M.tabline_expression()
  local tl_items = {}
  -- -2 width for the tab closing "X" in the end and a single visual space before it.
  local tab_width = math.floor((vim.o.columns - 2) / vim.fn.tabpagenr "$")

  for tab_num = 1, vim.fn.tabpagenr "$" do
    -- Set the tab page number
    tl_items[#tl_items + 1] = string.format("%%%dT", tab_num)
    -- Select the highlighting
    tl_items[#tl_items + 1] = tab_num == vim.fn.tabpagenr() and "%#TabLineSel#" or "%#TabLine#"
    -- Set the tab page label
    -- tl_items[#tl_items + 1] = string.format(" %s ", get_tabpage_label(tab_num))
    tl_items[#tl_items + 1] = string.format("%s", get_tabpage_label(tab_num, tab_width))
  end

  -- after the last tab fill with TabLineFill and reset tab page nr
  tl_items[#tl_items + 1] = "%#TabLineFill#%T"
  -- right-align the label to close the current tab page
  if vim.fn.tabpagenr "$" >= 1 then tl_items[#tl_items + 1] = "%=%#TabLine#%999XX" end

  return table.concat(tl_items, "")
end

return M
