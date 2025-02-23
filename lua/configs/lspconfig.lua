local lspconfig = require("lspconfig")
local servers = { "svlangserver", "lua_ls", "asm_lsp", "clangd" }
local capabilities = require("cmp_nvim_lsp").default_capabilities()
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		capabilities = capabilities,
	})
end
