return {
	-- {
	-- 	"mfussenegger/nvim-jdtls",
	-- },
	{
		"nvim-java/nvim-java",
		config = function()
			require("java").setup()
			vim.lsp.enable("jdtls")
			vim.lsp.config("jdtls", {
				settings = {
					java = {
						configuration = {
							runtimes = {
								{
									name = "Apple-JavaSE-17.0.16",
									path = "/Library/Java/JavaVirtualMachines/applejdk-17.0.16.8.1.jdk/Contents/Home",
									default = true,
								},
							},
						},
					},
				},
			})
		end,
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
