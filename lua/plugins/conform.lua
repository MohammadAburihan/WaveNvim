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
		"MunifTanjim/prettier.nvim",
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					svelte = { "prettierd", "prettier" },
					astro = { "prettierd", "prettier" },
					-- javascript = { "prettierd", "prettier" },
					-- typescript = { "eslint_d" },
					-- javascriptreact = { "prettierd", "prettier" },
					-- typescriptreact = { "eslint_d" },
					json = { "prettierd", "prettier" },
					graphql = { "prettierd", "prettier" },
					kotlin = { "ktlint" },
					ruby = { "standardrb" },
					markdown = { "prettierd", "prettier" },
					erb = { "htmlbeautifier" },
					-- html = { "htmlbeautifier" },
					html = { "prettier" },
					bash = { "beautysh" },
					proto = { "buf" },
					rust = { "rustfmt" },
					yaml = { "yamlfix" },
					toml = { "taplo" },
					css = { "prettierd", "prettier" },
					scss = { "prettierd", "prettier" },
					sh = { "shellcheck" },
					go = { "gofmt" },
					xml = { "prettier" },
				},
				format_on_save = {
					-- lsp_fallback = function(bufnr)
					-- 	-- Disable fallback for HTML
					-- 	local ft = vim.bo[bufnr].filetype
					-- 	return ft ~= "html"
					-- end,
					lsp_fallback = true,
					timeout_ms = 1000,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>ft", function()
				conform.format({
					-- lsp_fallback = function(bufnr)
					-- 	-- Disable fallback for HTML
					-- 	local ft = vim.bo[bufnr].filetype
					-- 	return ft ~= "html"
					-- end,
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
