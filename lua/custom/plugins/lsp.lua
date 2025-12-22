return {
  {
    "williamboman/mason-lspconfig.nvim",
    ensure_installed = {
      "lua_ls",
      "clangd",
      "pyright",
      "ts_ls",
      "jsonls",
      "html",
      "cssls",
      "solidity_ls_nomicfoundation",
      "prettier",
      "stylua",
      "black",
      "clang-format",
    },
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      {
        "b0o/schemastore.nvim", -- JSON schema source
        lazy = true,
      },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
          servers = {
            lua_ls = {}, -- keep this minimal, we'll configure the rest ourselves
          },
        },
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require("lspconfig")
      local status_ok, schemastore = pcall(require, "schemastore")

      local servers = {
        lua_ls = {},
        clangd = {},
        pyright = {},
        html = {},
        ts_ls = {
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
        cssls = {},
        jsonls = {
          settings = {
            json = {
              schemas = status_ok and schemastore.json.schemas() or nil,
              validate = { enable = true },
            },
          },
        },
        solidity_ls_nomicfoundation = {},
      }

      for server, config in pairs(servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      -- Format on save
      --vim.api.nvim_create_autocmd('LspAttach', {
      --  callback = function(args)
      --    local client = vim.lsp.get_client_by_id(args.data.client_id)
      --    if not client then return end
      --
      --    if client.supports_method('textDocument/formatting') then
      --      vim.api.nvim_create_autocmd('BufWritePre', {
      --        buffer = args.buf,
      --        callback = function()
      --          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
      --        end,
      --      })
      --    end
      --  end,
      --})
    end,
  },
}
