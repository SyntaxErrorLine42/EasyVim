return {
	"chomosuke/typst-preview.nvim",
	ft = "typst",
	version = "1.*",
	keys = {
		{ "<Leader>ta", "<cmd>TypstPreviewToggle<cr>", ft = "typst", desc = "Typst Preview" },
	},
	opts = {
		open_cmd = "brave-browser --app=%s >/dev/null 2>&1",
	},
}
