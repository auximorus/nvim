return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  opts = {
    format_on_save = {
      timeout_ms = 3000,
      lsp_fallback = false,
    },
    formatters_by_ft = {
      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      javascriptreact = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      lua = { "stylua" },
      python = { "black" },
      c = { "clang-format" },
      cpp = { "clang-format" },
    },
  },
}
