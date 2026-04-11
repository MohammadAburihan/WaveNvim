return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"dmmulroy/tsc.nvim",
		config = function()
			require("tsc").setup({
				-- Your config here
			})
		end,
	},
}
