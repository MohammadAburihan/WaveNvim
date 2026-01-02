return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"leoluz/nvim-dap-go",
			"theHamsta/nvim-dap-virtual-text",
			"mxsdev/nvim-dap-vscode-js",
			{
				"microsoft/vscode-js-debug",
				version = "1.x",
				build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
			},
			opts = function(_, opts)
				opts.ensure_installed = opts.ensure_installed or {}
				table.insert(opts.ensure_installed, "java-debug-adapter")
				table.insert(opts.ensure_installed, "java-test")
			end,
		},
		config = function()
			require("dapui").setup()
			require("dap-go").setup()

			local dap = require("dap")
			local utils = require("dap.utils")
			local dapui = require("dapui")
			-- local dapui = require("dapui")
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			})
			dap.adapters = {
				["pwa-node"] = {
					type = "server",
					host = "localhost",
					port = 8123,
					executable = {
						command = "js-debug-adapter",
						args = {
							"8123",
						},
					},
				},
			}
			dap.configurations["typescript"] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
					protocol = "inspector",
					console = "integratedTerminal",
				},
				{
					-- use nvim-dap-vscode-js's pwa-node debug adapter
					type = "pwa-node",
					-- attach to an already running node process with --inspect flag
					-- default port: 9222
					request = "attach",
					-- allows us to pick the process using a picker
					processId = require("dap.utils").pick_process,
					-- name of the debug action
					name = "Attach debugger to existing `node --inspect` process",
					-- for compiled languages like TypeScript or Svelte.js
					sourceMaps = true,
					-- resolve source maps in nested locations while ignoring node_modules
					resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
					-- path to src in vite based projects (and most other projects as well)
					cwd = "${workspaceFolder}/src",
					-- we don't want to debug code inside node_modules, so skip it!
					skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
				},
				{
					type = "pwa-chrome",
					name = "Launch Chrome to debug client",
					request = "launch",
					url = "http://localhost:5173",
					sourceMaps = true,
					protocol = "inspector",
					port = 9222,
					webRoot = "${workspaceFolder}/src",
					-- skip files from vite's hmr
					skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to process ID",
					processId = utils.pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					name = "Debug Main Process (Electron)",
					type = "pwa-node",
					request = "launch",
					program = "${workspaceFolder}/node_modules/.bin/electron",
					args = {
						"${workspaceFolder}/dist/index.js",
					},
					outFiles = {
						"${workspaceFolder}/dist/*.js",
					},
					resolveSourceMapLocations = {
						"${workspaceFolder}/dist/**/*.js",
						"${workspaceFolder}/dist/*.js",
					},
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
					protocol = "inspector",
					console = "integratedTerminal",
				},
				{
					name = "Compile & Debug Main Process (Electron)",
					type = custom_adapter,
					request = "launch",
					preLaunchTask = "npm run build-ts",
					program = "${workspaceFolder}/node_modules/.bin/electron",
					args = {
						"${workspaceFolder}/dist/index.js",
					},
					outFiles = {
						"${workspaceFolder}/dist/*.js",
					},
					resolveSourceMapLocations = {
						"${workspaceFolder}/dist/**/*.js",
						"${workspaceFolder}/dist/*.js",
					},
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
					protocol = "inspector",
					console = "integratedTerminal",
				},
			}
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
			dap.configurations.java = {
				{
					type = "java",
					request = "attach",
					name = "Debug (Attach) - Remote",
					hostName = "127.0.0.1",
					port = 5005,
				},
			}
			dap.adapters.java = {
				type = "server",
				host = "127.0.0.1",
				port = 5005,
			}

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue" })
			require("which-key").add({ { "<leader>d", group = "Debugging" } })

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
	{
		"rcarriga/cmp-dap",
	},
}
