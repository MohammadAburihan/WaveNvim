return {
	"voldikss/vim-floaterm",
	config = function()
		vim.cmd([[let g:floaterm_width=0.85]])
		vim.cmd([[let g:floaterm_height=0.85]])
		vim.cmd([[let g:floaterm_autoclose=1]])
		require("which-key").add({ { "<leader>t", group = "Terminal" } })
		vim.keymap.set(
			"t",
			"<leader>tt",
			"<C-\\><C-n>:FloatermToggle<CR>",
			{ desc = "ToggleTerm", noremap = true, silent = true }
		)
		vim.keymap.set("n", "<leader>tn", ":FloatermNew<CR>", { desc = "FloatTermNew" })
		vim.keymap.set("n", "<leader>tt", ":FloatermToggle<CR>", { desc = "ToggleTerm" })
	end,
}
