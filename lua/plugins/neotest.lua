return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"rcasia/neotest-java",
			"andythigpen/nvim-coverage", -- ✅ Coverage support
			"nvim-neotest/neotest-jest",
		},
		config = function()
			require("which-key").add({ { "<leader>m", group = "Testing" } })

			vim.keymap.set("n", "<Leader>mr", function()
				require("neotest").run.run()
			end, { desc = "Run Test" })
			vim.keymap.set("n", "<Leader>ms", function()
				require("neotest").run.stop()
			end, { desc = "Stop Test" })
			vim.keymap.set("n", "<Leader>mo", function()
				require("neotest").output.open()
			end, { desc = "Open Output" })
			vim.keymap.set("n", "<Leader>mO", function()
				require("neotest").output.open({ enter = true })
			end, { desc = "Open and Focus Output" })
			vim.keymap.set("n", "<Leader>mi", function()
				require("neotest").summary.toggle()
			end, { desc = "Toggle Summary" })
			vim.keymap.set("n", "<Leader>mf", function()
				require("neotest").run.run(vim.fn.expand("%"))
			end, { desc = "Run File Test" })
			vim.keymap.set("n", "[n", function()
				require("neotest").jump.prev({ status = "failed" })
			end)
			vim.keymap.set("n", "]n", function()
				require("neotest").jump.next({ status = "failed" })
			end)

			require("neotest").setup({
				adapters = {
					require("neotest-java")({
						ignore_wrapper = false,
					}),
					require("neotest-jest")({
						jestCommand = "npm test --", -- Or "ng test" depending on setup
						jestArguments = function(defaultArguments, context)
							return defaultArguments
						end,
						jestConfigFile = "custom.jest.config.ts",
						env = { CI = true },
						cwd = function(path)
							return vim.fn.getcwd()
						end,
						isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
					}),
				},
			})

			-- ✅ Coverage setup
			require("coverage").setup({
				auto_reload = true,
				load_coverage_cb = function(module)
					print("Loaded coverage report for " .. module)
				end,
			})

			-- Optional keymaps for coverage toggling
			vim.keymap.set("n", "<leader>mc", function()
				require("coverage").load(true) -- true = show after load
			end, { desc = "Load Coverage" })

			vim.keymap.set("n", "<leader>mC", function()
				require("coverage").clear()
			end, { desc = "Clear Coverage" })
		end,
	},
}
