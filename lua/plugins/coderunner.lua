return {
	{
		"CRAG666/code_runner.nvim",
		config = function()
			require("code_runner").setup({
				filetype = {
					java = {
						"cd $dir &&",
						"javac $fileName &&",
						"java $fileNameWithoutExt",
					},
					python = "python3 -u",
					typescript = "deno run",
					rust = {
						"cd $dir &&",
						"rustc $fileName &&",
						"$dir/$fileNameWithoutExt",
					},
					c = function(...)
						c_base = {
							"cd $dir &&",
							"gcc $fileName -o",
							"/tmp/$fileNameWithoutExt",
						}
						local c_exec = {
							"&& /tmp/$fileNameWithoutExt &&",
							"rm /tmp/$fileNameWithoutExt",
						}
						vim.ui.input({ prompt = "Add more args:" }, function(input)
							c_base[4] = input
							vim.print(vim.tbl_extend("force", c_base, c_exec))
							require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
						end)
					end,
				},
			})
			require("which-key").add({ { "<leader>r", group = "CodeRunner" } })
			vim.keymap.set("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = false })
			vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false })
			vim.keymap.set("n", "<leader>rft", ":RunFile tab<CR>", { noremap = true, silent = false })
			vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false })
			vim.keymap.set("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = false })
			vim.keymap.set("n", "<leader>crf", ":CRFiletype<CR>", { noremap = true, silent = false })
			vim.keymap.set("n", "<leader>crp", ":CRProjects<CR>", { noremap = true, silent = false })
		end,
	},
	{
		"michaelb/sniprun",
		branch = "master",

		build = "sh install.sh",
		-- do 'sh install.sh 1' if you want to force compile locally
		-- (instead of fetching a binary from the github release). Requires Rust >= 1.65

		config = function()
			require("sniprun").setup({
				-- your options
			})
		end,
	},
}
