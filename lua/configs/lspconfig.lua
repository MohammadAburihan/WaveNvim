local lspconfig = require("lspconfig")
local servers = { "svlangserver", "lua_ls", "asm_lsp" }
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
	cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
	init_options = {
		fallbackFlags = { "-std=c++23" },
		compileFlags = {},
	},
})

if not require("lspconfig.configs").hdl_checker then
	require("lspconfig.configs").hdl_checker = {
		default_config = {
			cmd = { "hdl_checker", "--lsp" },
			filetypes = { "vhdl", "verilog", "systemverilog" },
			root_dir = function(fname)
				-- will look for the .hdl_checker.config file in parent directory, a
				-- .git directory, or else use the current directory, in that order.
				local util = require("lspconfig").util
				return util.root_pattern(".hdl_checker.config")(fname)
					or util.find_git_ancestor(fname)
					or util.path.dirname(fname)
			end,
			settings = {},
		},
	}
end

-- lspconfig.omnisharp.setup({
-- 	cmd = { "dotnet", "/root/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
-- 	filetypes = { "csharp" },
-- 	settings = {
-- 		FormattingOptions = {
-- 			EnableEditorConfigSupport = true,
-- 			OrganizeImports = nil,
-- 		},
-- 		MsBuild = {
-- 			LoadProjectsOnDemand = nil,
-- 		},
-- 		RoslynExtensionsOptions = {
-- 			EnableAnalyzersSupport = nil,
-- 			EnableImportCompletion = nil,
-- 			AnalyzeOpenDocumentsOnly = nil,
-- 		},
-- 		Sdk = {
-- 			IncludePrereleases = true,
-- 		},
-- 	},
-- })
-- lspconfig.omnisharp_mono.setup({
-- 	filetypes = { "csharp" },
-- })
--
-- require("lspconfig").hdl_checker.setup({})
