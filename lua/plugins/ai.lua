return {
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		opts = {
			-- Route Claude Code through the Apple bridge proxy (Anthropic-compatible endpoint)
			env = {
				ANTHROPIC_BASE_URL = "http://localhost:11211/api/anthropic",
				ANTHROPIC_AUTH_TOKEN = "dummy-key",
				ANTHROPIC_MODEL = "aws:anthropic.claude-opus-4-8",
				ANTHROPIC_SMALL_FAST_MODEL = "aws:anthropic.claude-sonnet-4-6",
			},
		},
		keys = {
			{ "<leader>ao", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>aO", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<leader>as",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
			},
			-- Diff management
			{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
		init = function()
			-- Hide NvimTree while reviewing a Claude diff, restore it once answered.
			local group = vim.api.nvim_create_augroup("ClaudeDiffNvimTree", { clear = true })
			local tree_was_open = false

			local function tree_api()
				local ok, api = pcall(require, "nvim-tree.api")
				if ok then
					return api
				end
			end

			-- Proposed diff buffers are named "... (proposed)"; close the tree when one opens.
			vim.api.nvim_create_autocmd("BufWinEnter", {
				group = group,
				callback = function(args)
					if not vim.api.nvim_buf_get_name(args.buf):match("proposed%)$") then
						return
					end
					local api = tree_api()
					if api and api.tree.is_visible() then
						tree_was_open = true
						vim.schedule(function()
							api.tree.close()
						end)
					end
				end,
			})

			-- The proposed buffer is wiped on accept/deny; reopen the tree if we closed it.
			vim.api.nvim_create_autocmd({ "BufWipeout", "BufDelete" }, {
				group = group,
				callback = function(args)
					if not vim.api.nvim_buf_get_name(args.buf):match("proposed%)$") then
						return
					end
					if not tree_was_open then
						return
					end
					tree_was_open = false
					local api = tree_api()
					if not api then
						return
					end
					vim.schedule(function()
						local cur = vim.api.nvim_get_current_win()
						api.tree.open()
						if vim.api.nvim_win_is_valid(cur) then
							pcall(vim.api.nvim_set_current_win, cur)
						end
					end)
				end,
			})
		end,
	},
}
