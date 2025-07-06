return {
	{
		-- "nvimtools/none-ls.nvim",
		-- dependencies = {
		-- 	"nvimtools/none-ls-extras.nvim",
		-- },
		-- event = "VeryLazy",
		-- opts = function()
		-- 	return require("configs.null-ls"),
		-- 		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Formatting" })
		-- end,
		-- require("which-key").add({ { "<leader>g", group = "Formatting" } }),
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					svelte = { { "prettierd", "prettier", stop_after_first = true } },
					astro = { { "prettierd", "prettier", stop_after_first = true } },
					javascript = { { "prettierd", "prettier", stop_after_first = true } },
					typescript = { { "prettierd", "prettier", stop_after_first = true } },
					javascriptreact = { { "prettierd", "prettier", stop_after_first = true } },
					typescriptreact = { { "prettierd", "prettier", stop_after_first = true } },
					json = { { "prettierd", "prettier", stop_after_first = true } },
					graphql = { { "prettierd", "prettier", stop_after_first = true } },
					java = { "google-java-format" },
					kotlin = { "ktlint" },
					ruby = { "standardrb" },
					markdown = { { "prettierd", "prettier", stop_after_first = true } },
					erb = { "htmlbeautifier" },
					html = { "htmlbeautifier" },
					bash = { "beautysh" },
					proto = { "buf" },
					rust = { "rustfmt" },
					yaml = { "yamlfix" },
					toml = { "taplo" },
					css = { { "prettierd", "prettier", stop_after_first = true } },
					scss = { { "prettierd", "prettier", stop_after_first = true } },
					sh = { "shellcheck" },
					go = { "gofmt" },
					xml = { "xmllint" },
				},
				format_on_save = {
					lsp_fallback = true,
					timeout_ms = 1000,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>ft", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file or range (in visual mode)" })

			vim.diagnostic.config({
				virtual_text = true, -- Show inline text
				signs = true, -- Show signs in the gutter
				underline = true, -- Underline problematic code
				update_in_insert = false, -- Don't update diagnostics while typing (can be true if preferred)
				severity_sort = true,
			})
		end,
	},
}
