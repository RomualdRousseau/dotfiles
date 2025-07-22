return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mason-org/mason.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "stylua", "prettier", "shfmt" },
        automatic_enable = true,
      })

      local null_ls = require("null-ls")

      local sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.shfmt.with({ args = { "-i", "2" } }),
      }

      local on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          local fmtgroup = vim.api.nvim_create_augroup("LspFormatting", {})
          vim.api.nvim_clear_autocmds({ group = fmtgroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = fmtgroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end

      null_ls.setup({
        sources = sources,
        on_attach = on_attach,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ruff", "jdtls" },
        automatic_enable = false,
      })

      require("lsp.lua_ls").setup()
      require("lsp.pyright").setup()
      require("lsp.ruff").setup()

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>k", "<cmd>lua vim.diagnostic.open_float()<CR>", {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {})
      vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, {})
      vim.keymap.set("n", "<leader>rf", vim.lsp.buf.format, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "<leader>rq", vim.lsp.buf.code_action, {})
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    dependencies = {
      "mason-org/mason.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    -- ft = "java",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function(args)
          require("lsp.java").setup()
        end,
      })
    end,
  },
}
