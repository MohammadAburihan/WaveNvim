return {
	-- {
	-- 	"mfussenegger/nvim-jdtls",
	-- },
	{
		"nvim-java/nvim-java",
    ft = "java",
    lazy = true,
    dependencies = {
      "JavaHello/spring-boot.nvim",
      "JavaHello/java-deps.nvim",
    },
		config = function()
      require("java-deps").setup({})
			require("java").setup()

			-- Config MUST come before enable for settings to apply
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
			vim.lsp.enable("jdtls")

			-- Auto-configure DAP when jdtls finishes initializing
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.name == "jdtls" then
						-- Wait for jdtls to finish indexing before configuring DAP
						vim.defer_fn(function()
							local ok, java = pcall(require, "java")
							if ok and java.dap then
								local dap_ok, err = pcall(java.dap.config_dap)
								if dap_ok then
									vim.notify("Java DAP configured", vim.log.levels.INFO)
								end
							end
						end, 5000)
					end
				end,
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
