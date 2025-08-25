return {
	{
		"voldikss/vim-floaterm",
		config = function()
			vim.cmd([[let g:floaterm_width=0.85]])
			vim.cmd([[let g:floaterm_height=0.85]])
			vim.cmd([[let g:floaterm_autoclose=1]])
			require("which-key").add({ { "<leader>t", group = "Terminal & Tabs" } })
			vim.keymap.set(
				"t",
				"<leader>tt",
				"<C-\\><C-n>:FloatermToggle<CR>",
				{ desc = "ToggleTerm", noremap = true, silent = true }
			)
			vim.keymap.set(
				"t",
				"<leader>tn",
				"<C-\\><C-n>:FloatermNext<CR>",
				{ desc = "TermNext", noremap = true, silent = true }
			)
			vim.keymap.set(
				"t",
				"<leader>tp",
				"<C-\\><C-n>:FloatermPrev<CR>",
				{ desc = "TermPrev", noremap = true, silent = true }
			)
			vim.keymap.set("n", "<leader>tn", ":FloatermNew<CR>", { desc = "FloatTermNew" })
			vim.keymap.set("n", "<leader>tt", ":FloatermToggle<CR>", { desc = "ToggleTerm" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			-- setup gitsigns with default properties
			require("gitsigns").setup({})

			-- Set a vim motion to <Space> + g + h to preview changes to the file under the cursor in normal mode
			vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "[G]it Preview [H]unk" })
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			require("which-key").add({ { "<leader>g", group = "Git" } })
			-- Set a vim motion to <Space> + g + b to view the most recent contributers to the file
			vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", { desc = "[G]it [B]lame" })
			-- Set a vim motion to <Space> + g + <Shift>A to all files changed to the staging area
			vim.keymap.set("n", "<leader>gA", ":Git add .<cr>", { desc = "[G]it Add [A]ll" })
			-- Set a vim motion to <Space> + g + a to add the current file and changes to the staging area
			vim.keymap.set("n", "<leader>ga", "Git add", { desc = "[G]it [A]dd" })
			-- Set a vim motion to <Space> + g + c to commit the current chages
			vim.keymap.set("n", "<leader>gc", ":Git commit", { desc = "[G]it [C]ommit" })
			-- Set a vim motion to <Space> + g + p to push the commited changes to the remote repository
			vim.keymap.set("n", "<leader>gp", "Git push", { desc = "[G]it [P]ush" })
		end,
	},
}
