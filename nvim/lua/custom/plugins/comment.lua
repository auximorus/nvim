return {
  'numToStr/Comment.nvim',
  opts = {
    mappings = {
      basic = false,
      extra = false,
    },
  },
  config = function()
    local api = require("Comment.api")

    vim.keymap.set('i', '<C-/>', api.toggle.linewise.current)
    vim.keymap.set('n', '<leader>/', api.toggle.linewise.current)

    vim.keymap.set('v', '<leader>/', function()
      local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
      vim.api.nvim_feedkeys(esc, 'x', false) -- Exit visual mode

      local line_start = vim.fn.getpos("'<")[2]
      local line_end = vim.fn.getpos("'>")[2]

      if line_start > line_end then
        line_start, line_end = line_end, line_start
      end

      api.toggle.linewise(vim.fn.visualmode(), { line_start, line_end })
    end, { noremap = true, silent = true })
  end
}
