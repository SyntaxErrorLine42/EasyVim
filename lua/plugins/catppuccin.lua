return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = true,
	opts = {
		flavour = "mocha",
		auto_integrations = true,
	},
	-- I use base46 catppuccin, i just need this to import bufferline coloring
	-- config = function(_, opts)
	-- 	require("catppuccin").setup(opts)
	-- 	vim.cmd.colorscheme("catppuccin")
	-- end,
}
