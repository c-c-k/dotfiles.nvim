-- MEMO: If changing the setup signature also update it in `my.setup.__call`
---@param opts my.setup.setup_opts_spec
return function(opts)
  -- TODO: Add global setup options for my utility scripts?
  if opts and not vim.tbl_isempty(opts) then --
    vim.print("Null plugin opts: ", opts)
  end
end
