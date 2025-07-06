return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				opts = {
					ensure_installed = {
						"clangd",
						"lua_ls",
						"svlangserver",
						"verible",
						"jdtls",
						"clang-format",
						"codelldb",
						"google-java-format",
						"htmlbeautifier",
						"java-debug-adapter",
						"java-test",
						"lua-language-server",
						"stylua",
						"xmlformatter",
						"html-lsp",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"lua_ls",
					"svlangserver",
					"verible",
					"jdtls",
					"clang-format",
					"codelldb",
					"google-java-format",
					"htmlbeautifier",
					"java-debug-adapter",
					"java-test",
					"lua-language-server",
					"stylua",
					"xmlformatter",
					"html-lsp",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			-- make sure mason installs the server
			servers = {
				jdtls = {},
			},
			setup = {
				jdtls = function()
					return true -- avoid duplicate servers
				end,
			},
		},
		config = function()
			require("configs.lspconfig")
			vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "lsp Hover" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
			vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "lsp declaration" })
			vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "lsp Definition" })
		end,
	},
	{
		"tamago324/nlsp-settings.nvim",
	},
}
