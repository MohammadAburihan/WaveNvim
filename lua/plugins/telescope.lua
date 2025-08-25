return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set(
				"n",
				"<leader>fu",
				':lua require("telescope.builtin").lsp_references()<CR>',
				{ noremap = true, silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>fe",
				"<CMD>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
				{ desc = "Live exactly grep" }
			)
			vim.keymap.set("n", "<leader>fi", function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "Search in current file" })
			require("which-key").add({ { "<leader>f", group = "Telescope & Flash" } })
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = false, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
				defaults = {
					sorting_strategy = "ascending",
					layout_config = {
						prompt_position = "top",
					},
					path_display = { "smart" },
				},
			})
			require("telescope").load_extension("fzf")
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
		"nvim-telescope/telescope-live-grep-args.nvim",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
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
