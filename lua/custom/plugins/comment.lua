return {
  "numToStr/Comment.nvim",
  opts = {
    mappings = {
      basic = false,
      extra = false,
    },
  },
  config = function()
    local api = require("Comment.api")

    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })

    -- Keymaps
    vim.keymap.set("i", "<C-/>", api.toggle.linewise.current)
    vim.keymap.set("n", "<leader>/", api.toggle.linewise.current)

    vim.keymap.set("v", "<leader>/", function()
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
      vim.api.nvim_feedkeys(esc, "x", false)

      local line_start = vim.fn.getpos("'<")[2]
      local line_end = vim.fn.getpos("'>")[2]

      if line_start > line_end then
        line_start, line_end = line_end, line_start
      end

      api.toggle.linewise(vim.fn.visualmode(), { line_start, line_end })
    end, { noremap = true, silent = true })
  end,
}
