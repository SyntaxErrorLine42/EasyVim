-- I'm are using base46 theme engine, I REALLY reccomend checking out https://github.com/NvChad/base46 and getting to learn how base46 works in details because you will get very good in customizing your neovim UI
return {
	"nvim-lua/plenary.nvim",
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- {
	-- 	"nvchad/ui",
	--    enabled = false,
	-- 	config = function()
	-- 		require("nvchad")
	-- 	end,
	-- },

	{
		"nvchad/base46",
		lazy = false,
		build = function()
			require("base46").load_all_highlights()
		end,
	},

	-- "nvchad/volt", -- optional, needed for theme switcher
	-- or just use Telescope themes
}
