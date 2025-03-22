-- This file contains autocommands
local M = {}
-- format for autocommands event/s= {}, pattern = nil/{}, command = nil/{}, callback = func/nil
M.solo = {
  {
    events = { "TermOpen" },
    callback = function()
      vim.opt.number = false
      vim.opt.relativenumber = false
    end
  }
}
-- format for augroup [group_name] = table(similar format to autocommand)
M.grp = {}
return M
