require("config.lazy_nvim")
require("core")
require("config.filetypes")
require("bufferline").setup({})

vim.o.exrc = true
vim.o.secure = true
vim.opt.termguicolors = true
vim.notify = require("notify")
vim.g.skip_ts_context_commentstring_module = true
