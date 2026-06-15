-- This file contains the startup options
local M = {}

M.bools = { number = true, relativenumber = false, title = true }
M.val = { shiftwidth = 4, tabstop = 4, foldlevel = 99, foldlevelstart = 1, foldnestmax = 4 }
M.strs = {
  clipboard = "unnamedplus",
  foldmethod = "expr",
  foldexpr = "v:lua.vim.treesitter.foldexpr()",
  foldtext = "",
  foldcolumn = "0",
}
M.lst = {}

-- vim.g.skip_ts_context_commentstring_module = true
return M
