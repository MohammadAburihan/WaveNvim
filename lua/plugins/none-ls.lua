return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		event = "VeryLazy",
		opts = function()
			return require("configs.null-ls"),
				vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Formatting" })
		end,
	},
}
