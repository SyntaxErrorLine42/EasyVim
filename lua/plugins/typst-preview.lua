return {
	"chomosuke/typst-preview.nvim",
	ft = "typst",
	version = "1.*",
	opts = {
		open_cmd = "brave-browser %s >/dev/null 2>&1", -- You can comment this line out and it will use your default xdg-open
	}, -- lazy.nvim will implicitly calls `setup {}`
}
