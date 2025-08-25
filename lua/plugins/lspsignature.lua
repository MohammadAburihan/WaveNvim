return {
	-- Show function signature when you type
	"ray-x/lsp_signature.nvim",
	config = function()
		require("configs.lspsignatureConfigs")
		-- require("lsp_signature").setup(M)
		-- require("lsp_signature").on_attach(M, bufnr)
	end,
}
