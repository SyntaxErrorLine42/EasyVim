return {
	"sindrets/diffview.nvim",
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewFileHistory",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
		"DiffviewRefresh",
	},
	config = function()
		require("diffview").setup({
			view = {
				merge_tool = {
					layout = "diff3_mixed",
					disable_diagnostics = true,
				},
			},
		})
	end,
}
