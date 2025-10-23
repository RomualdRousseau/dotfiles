-- return {
--   "BeatScherrer/just.nvim",
--   dependencies = {
--     "nvim-telescope/telescope.nvim",
--   },
--   config = function()
--     require("just").setup()
--     require("telescope").load_extension("just")
--     vim.keymap.set("n", "<leader>fj", require("telescope.recipePicker").recipePicker, {})
--   end,
-- }
return {
	"al1-ce/just.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"al1-ce/jsfunc.nvim",
	},
	config = true,
}
