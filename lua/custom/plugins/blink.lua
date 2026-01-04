return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },

  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
    ghost_text = { enabled = true },
  },

  config = function()
    local blink_cmp = require("blink.cmp")

    vim.api.nvim_create_autocmd("InsertEnter", {
      callback = function()
        blink_cmp.show()
      end,
    })

    local function completion_visible()
      return blink_cmp.is_menu_visible()
    end

    vim.keymap.set("i", "<C-y>", function()
      if completion_visible() then
        return blink_cmp.select_and_accept()
      end
    end, { expr = true, noremap = true, silent = true })

    vim.keymap.set("i", "<Tab>", function()
      if completion_visible() then
        return blink_cmp.select_next()
      else
        return "<Tab>"
      end
    end, { expr = true, noremap = true, silent = true })

    vim.keymap.set("i", "<S-Tab>", function()
      if completion_visible() then
        return blink_cmp.select_prev()
      else
        return "<S-Tab>"
      end
    end, { expr = true, noremap = true, silent = true })
    require("blink.cmp").setup()
  end,
}
