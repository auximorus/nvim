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
  end,
}
