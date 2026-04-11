return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				filters = {
					git_ignored = false,
				},
				live_filter = {
					prefix = "[FILTER]: ",
					always_show_folders = false,
				},
				view = {
					width = 35,
				},
				diagnostics = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = true,
					debounce_delay = 50,
					icons = {
						hint = "H",
						info = "I",
						warning = "W",
						error = "E",
					},
				},
			})
			vim.keymap.set("n", "<C-n>", ":NvimTreeOpen<CR>", { desc = "NvimTree" })
			vim.keymap.set("n", "<leader>ft", ":NvimTreeFindFile<CR>", { desc = "NvimTree Find File" })
		end,
	},
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		config = function()
			require("oil").setup()
			vim.keymap.set("n", "<space>eo", "<CMD>Oil<CR>", { desc = "Oil Neotree" })
		end,
	},
}
