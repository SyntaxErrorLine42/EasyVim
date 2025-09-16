return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lualine").setup({
			options = {
				-- Check https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md for all themes
				theme = "horizon",
                globalstatus = true, -- This makes it so that the entire nvim session uses one LuaLine
                icons_enabled = true,
			},
		})
	end,
}
