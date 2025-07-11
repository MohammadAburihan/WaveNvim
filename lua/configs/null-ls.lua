local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
vim.diagnostic.config({
	virtual_text = true, -- Show inline text
	signs = true, -- Show signs in the gutter
	underline = true, -- Underline problematic code
	update_in_insert = false, -- Don't update diagnostics while typing (can be true if preferred)
	severity_sort = true,
})

local opts = {
	sources = {
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.formatting.verible_verilog_format,
		-- null_ls.builtins.formatting.csharpier,
		-- null_ls.builtins.diagnostics.verilator,
		-- require("none-ls.diagnostics.verilator"),
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
}

return opts
