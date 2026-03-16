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
		-- line between function scope and dots in spaces
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = { enabled = false },
			indent = { char = "│" },
		},
		-- config = function(_, opts)
		-- 	require("ibl").setup(opts)
		--
		-- 	-- show spaces as dots (Neovim setting)
		-- 	vim.opt.list = true
		-- 	vim.opt.listchars:append({
		-- 		space = "·",
		-- 		trail = "·",
		-- 		nbsp = "␣",
		-- 	  tab = "..",
		-- 	})
		-- end,
	},
}
