return {
	setup = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		capabilities.general = {
			positionEncodings = { "utf-16" },
		}

		local settings = {
			python = {
				analysis = {
					autoImportCompletions = true,
					typeCheckingMode = "basic",
					ignore = { "*" }, -- Let Ruff handle style issues
					useLibraryCodeForTypes = true,
				},
			},
		}

		local init_options = {
			settings = {
				args = {
					"--line-length=120",
				},
			},
		}

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
		end

		vim.lsp.config("pyright", {
			capabilities = capabilities,
			settings = settings,
		})

		vim.lsp.config("ruff", {
			capabilities = capabilities,
			init_options = init_options,
			on_attach = on_attach,
		})
	end,
}
