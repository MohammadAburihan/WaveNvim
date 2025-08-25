return {
	{
		"mason-org/mason.nvim",
		-- version = "^1.0.0",
		config = function()
			require("mason").setup()
			local mason_registry = require("mason-registry")
			local packages = {
				"clangd",
				"lua-language-server",
				"svlangserver",
				"verible",
				"jdtls",
				"clang-format",
				"codelldb",
				"google-java-format",
				"htmlbeautifier",
				"java-debug-adapter",
				"java-test",
				"stylua",
				"xmlformatter",
				"html-lsp",
			}
			for _, pkg in ipairs(packages) do
				local ok, p = pcall(mason_registry.get_package, pkg)
				if ok and not p:is_installed() then
					p:install()
				end
			end
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		-- version = "^1.0.0",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"lua_ls",
					"svlangserver",
					"verible",
					"jdtls",
					"html",
				},
				-- handlers = {
				-- 	jdtls = function() end,
				-- },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		-- opts = {
		-- 	-- make sure mason installs the server
		-- 	servers = {
		-- 		jdtls = {},
		-- 	},
		-- 	setup = {
		-- 		jdtls = function()
		-- 			return true -- avoid duplicate servers
		-- 		end,
		-- 	},
		-- },
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
