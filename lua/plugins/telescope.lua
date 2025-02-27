return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
			require("which-key").add({ { "<leader>f", group = "Telescope & Flash" } })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"sudormrfbin/cheatsheet.nvim",
		dependencies = { "nvim-lua/popup.nvim" },
		config = function()
			require("cheatsheet").setup({
				vim.keymap.set("n", "<leader>cc", ":Cheatsheet<CR>", { desc = "Cheatsheet shortcuts" }),
			})
		end,
	},
}
