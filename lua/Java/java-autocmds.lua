-- lua/config/autocmds.lua (add these to your existing autocmds file)
-- or create lua/plugins/java-autocmds.lua

local augroup = vim.api.nvim_create_augroup("JavaConfig", { clear = true })

-- Java file specific settings
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "java",
	callback = function()
		local opts = { buffer = true }

		-- Set Java-specific options
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.expandtab = true
		vim.bo.textwidth = 120

		-- Enable auto-formatting on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = 0,
			callback = function()
				-- Organize imports before formatting
				vim.lsp.buf.code_action({
					context = { only = { "source.organizeImports" } },
					apply = true,
				})
				-- Format the buffer
				vim.lsp.buf.format({ async = false })
			end,
		})

		-- Java-specific completion settings
		if vim.fn.exists(":CmpSetup") == 2 then
			require("cmp").setup.buffer({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})
		end
	end,
})

-- Auto-detect Java project root
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	pattern = "*.java",
	callback = function()
		local java = require("java")
		java.setup_project()
	end,
})

-- Spring Boot development server management
vim.api.nvim_create_autocmd("VimLeavePre", {
	group = augroup,
	callback = function()
		-- Stop Spring Boot server when leaving Vim
		if pcall(require, "java") then
			require("java").spring_boot.stop()
		end
	end,
})

-- Auto-start LSP for Java files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "java",
	callback = function()
		-- Ensure LSP is started
		vim.defer_fn(function()
			if vim.lsp.get_active_clients({ bufnr = 0, name = "jdtls" })[1] == nil then
				vim.cmd("LspStart jdtls")
			end
		end, 100)
	end,
})

-- Highlight Java annotations
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "java",
	callback = function()
		vim.cmd([[
      syntax match javaAnnotation "@\w\+\>" containedin=ALL
      highlight link javaAnnotation PreProc
    ]])
	end,
})

-- Custom commands for Java development
vim.api.nvim_create_user_command("JavaCompile", function()
	require("java").compile()
end, { desc = "Compile Java project" })

vim.api.nvim_create_user_command("JavaRun", function()
	require("java").run()
end, { desc = "Run Java project" })

vim.api.nvim_create_user_command("JavaTest", function(opts)
	if opts.args == "class" then
		require("java").test.run_current_class()
	elseif opts.args == "method" then
		require("java").test.run_current_method()
	else
		require("java").test.run_all()
	end
end, {
	desc = "Run Java tests",
	nargs = "?",
	complete = function()
		return { "class", "method" }
	end,
})

vim.api.nvim_create_user_command("JavaDebug", function(opts)
	if opts.args == "class" then
		require("java").test.debug_current_class()
	elseif opts.args == "method" then
		require("java").test.debug_current_method()
	else
		require("java").debug()
	end
end, {
	desc = "Debug Java application/tests",
	nargs = "?",
	complete = function()
		return { "class", "method" }
	end,
})

vim.api.nvim_create_user_command("SpringBootRun", function()
	require("java").spring_boot.run()
end, { desc = "Run Spring Boot application" })

vim.api.nvim_create_user_command("SpringBootStop", function()
	require("java").spring_boot.stop()
end, { desc = "Stop Spring Boot application" })

vim.api.nvim_create_user_command("JavaOrganizeImports", function()
	vim.lsp.buf.code_action({
		context = { only = { "source.organizeImports" } },
		apply = true,
	})
end, { desc = "Organize Java imports" })

vim.api.nvim_create_user_command("JavaGenerateCode", function()
	vim.lsp.buf.code_action({
		context = { only = { "source.generate" } },
		apply = true,
	})
end, { desc = "Generate Java code (getters, setters, etc.)" })

-- Performance optimization for large Java files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "java",
	callback = function()
		-- Increase timeout for large files
		vim.bo.synmaxcol = 200

		-- Disable certain features for very large files
		local file_size = vim.fn.getfsize(vim.fn.expand("%"))
		if file_size > 500000 then -- 500KB
			vim.bo.syntax = "off"
			vim.notify("Large Java file detected, syntax highlighting disabled for performance")
		end
	end,
})

-- Integration with other plugins
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "java",
	callback = function()
		-- Trouble.nvim integration
		if pcall(require, "trouble") then
			vim.keymap.set("n", "<leader>xx", function()
				require("trouble").toggle()
			end, { buffer = true, desc = "Toggle Trouble" })

			vim.keymap.set("n", "<leader>xw", function()
				require("trouble").toggle("workspace_diagnostics")
			end, { buffer = true, desc = "Workspace diagnostics" })

			vim.keymap.set("n", "<leader>xd", function()
				require("trouble").toggle("document_diagnostics")
			end, { buffer = true, desc = "Document diagnostics" })
		end

		-- nvim-tree integration
		if pcall(require, "nvim-tree.api") then
			vim.keymap.set("n", "<leader>e", function()
				require("nvim-tree.api").tree.toggle()
			end, { buffer = true, desc = "Toggle file explorer" })
		end

		-- Telescope integration
		if pcall(require, "telescope.builtin") then
			vim.keymap.set("n", "<leader>ff", function()
				require("telescope.builtin").find_files()
			end, { buffer = true, desc = "Find files" })

			vim.keymap.set("n", "<leader>fg", function()
				require("telescope.builtin").live_grep()
			end, { buffer = true, desc = "Live grep" })

			vim.keymap.set("n", "<leader>fb", function()
				require("telescope.builtin").buffers()
			end, { buffer = true, desc = "Find buffers" })
		end
	end,
})
