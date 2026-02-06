return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*",
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  config = function()
    local ls = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { "~/.config/nvim/snippets/es7-react" },
    })
    ls.filetype_extend("javascriptreact", { "javascript" })
    ls.filetype_extend("javascript", { "javascriptreact" })
    ls.setup({ snippets = { filetypes = { "ejs" } } })
  end,
}
