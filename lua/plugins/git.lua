return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				open_mapping = nil, -- we define our own mappings below
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				terminal_mappings = true,
				persist_size = true,
				persist_mode = true,
				direction = "horizontal", -- default direction
				close_on_exit = true,
				shell = vim.o.shell,
				float_opts = {
					border = "rounded",
					winblend = 0,
				},
			})

			local Terminal = require("toggleterm.terminal").Terminal

			-- Horizontal terminal
			local horizontal = Terminal:new({
				direction = "horizontal",
				hidden = true,
			})

			-- Floating terminal
			local floating = Terminal:new({
				direction = "float",
				hidden = true,
			})

			function _HORIZONTAL_TOGGLE()
				horizontal:toggle()
			end

			function _FLOAT_TOGGLE()
				floating:toggle()
			end

			-- Normal mode mappings
			vim.keymap.set(
				"n",
				"<leader>th",
				"<cmd>lua _HORIZONTAL_TOGGLE()<CR>",
				{ desc = "Toggle horizontal terminal" }
			)
			vim.keymap.set("n", "<leader>tf", "<cmd>lua _FLOAT_TOGGLE()<CR>", { desc = "Toggle floating terminal" })

			-- Terminal mode mappings
			vim.keymap.set(
				"t",
				"<C-h>",
				"<cmd>lua _HORIZONTAL_TOGGLE()<CR>",
				{ desc = "Toggle horizontal terminal" }
			)
			vim.keymap.set("t", "<C-l>", "<cmd>lua _FLOAT_TOGGLE()<CR>", { desc = "Toggle floating terminal" })

			-- Make <C-w> work inside terminal like normal window commands
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], { noremap = true, silent = true })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			-- setup gitsigns with default properties
			require("gitsigns").setup({
				current_line_blame = true,
			})
			require("scrollbar.handlers.gitsigns").setup()
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
	{
		"sindrets/diffview.nvim",
		-- config = function()
		--   keys = {
		--       {"<leader>Dc", "<cmd>set hidden<cr><cmd>DiffviewClose<cr><cmd>set nohidden<cr>", desc = "DiffViewClose"},
		--   }
		-- end,
	},
}
