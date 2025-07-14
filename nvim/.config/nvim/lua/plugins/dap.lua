return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mason-org/mason.nvim",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap-python",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		require("mason-nvim-dap").setup({
			ensure_installed = {
				"python",
			},
			handlers = {},
		})

		local dap = require("dap")
		local dapui = require("dapui")
		local dap_python = require("dap-python")

		dap_python.setup("uv")
		dap_python.test_runner = "pytest"

		dapui.setup({})
		require("nvim-dap-virtual-text").setup({
			commented = true,
		})

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		-- dap.listeners.before.event_terminated.dapui_config = function()
	  --	 dapui.close()
		-- end
		-- dap.listeners.before.event_exited.dapui_config = function()
	  --   dapui.close()
		-- end

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<leader>dr", dap.continue, {})
		vim.keymap.set("n", "<leader>dx", dap.terminate, {})
		vim.keymap.set("n", "<leader>dt", dap_python.test_method, {})
		vim.keymap.set("n", "<leader>dT", dap_python.test_class, {})
		vim.keymap.set("n", "<leader>dd", dapui.toggle, {})
	end,
}
