return {
  setup = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.general = {
      positionEncodings = { "utf-16" },
    }

    local cmd = {
      vim.fn.expand("$HOME/.local/share/nvim/mason/bin/jdtls"),
      ("--jvm-arg=-javaagent:%s"):format(vim.fn.expand("$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar")),
    }

    local init_options = {
      bundles = vim.split(vim.fn.glob("$HOME/.local/share/nvim/mason/packages/java-*/extension/server/*.jar", 1), "\n"),
    }

    local on_attach = function(client, bufnr)
      local jdtls = require("jdtls")
      local jdtls_dap = require("jdtls.dap")
      jdtls.setup_dap({ hotcodereplace = "auto" })
      jdtls_dap.setup_dap_main_class_configs()
      -- jdtls.add_commands()
    end

    require("jdtls").start_or_attach({
      capabilities = capabilities,
      cmd = cmd,
      on_attach = on_attach,
      init_options = init_options,
    })
  end,
}
