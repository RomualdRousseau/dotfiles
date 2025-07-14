return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		-- tag = "v1.8.0",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			-- { "mason-org/mason-lspconfig.nvim", tag = "v1.32.0" },
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright", "ruff" },
			})

			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
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
			lspconfig.ruff.setup({
				capabilities = capabilities,
				-- on_attach = function(client, bufnr)
				-- 	vim.api.nvim_create_autocmd("BufWritePre", {
				-- 		buffer = bufnr,
				-- 		callback = function()
				-- 			vim.lsp.buf.code_action({
				-- 				context = { only = { "source.fixAll" } },
				-- 				apply = true,
				-- 			})
				-- 			vim.wait(100)
				-- 		end,
				-- })
				-- end,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {})
			vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, {})
			vim.keymap.set("n", "<leader>k", "<cmd>lua vim.diagnostic.open_float()<CR>", {})
			vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>qf", vim.lsp.buf.code_action, {})
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
			})

			local null_ls = require("null-ls")
			local sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.shfmt.with({ args = { "-i", "2" } }),
			}
			null_ls.setup({
				sources = sources,
				-- on_attach = function(client, bufnr)
				--   if client.supports_method("textDocument/formatting") then
				--    vim.api.nvim_create_autocmd("BufWritePre", {
				--       buffer = bufnr,
				--       callback = function()
				--         vim.lsp.buf.format({ bufnr = bufnr })
				--         vim.wait(100)
				--       end,
				--     })
				--   end
				-- end,
			})
		end,
	},
}
