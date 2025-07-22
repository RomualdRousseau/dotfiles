return {
  setup = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.general = {
      positionEncodings = { "utf-16" },
    }

    local lspconfig = require("lspconfig")

    local on_attach = function(client, bufnr)
      local fmtgroup = vim.api.nvim_create_augroup("LspFormatting", {})
      vim.api.nvim_clear_autocmds({ group = fmtgroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = fmtgroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
          vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
          vim.wait(100)
        end,
      })

      local dap_python = require("dap-python")
      vim.keymap.set("n", "<leader>tc", dap_python.test_class, {})
      vim.keymap.set("n", "<leader>tm", dap_python.test_method, {})
    end

    lspconfig.ruff.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}
