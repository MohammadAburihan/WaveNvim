return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({})

		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		vim.keymap.set("n", "<leader>ja", function()
			harpoon:list():add()
		end, { desc = "[HARPOON] Add file" })
		vim.keymap.set("n", "<leader>jf", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "[HARPOON] Show quick menu" })
		vim.keymap.set("n", "<leader>jt", function()
			toggle_telescope(harpoon:list())
		end, { desc = "[HARPOON] Show Telescope" })
	end,
}
