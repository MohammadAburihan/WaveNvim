return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				opts = {
					ensure_installed = {
						"clang-format",
						"codelldb",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "lua_ls", "svlangserver", "svls", "verible", "asm_lsp" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
			vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "lsp Hover" })
			vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "lsp Definition" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
		end,
	},
}
