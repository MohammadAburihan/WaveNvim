return {
	{
		"echasnovski/mini.indentscope", -- For indent perantheses and color it
		version = false, -- wait till new 0.7.0 release to put it back on semver
		opts = {
			-- symbol = '╎',
			symbol = "│",
			options = { try_as_border = true },
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			scope = { enabled = false },
			indent = { char = "│" },
		},
	},
}
