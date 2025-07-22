return {
  setup = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.general = {
      positionEncodings = { "utf-16" },
    }

    local lspconfig = require("lspconfig")

    lspconfig.pyright.setup({
      capabilities = capabilities,
      settings = {
        pyright = {
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            ignore = { "*" },
          },
        },
      },
    })
  end,
}
