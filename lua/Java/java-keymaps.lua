-- lua/config/keymaps.lua (add these to your existing keymaps file)
-- or create lua/plugins/java-keymaps.lua

local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

-- Java-specific keymaps (only active for Java files)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local opts = { buffer = bufnr, silent = true }

		-- LSP keymaps
		map("n", "gD", vim.lsp.buf.declaration, opts)
		map("n", "gd", vim.lsp.buf.definition, opts)
		map("n", "K", vim.lsp.buf.hover, opts)
		map("n", "gi", vim.lsp.buf.implementation, opts)
		map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		map("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		map("n", "<space>D", vim.lsp.buf.type_definition, opts)
		map("n", "<space>rn", vim.lsp.buf.rename, opts)
		map({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		map("n", "gr", vim.lsp.buf.references, opts)
		map("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)

		-- Java-specific commands
		map("n", "<leader>jc", function()
			require("java").compile()
		end, { desc = "Compile Java project", buffer = bufnr })

		map("n", "<leader>jr", function()
			require("java").run()
		end, { desc = "Run Java project", buffer = bufnr })

		map("n", "<leader>jt", function()
			require("java").test.run_current_class()
		end, { desc = "Run current test class", buffer = bufnr })

		map("n", "<leader>jT", function()
			require("java").test.run_current_method()
		end, { desc = "Run current test method", buffer = bufnr })

		map("n", "<leader>jd", function()
			require("java").test.debug_current_class()
		end, { desc = "Debug current test class", buffer = bufnr })

		map("n", "<leader>jD", function()
			require("java").test.debug_current_method()
		end, { desc = "Debug current test method", buffer = bufnr })

		map("n", "<leader>js", function()
			require("java").spring_boot.run()
		end, { desc = "Run Spring Boot application", buffer = bufnr })

		map("n", "<leader>jS", function()
			require("java").spring_boot.stop()
		end, { desc = "Stop Spring Boot application", buffer = bufnr })

		-- Code generation shortcuts
		map("n", "<leader>jg", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.generate" } },
				apply = true,
			})
		end, { desc = "Generate code", buffer = bufnr })

		map("n", "<leader>jo", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" } },
				apply = true,
			})
		end, { desc = "Organize imports", buffer = bufnr })

		-- Extract variable/method
		map("v", "<leader>jv", function()
			vim.lsp.buf.code_action({
				context = { only = { "refactor.extract.variable" } },
				apply = true,
			})
		end, { desc = "Extract variable", buffer = bufnr })

		map("v", "<leader>jm", function()
			vim.lsp.buf.code_action({
				context = { only = { "refactor.extract.method" } },
				apply = true,
			})
		end, { desc = "Extract method", buffer = bufnr })

		-- DAP (Debug Adapter Protocol) keymaps
		-- map("n", "<F5>", function()
		-- 	require("dap").continue()
		-- end, { desc = "Debug: Start/Continue", buffer = bufnr })

		map("n", "<F10>", function()
			require("dap").step_over()
		end, { desc = "Debug: Step Over", buffer = bufnr })

		map("n", "<F11>", function()
			require("dap").step_into()
		end, { desc = "Debug: Step Into", buffer = bufnr })

		map("n", "<F12>", function()
			require("dap").step_out()
		end, { desc = "Debug: Step Out", buffer = bufnr })

		map("n", "<leader>db", function()
			require("dap").toggle_breakpoint()
		end, { desc = "Debug: Toggle Breakpoint", buffer = bufnr })

		map("n", "<leader>dB", function()
			require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Conditional Breakpoint", buffer = bufnr })

		map("n", "<leader>dr", function()
			require("dap").repl.open()
		end, { desc = "Debug: Open REPL", buffer = bufnr })

		map("n", "<leader>dl", function()
			require("dap").run_last()
		end, { desc = "Debug: Run Last", buffer = bufnr })

		-- Telescope integration (if you use telescope)
		if pcall(require, "telescope") then
			map("n", "<leader>fj", function()
				require("telescope").extensions.java.tests()
			end, { desc = "Find Java tests", buffer = bufnr })
		end
	end,
})

-- Global Java keymaps (work from any buffer)
map("n", "<leader>Jc", function()
	require("java").compile()
end, { desc = "Compile Java project" })

map("n", "<leader>Jr", function()
	require("java").run()
end, { desc = "Run Java project" })

map("n", "<leader>Jt", function()
	require("java").test.run_all()
end, { desc = "Run all tests" })

map("n", "<leader>Js", function()
	require("java").spring_boot.run()
end, { desc = "Run Spring Boot application" })

map("n", "<leader>JS", function()
	require("java").spring_boot.stop()
end, { desc = "Stop Spring Boot application" })
