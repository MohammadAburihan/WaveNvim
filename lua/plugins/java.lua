return {
	{
		"mfussenegger/nvim-jdtls",
	},

	-- {
	-- 	"nvim-java/nvim-java",
	-- 	config = false,
	-- 	dependencies = {
	-- 		{
	-- 			"neovim/nvim-lspconfig",
	-- 			opts = {
	-- 				servers = {
	-- 					jdtls = {
	-- 						-- Optional: you can add jdtls-specific config here
	-- 					},
	-- 				},
	-- 				setup = {
	-- 					jdtls = function()
	-- 						local lombok_path = vim.fn.expand("~/.local/share/nvim/lombok/lombok.jar")
	-- 						require("java").setup({
	-- 							jvm_args = {
	-- 								"-javaagent:" .. lombok_path,
	-- 								"-Xbootclasspath/a:" .. lombok_path,
	-- 							},
	-- 							-- Optional: Add more config as needed
	-- 						})
	-- 						return true -- prevent lspconfig from setting up jdtls again
	-- 					end,
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },
}
