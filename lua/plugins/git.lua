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

			-- pcall guards a benign error from gitsigns' :Gitsigns blame
			-- sync_cursors autocmd: when the float closes and focus returns to
			-- the source buffer, gitsigns tries to restore a saved cursor line
			-- that may be past the new buffer's end. See blame.lua:347.
			function _HORIZONTAL_TOGGLE()
				pcall(function()
					horizontal:toggle()
				end)
			end

			function _FLOAT_TOGGLE()
				pcall(function()
					floating:toggle()
				end)
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
			require("which-key").add({ { "<leader>g", group = "Git" } })
			require("which-key").add({ { "<leader>gh", group = "Git [H]unk" } })
			require("which-key").add({ { "<leader>gb", group = "Git [B]lame" } })
			vim.keymap.set("n", "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "[G]it [R]eset Hunk" })
			vim.keymap.set("n", "<leader>ghh", ":Gitsigns preview_hunk<CR>", { desc = "[G]it Preview [H]unk" })
			vim.keymap.set("n", "<leader>ghi", ":Gitsigns preview_hunk_inline<CR>", { desc = "[G]it Preview [H]unk Inline" })
			vim.keymap.set("n", "<leader>gbb", ":Gitsigns blame<CR>", { desc = "[G]it [B]lame" })
			vim.keymap.set("n", "<leader>gbl", ":Gitsigns blame_line<CR>", { desc = "[G]it [B]lame Line" })
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			-- :DiffviewClose runs :tabclose, which raises E445 ("Other window
			-- contains changes") when a diff window holds a modified buffer that
			-- can't be abandoned. Forcing 'hidden' on lets such buffers be hidden
			-- instead of blocking the close, and clearing the modified flag on
			-- diffview's own throwaway buffers (git index/HEAD views) covers the
			-- rest. Together they make the close succeed every time.
			local function safe_close()
				vim.o.hidden = true
				for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
					local buf = vim.api.nvim_win_get_buf(win)
					local name = vim.api.nvim_buf_get_name(buf)
					if name:match("^diffview://") or name:find("/.git/", 1, true) then
						pcall(function()
							vim.bo[buf].modified = false
						end)
					end
				end
				vim.cmd("DiffviewClose")
			end

			require("diffview").setup({
				hooks = {
					view_opened = function()
						vim.o.hidden = true
					end,
				},
				keymaps = {
					view = {
						{ "n", "q", safe_close, { desc = "Close Diffview" } },
					},
					file_panel = {
						{ "n", "q", safe_close, { desc = "Close Diffview" } },
					},
				},
			})

			require("which-key").add({ { "<leader>gd", group = "Diff View" } })
			vim.keymap.set("n", "<leader>gdo", "<cmd>DiffviewOpen<cr>", { desc = "Diff View Open" })
			vim.keymap.set("n", "<leader>gdc", safe_close, { desc = "Diff View Close" })
			vim.keymap.set("n", "<leader>gdh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diff File History" })
		end,
	},
}
