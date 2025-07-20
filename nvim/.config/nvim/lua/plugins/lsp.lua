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
		"neovim/nvim-lspconfig",
		-- tag = "v1.8.0",
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

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.general = {
				positionEncodings = { "utf-16" },
			}

			local lspconfig = require("lspconfig")
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
				on_attach = function(client, bufnr)
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
				end,
			})

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
				on_attach = function(client, bufnr)
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
				end,
			})
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"mason-org/mason.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
		},
		ft = "java",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.general = {
				positionEncodings = { "utf-16" },
			}

			local jdtls = require("jdtls")
			local jdtls_dap = require("jdtls.dap")
			jdtls.start_or_attach({
				capabilities = capabilities,
				cmd = {
					vim.fn.expand("$HOME/.local/share/nvim/mason/bin/jdtls"),
					("--jvm-arg=-javaagent:%s"):format(
						vim.fn.expand("$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar")
					),
				},
				on_attach = function(client, bufnr)
					jdtls.setup_dap({ hotcodereplace = "auto" })
					jdtls_dap.setup_dap_main_class_configs()
					jdtls.add_commands()
				end,
				init_options = {
					bundles = vim.split(
						vim.fn.glob("$HOME/.local/share/nvim/mason/packages/java-*/extension/server/*.jar", 1),
						"\n"
					),
				},
			})

			vim.keymap.set("n", "<leader>tc", jdtls.test_class, {})
			vim.keymap.set("n", "<leader>tm", jdtls.test_nearest_method, {})
		end,
	},
}
