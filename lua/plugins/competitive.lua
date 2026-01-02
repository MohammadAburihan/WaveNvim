return {
	{
		"A7lavinraj/assistant.nvim",
		lazy = false,
		keys = {
			{ "<leader>aa", "<cmd>Assistant<cr>", desc = "Assistant.nvim" },
		},
		opts = {},
		config = function()
			require("which-key").add({ { "<leader>a", group = "Competitive" } })
		end,
	},
}
