return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			-- local dapui = require("dapui")

			-- dapui.setup()
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			}

			dap.configurations.cpp = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
				{
					name = "Select and attach to process",
					type = "gdb",
					request = "attach",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					pid = function()
						local name = vim.fn.input("Executable name (filter): ")
						return require("dap.utils").pick_process({ filter = name })
					end,
					cwd = "${workspaceFolder}",
				},
				{
					name = "Attach to gdbserver :1234",
					type = "gdb",
					request = "attach",
					target = "localhost:1234",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
			}

			-- dap.listeners.before.attach.dapui_config = function()
			-- 	dapui.open()
			-- end
			-- dap.listeners.before.launch.dapui_config = function()
			-- 	dapui.open()
			-- end
			-- dap.listeners.before.event_terminated.dapui_config = function()
			-- 	dapui.close()
			-- end
			-- dap.listeners.before.event_exited.dapui_config = function()
			-- 	dapui.close()
			-- end

			vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue" })

			-- Lua version of Debug for C++ files
			local function Debug()
				-- Save all files
				vim.cmd("wa")

				local file = vim.fn.expand("%")
				if file:match("%.cpp$") then
					local exe_name = file:gsub("%.cpp$", "")
					local path = vim.fn.expand("%:p:h")
					local compile_cmd = string.format("g++ -DLOCAL -std=c++23 --debug -o %s %s", exe_name, file)
					os.execute(compile_cmd)
				else
					print("Not a C++ file")
				end
			end

			-- Map F5 to run the function for C++ files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "cpp",
				callback = function()
					vim.keymap.set("n", "<leader>dd", Debug, { buffer = true, desc = "Debug execute" })
				end,
			})
		end,
	},
}
