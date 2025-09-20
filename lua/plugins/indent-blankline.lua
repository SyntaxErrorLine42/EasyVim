return {
	event = { "BufReadPre", "BufNewFile" }, -- lazy-loads before reading a buffer
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {
		scope = { -- Remove underlines under highlighted sections of the code cuz they ugly
			show_start = false,
			show_end = false,
		},
	},
}
