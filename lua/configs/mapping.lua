local ok, wk = pcall(require, "which-key")

if not ok then
	return
end

-- all key mapping write in here
vim.keymap.set("n", "<C-K>", "k<C-Y>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-J>", "j<C-E>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		function get_spring_boot_runner(profile, debug)
			local debug_param = ""
			if debug then
				debug_param =
					' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
			end

			local profile_param = ""
			if profile then
				profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
			end

			return "mvn spring-boot:run " .. profile_param .. debug_param
		end

		function run_spring_boot(debug)
			vim.cmd("term " .. get_spring_boot_runner(method_name, debug))
		end

		vim.keymap.set("n", "<F9>", function()
			run_spring_boot()
		end)
		vim.keymap.set("n", "<F10>", function()
			run_spring_boot(true)
		end)
	end,
})

wk.add({
	-- Debug
	{ "<leader>d", group = "Debug" },
	{ "<leader>dR", "<cmd>lua require'dap'.run()<cr>", desc = "[DAP] Run" },
	{ "<leader>de", "<cmd>lua require'dap'.run_last()<cr>", desc = "[DAP] Debug last" },
	{ "<leader>dE", "<cmd>Telescope dap configurations<cr>", desc = "[DAP] Show debug configurations" },
	{ "<leader>dk", "<cmd>DapTerminate<cr>", desc = "[DAP] Terminate" },
	{ "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "[DAP] Toggle breakpoint" },
	{
		"<leader>dB",
		"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
		desc = "[DAP] Set conditional breakpoint",
	},
	{
		"<leader>dl",
		"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
		desc = "[DAP] Set log point breakpoint",
	},
	{ "<leader>dc", "<cmd>DapContinue<cr>", desc = "[DAP] Continue" },
	{ "<leader>dv", "<cmd>DapStepOver<cr>", desc = "[DAP] Step oVer" },
	{ "<leader>di", "<cmd>DapStepInto<cr>", desc = "[DAP] Step Into" },
	{ "<leader>do", "<cmd>DapStepOut<cr>", desc = "[DAP] Step Out" },
	{ "<leader>dx", "<cmd>lua require('dapui').eval()<cr>", desc = "[DAPUI] eXecute}" },
	{ "<leader>dp", "<cmd>DapToggleRepl<cr>", desc = "[DAP] Repl open" },
	{ "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", desc = "[DAPUI] Toggle debugging UI" },
	{ "<leader>ds", "<cmd>Telescope dap list_breakpoints<cr>", desc = "[TELESCOPE DAP] Show all breakpoints" },
	{ "<leader>dw", "<cmd>Telescope dap variables<cr>", desc = "[TELESCOPE DAP] Wariables" },

	-- Jumps/Marks
	{ "<leader>j", group = "[Jumps]" },
	{ "<leader>jk", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "[HARPOON] Show quick menu" },
	{ "<leader>ja", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "[HARPOON] Add file" },
})
