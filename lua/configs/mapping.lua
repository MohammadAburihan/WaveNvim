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
