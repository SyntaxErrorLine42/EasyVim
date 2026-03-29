return {
	"kdheepak/lazygit.nvim",
	cmd = "LazyGit",
	keys = {
		{ "<leader>lg", ":LazyGit<CR>", desc = "Open Lazygit" },
	},
	init = function()
		vim.g.lazygit_floating_window_scaling_factor = 1.0 -- fullscreen
	end,
}
