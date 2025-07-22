return {
  setup = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.general = {
      positionEncodings = { "utf-16" },
    }

    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
    })
  end,
}
