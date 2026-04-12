-- IntelliJ-style formatting
vim.bo.expandtab = true -- Use spaces instead of tabs
vim.bo.shiftwidth = 4 -- Number of spaces for each indent
vim.bo.tabstop = 4 -- Number of spaces a tab counts for
vim.bo.softtabstop = 4 -- Spaces inserted/deleted with Tab/BS
vim.bo.smartindent = true -- Enable smart indenting
vim.bo.autoindent = true -- Auto-indent new lines

-- jdtls is managed by nvim-java plugin (lua/plugins/java.lua)
-- Use LSP code actions for refactoring (organize imports, extract variable, etc.)
-- These are all available via <leader>ca (code action)

vim.keymap.set("n", "<leader>co", function()
	vim.lsp.buf.code_action({
		context = { only = { "source.organizeImports" } },
		apply = true,
	})
end, { desc = "Organize Imports", buffer = true })

-- Configure DAP for Java debugging (via nvim-java)
vim.keymap.set("n", "<leader>dm", function()
	local ok, java = pcall(require, "java")
	if ok and java.dap then
		java.dap.config_dap()
		vim.notify("Configured Java DAP", vim.log.levels.INFO)
	else
		vim.notify("nvim-java DAP not available", vim.log.levels.WARN)
	end
end, { desc = "Configure Java DAP", buffer = true })
