return {
	setup = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		capabilities.general = {
			positionEncodings = { "utf-16" },
		}

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
		})
		vim.lsp.enable("lua_ls")
	end,
}
