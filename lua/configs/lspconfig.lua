local lspconfig = require("lspconfig")
local servers = { "svlangserver", "lua_ls", "csharp_ls" }
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local nlspsettings = require("nlspsettings")
local on_attach = function(client, bufnr)
	require("nlspsettings").update_settings(client.name)
end

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

nlspsettings.setup({})

lspconfig.clangd.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose", "--offset-encoding=utf-16" },
	init_options = {
		fallbackFlags = { "-std=c++23" },
		compileFlags = {},
	},
})

lspconfig.asm_lsp.setup = {
	capabilities = capabilities,
	on_attach = on_attach,
	default_config = {
		cmd = { "asm-lsp" },
		filetypes = { "asm", "s" },
		root_dir = lspconfig.util.root_pattern(".git", "."),
		settings = {},
	},
}
