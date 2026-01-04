require("config.lazy_nvim")
require("core")
require("config.filetypes")
vim.opt.termguicolors = true
vim.notify = require("notify")
require("bufferline").setup({})
