-- This file contains autocommands
local M = {}
-- format for autocommands event/s= {}, pattern = nil/{}, command = nil/{}, callback = func/nil
M.solo = {
  {
    events = { "TermOpen" },
    callback = function()
      vim.opt.number = false
      vim.opt.relativenumber = false
    end,
  },
  {
    events = { "BufRead", "BufNewFile" },
    pattern = { "*.ejs" },
    command = "set filetype=html",
  },
  {
    events = { "BufRead", "BufNewFile" },
    pattern = { "*.js" },
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(0, 0, 50, false)
      for _, line in ipairs(lines) do
        if line:match("<%w+") then
          vim.bo.filetype = "javascriptreact"
          return
        end
      end
    end,
  },
}
-- format for augroup [group_name] = table(similar format to autocommand)
M.grp = {}
return M
